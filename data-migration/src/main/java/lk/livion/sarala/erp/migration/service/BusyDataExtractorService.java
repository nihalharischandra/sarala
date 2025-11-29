package lk.livion.sarala.erp.migration.service;

import lk.livion.sarala.erp.migration.dto.BusyMaster1DTO;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.RowMapper;
import org.springframework.stereotype.Service;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.util.List;

@Slf4j
@Service
public class BusyDataExtractorService {

    private final JdbcTemplate sourceJdbcTemplate;

    public BusyDataExtractorService(@Qualifier("sourceJdbcTemplate") JdbcTemplate sourceJdbcTemplate) {
        this.sourceJdbcTemplate = sourceJdbcTemplate;
    }

    /**
     * Extract all masters of a specific type from BUSY
     * MasterType values:
     * 1 = Item Master
     * 2 = Party Master (Account/Ledger)
     * 3 = Item Group
     * 4 = Party Group
     * 5 = UOM (Unit)
     * etc.
     */
    public List<BusyMaster1DTO> extractMastersByType(int masterType) {
        log.info("Extracting BUSY masters with MasterType = {}", masterType);

        String sql = """
            SELECT 
                Code, MasterType, Name, Alias, PrintName, ParentGrp,
                CM1, CM2, CM3, CM4, CM5, CM6, CM7, CM8, CM9, CM10, CM11,
                D1, D2, D3, D4, D5, D6, D7, D8, D9, D10, D11, D12, D13, D14, D15, D16, D17, D18, D19, D20,
                I1, I2, I3, I4, I5, I6, I7, I8, I9, I10,
                B1, B2, B3, B4, B5, B6, B7, B8, B9, B10,
                C1, C2, C3, C4, C5, C6, C7,
                HSNCode, Notes1, Notes2, MasterNotes,
                CreatedBy, CreationTime, ModifiedBy, ModificationTime,
                DeactiveMaster, BlockedMaster, BlockedNotes
            FROM Master1
            WHERE MasterType = ?
            ORDER BY Code
            """;

        List<BusyMaster1DTO> results = sourceJdbcTemplate.query(sql, new BusyMaster1RowMapper(), masterType);
        log.info("Extracted {} records for MasterType {}", results.size(), masterType);
        return results;
    }

    /**
     * Get total count by master type
     */
    public int getMasterCountByType(int masterType) {
        String sql = "SELECT COUNT(*) FROM Master1 WHERE MasterType = ?";
        Integer count = sourceJdbcTemplate.queryForObject(sql, Integer.class, masterType);
        return count != null ? count : 0;
    }

    /**
     * Test connection to BUSY database
     */
    public boolean testConnection() {
        try {
            sourceJdbcTemplate.queryForObject("SELECT 1", Integer.class);
            log.info("Successfully connected to BUSY database");
            return true;
        } catch (Exception e) {
            log.error("Failed to connect to BUSY database", e);
            return false;
        }
    }

