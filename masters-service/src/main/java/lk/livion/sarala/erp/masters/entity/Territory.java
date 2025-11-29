package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Territory Master - Sales territories
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Territory {

    private Long territoryId;
    private String territoryCode;
    private String territoryName;
    private String territoryDescription;

    // Hierarchy
    private Long parentTerritoryId;

    // Territory Manager
    private Long territoryManagerId;

    // Geographic Details
    private String region;
    private String zone;

    // Status
    private Boolean isActive;
    private String remarks;

    // Audit Fields
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;
    private Long version;
}

