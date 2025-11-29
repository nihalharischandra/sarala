package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Warehouse Master - Storage locations
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Warehouse {

    private Long warehouseId;
    private String warehouseCode;
    private String warehouseName;
    private String warehouseType;  // MAIN, BRANCH, TRANSIT, VIRTUAL

    // Location Details
    private String addressLine1;
    private String addressLine2;
    private String city;
    private String state;
    private String country;
    private String postalCode;

    // Contact Information
    private String contactPerson;
    private String phoneNumber;
    private String emailAddress;

    // Capacity
    private Double totalCapacity;
    private String capacityUnit;

    // Warehouse Manager
    private Long managerId;

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

