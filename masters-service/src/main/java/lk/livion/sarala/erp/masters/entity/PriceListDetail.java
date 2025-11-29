package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * Price List Details - Item-wise pricing in each price list
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class PriceListDetail {

    private Long priceListDetailId;
    private Long priceListId;
    private Long itemId;

    // Pricing
    private BigDecimal rate;
    private BigDecimal minimumRate;
    private BigDecimal discountPercentage;

    // UOM
    private Long uomId;

    // Status
    private Boolean isActive;

    // Audit Fields
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;
    private Long version;
}