    /**
     * Row Mapper for BUSY Master1 table
     */
    private static class BusyMaster1RowMapper implements RowMapper<BusyMaster1DTO> {
        @Override
        public BusyMaster1DTO mapRow(ResultSet rs, int rowNum) throws SQLException {
            BusyMaster1DTO dto = new BusyMaster1DTO();

            // Basic fields
            dto.setCode(rs.getInt("Code"));
            dto.setMasterType(rs.getShort("MasterType"));
            dto.setName(rs.getString("Name"));
            dto.setAlias(rs.getString("Alias"));
            dto.setPrintName(rs.getString("PrintName"));
            dto.setParentGrp(rs.getInt("ParentGrp"));

            // CM fields
            dto.setCm1(rs.getInt("CM1"));
            dto.setCm2(rs.getInt("CM2"));
            dto.setCm3(rs.getInt("CM3"));
            dto.setCm4(rs.getInt("CM4"));
            dto.setCm5(rs.getInt("CM5"));
            dto.setCm6(rs.getInt("CM6"));
            dto.setCm7(rs.getInt("CM7"));
            dto.setCm8(rs.getInt("CM8"));
            dto.setCm9(rs.getInt("CM9"));
            dto.setCm10(rs.getInt("CM10"));
            dto.setCm11(rs.getInt("CM11"));

            // D fields (Decimal)
            dto.setD1(rs.getDouble("D1"));
            dto.setD2(rs.getDouble("D2"));
            dto.setD3(rs.getDouble("D3"));
            dto.setD4(rs.getDouble("D4"));
            dto.setD5(rs.getDouble("D5"));
            dto.setD6(rs.getDouble("D6"));
            dto.setD7(rs.getDouble("D7"));
            dto.setD8(rs.getDouble("D8"));
            dto.setD9(rs.getDouble("D9"));
            dto.setD10(rs.getDouble("D10"));
            dto.setD11(rs.getDouble("D11"));
            dto.setD12(rs.getDouble("D12"));
            dto.setD13(rs.getDouble("D13"));
            dto.setD14(rs.getDouble("D14"));
            dto.setD15(rs.getDouble("D15"));
            dto.setD16(rs.getDouble("D16"));
            dto.setD17(rs.getDouble("D17"));
            dto.setD18(rs.getDouble("D18"));
            dto.setD19(rs.getDouble("D19"));
            dto.setD20(rs.getDouble("D20"));

            // I fields (Integer)
            dto.setI1(rs.getShort("I1"));
            dto.setI2(rs.getShort("I2"));
            dto.setI3(rs.getShort("I3"));
            dto.setI4(rs.getShort("I4"));
            dto.setI5(rs.getShort("I5"));
            dto.setI6(rs.getShort("I6"));
            dto.setI7(rs.getShort("I7"));
            dto.setI8(rs.getShort("I8"));
            dto.setI9(rs.getShort("I9"));
            dto.setI10(rs.getShort("I10"));

            // B fields (Boolean)
            dto.setB1(rs.getBoolean("B1"));
            dto.setB2(rs.getBoolean("B2"));
            dto.setB3(rs.getBoolean("B3"));
            dto.setB4(rs.getBoolean("B4"));
            dto.setB5(rs.getBoolean("B5"));
            dto.setB6(rs.getBoolean("B6"));
            dto.setB7(rs.getBoolean("B7"));
            dto.setB8(rs.getBoolean("B8"));
            dto.setB9(rs.getBoolean("B9"));
            dto.setB10(rs.getBoolean("B10"));

            // C fields (String)
            dto.setC1(rs.getString("C1"));
            dto.setC2(rs.getString("C2"));
            dto.setC3(rs.getString("C3"));
            dto.setC4(rs.getString("C4"));
            dto.setC5(rs.getString("C5"));
            dto.setC6(rs.getString("C6"));
            dto.setC7(rs.getString("C7"));

            // Special fields
            dto.setHsnCode(rs.getString("HSNCode"));
            dto.setNotes1(rs.getString("Notes1"));
            dto.setNotes2(rs.getString("Notes2"));
            dto.setMasterNotes(rs.getString("MasterNotes"));

            // Audit fields
            dto.setCreatedBy(rs.getString("CreatedBy"));
            Timestamp creationTime = rs.getTimestamp("CreationTime");
            if (creationTime != null) {
                dto.setCreationTime(creationTime.toLocalDateTime());
            }
            dto.setModifiedBy(rs.getString("ModifiedBy"));
            Timestamp modificationTime = rs.getTimestamp("ModificationTime");
            if (modificationTime != null) {
                dto.setModificationTime(modificationTime.toLocalDateTime());
            }

            // Status fields
            dto.setDeactiveMaster(rs.getBoolean("DeactiveMaster"));
            dto.setBlockedMaster(rs.getBoolean("BlockedMaster"));
            dto.setBlockedNotes(rs.getString("BlockedNotes"));

            return dto;
        }
    }
}

