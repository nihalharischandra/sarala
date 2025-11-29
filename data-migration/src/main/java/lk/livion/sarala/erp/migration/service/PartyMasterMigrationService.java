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
public class PartyMasterMigrationService {

    private final JdbcTemplate targetJdbcTemplate;
    private final BusyDataExtractorService extractorService;

    // BUSY MasterType for Party Master/Ledger (usually 2, but verify in your BUSY database)
    private static final int PARTY_MASTER_TYPE = 2;

    public PartyMasterMigrationService(
            @Qualifier("targetJdbcTemplate") JdbcTemplate targetJdbcTemplate,
            BusyDataExtractorService extractorService) {
        this.targetJdbcTemplate = targetJdbcTemplate;
        this.extractorService = extractorService;
    }

    @Transactional
    public int migratePartyMasters() {
        log.info("Starting Party Master migration from BUSY to Sarala");

        List<BusyMaster1DTO> busyParties = extractorService.extractMastersByType(PARTY_MASTER_TYPE);
        log.info("Found {} party masters in BUSY", busyParties.size());

        int migratedCount = 0;
        int errorCount = 0;

        for (BusyMaster1DTO busyParty : busyParties) {
            try {
                migratePartyMaster(busyParty);
                migratedCount++;

                if (migratedCount % 100 == 0) {
                    log.info("Migrated {} parties...", migratedCount);
                }
            } catch (Exception e) {
                errorCount++;
                log.error("Error migrating party: {} - {}", busyParty.getName(), e.getMessage());
            }
        }

        log.info("Party Master migration completed. Migrated: {}, Errors: {}", migratedCount, errorCount);
        return migratedCount;
    }

    private void migratePartyMaster(BusyMaster1DTO busy) {
        String sql = """
            INSERT INTO party_master (
                party_code, party_name, print_name,
                party_group_id, 
                primary_contact_person, mobile_number, email_address,
                gst_number, pan_number,
                credit_days, credit_limit, opening_balance,
                is_tds_applicable, is_tcs_applicable,
                is_active, is_blacklisted, blacklist_reason, remarks,
                created_by, created_at, updated_by, updated_at
            ) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)
            ON DUPLICATE KEY UPDATE
                party_name = VALUES(party_name),
                print_name = VALUES(print_name),
                credit_limit = VALUES(credit_limit),
                updated_by = VALUES(updated_by),
                updated_at = VALUES(updated_at)
            """;

        targetJdbcTemplate.update(sql,
            // Basic info
            busy.getAlias(),                          // party_code
            busy.getName(),                           // party_name
            busy.getPrintName(),                      // print_name

            // References
            busy.getCm1() > 0 ? busy.getCm1() : null, // party_group_id (CM1)

            // Contact info from C fields
            busy.getC7(),                             // primary_contact_person (C7)
            busy.getC3(),                             // mobile_number (C3)
            busy.getC4(),                             // email_address (C4)

            // Tax info
            busy.getC1(),                             // gst_number (C1)
            busy.getC2(),                             // pan_number (C2)

            // Credit management from I and D fields
            busy.getCreditDays(),                     // credit_days (I1)
            busy.getD2AsBigDecimal(),                 // credit_limit (D2)
            busy.getD1AsBigDecimal(),                 // opening_balance (D1)

            // Flags
            busy.getB1(),                             // is_tds_applicable (B1)
            busy.getB2(),                             // is_tcs_applicable (B2)

            // Status
            busy.isActive(),                          // is_active
            busy.getBlockedMaster(),                  // is_blacklisted
            busy.getBlockedNotes(),                   // blacklist_reason
            busy.getNotes1(),                         // remarks

            // Audit
            busy.getCreatedBy(),                      // created_by
            busy.getCreationTime(),                   // created_at
            busy.getModifiedBy(),                     // updated_by
            busy.getModificationTime()                // updated_at
        );
    }

    public String getMigrationStats() {
        int busyCount = extractorService.getMasterCountByType(PARTY_MASTER_TYPE);

        String countSql = "SELECT COUNT(*) FROM party_master";
        Integer saralaCount = targetJdbcTemplate.queryForObject(countSql, Integer.class);

        return String.format("BUSY Parties: %d, Sarala Parties: %d", busyCount, saralaCount != null ? saralaCount : 0);
    }
}

