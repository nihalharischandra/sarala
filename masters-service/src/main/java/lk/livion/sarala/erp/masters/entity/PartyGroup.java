package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Party Group Master - For categorizing parties
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PartyGroup {

    private Long groupId;
    private String groupCode;
    private String groupName;
    private String groupDescription;

    // Group Type
    private String groupType;  // CUSTOMER_GROUP, SUPPLIER_GROUP, EMPLOYEE_GROUP

    // Default Settings
    private Integer defaultCreditDays;
    private Double defaultCreditLimit;
    private String defaultPriceList;

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

