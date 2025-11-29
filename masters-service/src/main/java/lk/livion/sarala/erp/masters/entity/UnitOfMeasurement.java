package lk.livion.sarala.erp.masters.entity;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

/**
 * Unit of Measurement Master
 * Defines units like KG, LITER, PIECE, etc.
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class UnitOfMeasurement {

    private Long uomId;
    private String uomCode;
    private String uomName;
    private String uomSymbol;

    // UOM Type
    private String uomType;  // WEIGHT, VOLUME, LENGTH, QUANTITY, AREA, TIME

    // Decimal places for quantity
    private Integer decimalPlaces;

    // Base unit for conversion
    private Long baseUomId;
    private Double conversionFactor;  // How many base units = 1 of this unit

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

