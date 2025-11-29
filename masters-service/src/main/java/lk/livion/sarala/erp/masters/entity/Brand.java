package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Brand Master - For item branding
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Brand {

    private Long brandId;
    private String brandCode;
    private String brandName;
    private String brandDescription;

    // Brand Details
    private String manufacturerName;
    private String country;
    private String website;

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

