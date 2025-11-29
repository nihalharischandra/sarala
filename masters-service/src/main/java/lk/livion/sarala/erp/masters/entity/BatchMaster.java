package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * Batch Master - For batch-wise inventory tracking
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class BatchMaster {

    private Long batchId;
    private String batchNumber;
    private Long itemId;

    // Batch Details
    private LocalDate manufacturingDate;
    private LocalDate expiryDate;
    private String lotNumber;

    // Quantity & Valuation
    private Double batchQuantity;
    private Double availableQuantity;
    private Double costPrice;
    private Double sellingPrice;

    // Storage Location
    private Long warehouseId;
    private String rackNumber;
    private String binLocation;

    // Quality Control
    private String qualityStatus;  // PASSED, FAILED, UNDER_INSPECTION
    private String qualityRemarks;

    // Purchase Reference
    private Long purchaseInvoiceId;
    private String supplierBatchNumber;

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

