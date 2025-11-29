package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Currency Master - Multi-currency support
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class Currency {

    private Long currencyId;
    private String currencyCode;  // USD, EUR, INR, LKR
    private String currencyName;
    private String currencySymbol;

    // Formatting
    private Integer decimalPlaces;
    private String thousandsSeparator;
    private String decimalSeparator;

    // Exchange Rate
    private Double exchangeRate;  // Rate against base currency
    private String baseCurrency;  // Usually company's home currency

    // Status
    private Boolean isActive;
    private Boolean isBaseCurrency;
    private String remarks;

    // Audit Fields
    private LocalDateTime createdAt;
    private String createdBy;
    private LocalDateTime updatedAt;
    private String updatedBy;
    private Long version;
}

