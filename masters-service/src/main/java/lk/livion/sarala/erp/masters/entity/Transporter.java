package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Transport Master - Transporters/Logistics
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Transporter {

    private Long transporterId;
    private String transporterCode;
    private String transporterName;

    // Contact Details
    private String contactPerson;
    private String mobileNumber;
    private String emailAddress;
    private String address;
    private String city;
    private String state;

    // Legal Details
    private String gstNumber;
    private String panNumber;

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

