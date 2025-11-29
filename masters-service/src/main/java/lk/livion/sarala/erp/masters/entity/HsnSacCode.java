package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * HSN/SAC Code Master - For tax classification
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class HsnSacCode {

    private Long hsnSacId;
    private String code;
    private String codeType;  // HSN, SAC
    private String description;

    // Tax Details
    private Long defaultGstRateId;

    // Hierarchy
    private String chapter;  // First 2 digits
    private String heading;  // First 4 digits
    private String subHeading;  // First 6 digits

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

