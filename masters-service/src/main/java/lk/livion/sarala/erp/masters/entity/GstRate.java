package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * GST Rate Master - Tax rates for GST/VAT
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class GstRate {

    private Long gstRateId;
    private String rateName;
    private Double cgstRate;  // Central GST
    private Double sgstRate;  // State GST
    private Double igstRate;  // Integrated GST
    private Double cessRate;  // Additional cess

    // Total Rate
    private Double totalGstRate;

    // Applicability
    private String applicableOn;  // GOODS, SERVICES, BOTH

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

