package lk.livion.sarala.erp.migration.service;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

@Slf4j
@Service
@RequiredArgsConstructor
public class MigrationOrchestratorService {

    private final BusyDataExtractorService extractorService;
    private final ItemMasterMigrationService itemMigrationService;
    private final PartyMasterMigrationService partyMigrationService;

    /**
     * Execute complete migration
     */
    public MigrationResult executeFullMigration() {
        log.info("========================================");
        log.info("Starting BUSY to Sarala Full Migration");
        log.info("Started at: {}", LocalDateTime.now().format(DateTimeFormatter.ISO_LOCAL_DATE_TIME));
        log.info("========================================");

        MigrationResult result = new MigrationResult();
        result.setStartTime(LocalDateTime.now());

        try {
            // Test connections
            log.info("Testing database connections...");
            if (!extractorService.testConnection()) {
                throw new RuntimeException("Cannot connect to BUSY database");
            }
            log.info("✓ Successfully connected to BUSY database");

            // Migrate in proper order (respecting foreign keys)
            // 1. Independent masters first (no foreign keys)
            log.info("\n--- Phase 1: Independent Masters ---");
            // TODO: Add UOM, Currency, GST Rate migrations

            // 2. Item hierarchy
            log.info("\n--- Phase 2: Item Masters ---");
            int itemCount = itemMigrationService.migrateItemMasters();
            result.setItemsMigrated(itemCount);
            log.info("✓ Items migrated: {}", itemCount);

            // 3. Party hierarchy
            log.info("\n--- Phase 3: Party Masters ---");
            int partyCount = partyMigrationService.migratePartyMasters();
            result.setPartiesMigrated(partyCount);
            log.info("✓ Parties migrated: {}", partyCount);

            result.setEndTime(LocalDateTime.now());
            result.setSuccess(true);

            log.info("\n========================================");
            log.info("Migration completed successfully!");
            log.info("Total Items: {}", itemCount);
            log.info("Total Parties: {}", partyCount);
            log.info("Duration: {} seconds", result.getDurationSeconds());
            log.info("========================================");

        } catch (Exception e) {
            result.setSuccess(false);
            result.setErrorMessage(e.getMessage());
            log.error("Migration failed: {}", e.getMessage(), e);
        }

        return result;
    }

    /**
     * Get migration statistics
     */
    public String getMigrationStatistics() {
        StringBuilder stats = new StringBuilder();
        stats.append("=== BUSY to Sarala Migration Statistics ===\n");
        stats.append(itemMigrationService.getMigrationStats()).append("\n");
        stats.append(partyMigrationService.getMigrationStats()).append("\n");
        return stats.toString();
    }

    @lombok.Data
    public static class MigrationResult {
        private boolean success;
        private LocalDateTime startTime;
        private LocalDateTime endTime;
        private int itemsMigrated;
        private int partiesMigrated;
        private String errorMessage;

        public long getDurationSeconds() {
            if (startTime != null && endTime != null) {
                return java.time.Duration.between(startTime, endTime).getSeconds();
            }
            return 0;
        }
    }
}

