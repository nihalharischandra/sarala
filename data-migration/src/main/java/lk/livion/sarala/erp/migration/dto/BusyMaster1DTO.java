package lk.livion.sarala.erp.migration.dto;

import lombok.Data;

import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * DTO to read data from BUSY's Master1 table
 */
@Data
public class BusyMaster1DTO {
    private Integer code;
    private Short masterType;
    private String name;
    private String alias;
    private String printName;
    private Integer parentGrp;

    // Code/Master References (CM fields)
    private Integer cm1;
    private Integer cm2;
    private Integer cm3;
    private Integer cm4;
    private Integer cm5;
    private Integer cm6;
    private Integer cm7;
    private Integer cm8;
    private Integer cm9;
    private Integer cm10;
    private Integer cm11;

    // Decimal fields (D fields)
    private Double d1;
    private Double d2;
    private Double d3;
    private Double d4;
    private Double d5;
    private Double d6;
    private Double d7;
    private Double d8;
    private Double d9;
    private Double d10;
    private Double d11;
    private Double d12;
    private Double d13;
    private Double d14;
    private Double d15;
    private Double d16;
    private Double d17;
    private Double d18;
    private Double d19;
    private Double d20;

    // Integer fields (I fields)
    private Short i1;
    private Short i2;
    private Short i3;
    private Short i4;
    private Short i5;
    private Short i6;
    private Short i7;
    private Short i8;
    private Short i9;
    private Short i10;

    // Boolean fields (B fields)
    private Boolean b1;
    private Boolean b2;
    private Boolean b3;
    private Boolean b4;
    private Boolean b5;
    private Boolean b6;
    private Boolean b7;
    private Boolean b8;
    private Boolean b9;
    private Boolean b10;

    // String fields (C fields)
    private String c1;
    private String c2;
    private String c3;
    private String c4;
    private String c5;
    private String c6;
    private String c7;

    // Special fields
    private String hsnCode;
    private String notes1;
    private String notes2;
    private String masterNotes;

    // Audit fields
    private String createdBy;
    private LocalDateTime creationTime;
    private String modifiedBy;
    private LocalDateTime modificationTime;

    // Status fields
    private Boolean deactiveMaster;
    private Boolean blockedMaster;
    private String blockedNotes;

    // Helper methods
    public BigDecimal getD1AsBigDecimal() {
        return d1 != null ? BigDecimal.valueOf(d1) : BigDecimal.ZERO;
    }

    public BigDecimal getD2AsBigDecimal() {
        return d2 != null ? BigDecimal.valueOf(d2) : BigDecimal.ZERO;
    }

    public BigDecimal getD3AsBigDecimal() {
        return d3 != null ? BigDecimal.valueOf(d3) : BigDecimal.ZERO;
    }

    public Integer getCreditDays() {
        return i1 != null ? i1.intValue() : 0;
    }

    public Boolean isActive() {
        return deactiveMaster != null ? !deactiveMaster : true;
    }
}

