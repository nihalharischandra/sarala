package lk.livion.sarala.erp.migration.controller;

import lk.livion.sarala.erp.migration.service.MigrationOrchestratorService;
import lombok.RequiredArgsConstructor;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/api/migration")
@RequiredArgsConstructor
public class MigrationController {

    private final MigrationOrchestratorService orchestratorService;

    /**
     * Execute full migration
     * POST http://localhost:8092/api/migration/execute
     */
    @PostMapping("/execute")
    public ResponseEntity<MigrationOrchestratorService.MigrationResult> executeMigration() {
        MigrationOrchestratorService.MigrationResult result = orchestratorService.executeFullMigration();
        return ResponseEntity.ok(result);
    }

    /**
     * Get migration statistics
     * GET http://localhost:8092/api/migration/stats
     */
    @GetMapping("/stats")
    public ResponseEntity<String> getStatistics() {
        String stats = orchestratorService.getMigrationStatistics();
        return ResponseEntity.ok(stats);
    }

    /**
     * Health check
     */
    @GetMapping("/health")
    public ResponseEntity<String> health() {
        return ResponseEntity.ok("Migration Service is running");
    }
}

