package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Price List Master - Different pricing for different customer categories
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PriceList {

    private Long priceListId;
    private String priceListCode;
    private String priceListName;

    // Type
    private String priceListType;  // RETAIL, WHOLESALE, DISTRIBUTOR, SPECIAL

    // Currency
    private Long currencyId;

    // Validity
    private LocalDateTime validFrom;
    private LocalDateTime validTo;

    // Status
    private Boolean isActive;
    private Boolean isDefault;
    private String remarks;

    // Audit Fields
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;
    private Long version;
}

