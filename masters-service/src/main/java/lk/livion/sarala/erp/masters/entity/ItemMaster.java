package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Item Master - Product/Inventory Item
 * Similar to BUSY's Item Master but with meaningful column names
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class ItemMaster {

    private Long itemId;
    private String itemCode;
    private String itemName;
    private String printName;
    private String itemDescription;

    // Category & Classification
    private Long itemGroupId;
    private Long itemCategoryId;
    private Long brandId;
    private String hsnCode;  // HSN/SAC Code for taxation

    // Unit of Measurement
    private Long primaryUomId;
    private Long secondaryUomId;
    private BigDecimal conversionFactor;

    // Item Type & Nature
    private String itemType;  // GOODS, SERVICES, FIXED_ASSET
    private String itemNature;  // TRADING, MANUFACTURING, CONSUMABLE
    private Boolean isBatchApplicable;
    private Boolean isSerialNumberApplicable;
    private Boolean isExpiryApplicable;

    // Pricing
    private BigDecimal purchaseRate;
    private BigDecimal saleRate;
    private BigDecimal mrp;
    private BigDecimal minimumSaleRate;
    private BigDecimal wholesaleRate;

    // Stock Control
    private BigDecimal openingStock;
    private BigDecimal openingStockValue;
    private BigDecimal reorderLevel;
    private BigDecimal reorderQuantity;
    private BigDecimal minimumStockLevel;
    private BigDecimal maximumStockLevel;

    // Tax Information
    private Long gstRateId;
    private Boolean isTaxable;
    private String taxPreference;  // TAXABLE, EXEMPT, NIL_RATED

    // Location
    private String rackNumber;
    private String binLocation;
    private Long defaultWarehouseId;

    // Additional Details
    private String barcode;
    private String manufacturerPartNumber;
    private String sku;  // Stock Keeping Unit
    private BigDecimal weight;
    private String weightUnit;
    private String dimensionLength;
    private String dimensionWidth;
    private String dimensionHeight;
    private String dimensionUnit;

    // Accounting
    private Long salesAccountId;
    private Long purchaseAccountId;
    private Long stockAccountId;

    // Status & Control
    private Boolean isActive;
    private Boolean isDiscontinued;
    private String remarks;

    // Audit Fields
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;
    private Long version;
}


