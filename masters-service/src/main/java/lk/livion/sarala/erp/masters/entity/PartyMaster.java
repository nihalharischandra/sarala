public class PartyMaster {

    private Long partyId;
    private String partyCode;
    private String partyName;
    private String printName;

    // Party Type & Category
    private String partyType;  // CUSTOMER, SUPPLIER, BOTH, EMPLOYEE, TRANSPORTER, AGENT
    private Long partyGroupId;
    private String partyCategory;  // RETAIL, WHOLESALE, DISTRIBUTOR, END_USER

    // Contact Information
    private String primaryContactPerson;
    private String designation;
    private String mobileNumber;
    private String alternateNumber;
    private String emailAddress;
    private String website;

    // Address Details
    private String addressLine1;
    private String addressLine2;
    private String addressLine3;
    private String city;
    private String district;
    private String state;
    private String country;
    private String postalCode;

    // Shipping Address (if different)
    private String shippingAddressLine1;
    private String shippingAddressLine2;
    private String shippingCity;
    private String shippingState;
    private String shippingPostalCode;

    // Tax & Legal Information
    private String gstNumber;
    private String panNumber;
    private String tinNumber;
    private String vatNumber;
    private String aadharNumber;
    private String registrationType;  // REGULAR, COMPOSITION, UNREGISTERED

    // Credit & Payment Terms
    private Integer creditDays;
    private Double creditLimit;
    private String paymentTerms;
    private String defaultPriceList;  // RETAIL, WHOLESALE, DISTRIBUTOR

    // Banking Details
    private String bankName;
    private String bankBranch;
    private String accountNumber;
    private String ifscCode;
    private String accountHolderName;

    // Opening Balance
    private Double openingBalance;
    private String openingBalanceType;  // RECEIVABLE, PAYABLE
    private LocalDateTime openingBalanceDate;

    // Business Details
    private String businessType;
    private LocalDateTime incorporationDate;
    private String licenseNumber;

    // Tax Settings
    private Boolean isTdsApplicable;
    private Boolean isTcsApplicable;
    private Long tdsRateId;
    private Long tcsRateId;

    // Agent/Commission Details
    private Long agentId;
    private Double commissionRate;

    // Additional Information
    private String territoryId;
    private String industryType;
    private String remarks;
    private String referenceSource;  // How did they find us

    // Loyalty & Rating
    private String customerRating;  // A, B, C
    private Integer loyaltyPoints;

    // Status & Control
    private Boolean isActive;
    private Boolean isBlacklisted;
    private String blacklistReason;

    // Audit Fields
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;
    private Long version;
}
package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Party Master - Customers, Suppliers, Employees, etc.
 * Unified party management similar to BUSY
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor

