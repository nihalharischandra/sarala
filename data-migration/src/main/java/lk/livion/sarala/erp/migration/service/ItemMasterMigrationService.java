package lk.livion.sarala.erp.migration.service;

import lk.livion.sarala.erp.migration.dto.BusyMaster1DTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Slf4j
@Service
public class ItemMasterMigrationService {

    private final JdbcTemplate targetJdbcTemplate;
    private final BusyDataExtractorService extractorService;

    // BUSY MasterType for Item Master (usually 1, but verify in your BUSY database)
    private static final int ITEM_MASTER_TYPE = 1;

    public ItemMasterMigrationService(
            @Qualifier("targetJdbcTemplate") JdbcTemplate targetJdbcTemplate,
            BusyDataExtractorService extractorService) {
        this.targetJdbcTemplate = targetJdbcTemplate;
        this.extractorService = extractorService;
    }

    @Transactional
    public int migrateItemMasters() {
        log.info("Starting Item Master migration from BUSY to Sarala");

        // Extract data from BUSY
        List<BusyMaster1DTO> busyItems = extractorService.extractMastersByType(ITEM_MASTER_TYPE);
        log.info("Found {} item masters in BUSY", busyItems.size());

        int migratedCount = 0;
        int errorCount = 0;

        for (BusyMaster1DTO busyItem : busyItems) {
            try {
                migrateItemMaster(busyItem);
                migratedCount++;

                if (migratedCount % 100 == 0) {
                    log.info("Migrated {} items...", migratedCount);
                }
            } catch (Exception e) {
                errorCount++;
                log.error("Error migrating item: {} - {}", busyItem.getName(), e.getMessage());
            }
        }

        log.info("Item Master migration completed. Migrated: {}, Errors: {}", migratedCount, errorCount);
        return migratedCount;
    }

    private void migrateItemMaster(BusyMaster1DTO busy) {
        String sql = """
            INSERT INTO item_master (
                item_code, item_name, print_name, item_description,
                item_group_id, primary_uom_id, secondary_uom_id, conversion_factor,
                purchase_rate, sale_rate, mrp, minimum_sale_rate, wholesale_rate,
                opening_stock, opening_stock_value, 
                reorder_level, reorder_quantity, minimum_stock_level, maximum_stock_level,
                is_batch_applicable, is_serial_number_applicable, is_taxable,
                hsn_code, barcode, sku,
                is_active, remarks,
                created_by, created_at, updated_by, updated_at
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ON DUPLICATE KEY UPDATE
                item_name = VALUES(item_name),
                print_name = VALUES(print_name),
                purchase_rate = VALUES(purchase_rate),
                sale_rate = VALUES(sale_rate),
                updated_by = VALUES(updated_by),
                updated_at = VALUES(updated_at)
            """;

        targetJdbcTemplate.update(sql,
            // Basic info
            busy.getAlias(),                          // item_code
            busy.getName(),                           // item_name
            busy.getPrintName(),                      // print_name
            busy.getMasterNotes(),                    // item_description

            // References - Map BUSY CM fields to our foreign keys
            busy.getCm1() > 0 ? busy.getCm1() : null, // item_group_id (CM1)
            busy.getCm4() > 0 ? busy.getCm4() : null, // primary_uom_id (CM4)
            busy.getCm5() > 0 ? busy.getCm5() : null, // secondary_uom_id (CM5)
            busy.getD12(),                            // conversion_factor (D12)

            // Pricing - Map BUSY D fields
            busy.getD1AsBigDecimal(),                 // purchase_rate (D1)
            busy.getD2AsBigDecimal(),                 // sale_rate (D2)
            busy.getD3AsBigDecimal(),                 // mrp (D3)
            //busy.getD4AsBigDecimal(),                 // minimum_sale_rate (D4)
            //busy.getD5AsBigDecimal(),                 // wholesale_rate (D5)

            // Stock - Map BUSY D fields
            busy.getD6(),                             // opening_stock (D6)
            //busy.getD7AsBigDecimal(),                 // opening_stock_value (D7)
            busy.getD8(),                             // reorder_level (D8)
            busy.getD9(),                             // reorder_quantity (D9)
            busy.getD10(),                            // minimum_stock_level (D10)
            busy.getD11(),                            // maximum_stock_level (D11)

            // Flags - Map BUSY B fields
            busy.getB1(),                             // is_batch_applicable (B1)
            busy.getB2(),                             // is_serial_number_applicable (B2)
            busy.getB4(),                             // is_taxable (B4)

            // Additional fields
            busy.getHsnCode(),                        // hsn_code
            busy.getC1(),                             // barcode (C1)
            busy.getC2(),                             // sku (C2)

            // Status
            busy.isActive(),                          // is_active (inverted from DeactiveMaster)
            busy.getNotes1(),                         // remarks

            // Audit
            busy.getCreatedBy(),                      // created_by
            busy.getCreationTime(),                   // created_at
            busy.getModifiedBy(),                     // updated_by
            busy.getModificationTime()                // updated_at
        );
    }

    /**
     * Get migration statistics
     */
    public String getMigrationStats() {
        int busyCount = extractorService.getMasterCountByType(ITEM_MASTER_TYPE);

        String countSql = "SELECT COUNT(*) FROM item_master";
        Integer saralaCount = targetJdbcTemplate.queryForObject(countSql, Integer.class);

        return String.format("BUSY Items: %d, Sarala Items: %d", busyCount, saralaCount != null ? saralaCount : 0);
    }
}

