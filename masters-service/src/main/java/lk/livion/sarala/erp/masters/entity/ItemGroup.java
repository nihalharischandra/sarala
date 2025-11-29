package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Item Group Master - For categorizing items
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ItemGroup {

    private Long groupId;
    private String groupCode;
    private String groupName;
    private String groupDescription;

    // Hierarchy
    private Long parentGroupId;
    private Integer groupLevel;

    // Default Settings
    private Long defaultUomId;
    private Long defaultGstRateId;
    private Boolean isBatchApplicableByDefault;

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

