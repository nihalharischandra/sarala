package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Payment Terms Master - Credit/payment terms
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PaymentTerms {

    private Long paymentTermId;
    private String termCode;
    private String termName;
    private String termDescription;

    // Term Details
    private Integer creditDays;
    private String paymentType;  // IMMEDIATE, NET_DAYS, ADVANCE, COD

    // Discount for early payment
    private Double earlyPaymentDiscountPercentage;
    private Integer earlyPaymentDays;

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

