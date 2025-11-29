package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Item Category Master - Additional categorization for items
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ItemCategory {

    private Long categoryId;
    private String categoryCode;
    private String categoryName;
    private String categoryDescription;

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

