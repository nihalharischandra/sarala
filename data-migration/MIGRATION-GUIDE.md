## Rollback Strategy

### Before Migration
```sql
-- Backup existing data
mysqldump -u root -p sarala_masters > sarala_backup_$(date +%Y%m%d).sql
```

### Rollback
```sql
-- Restore from backup
mysql -u root -p sarala_masters < sarala_backup_20251129.sql
```

## Logging

Migration logs are saved to `migration.log` in the application directory.

View real-time logs:
```bash
tail -f migration.log
```

## Support & Contact

For migration issues:
1. Check the logs in `migration.log`
2. Verify database connections
3. Check field mappings in `BUSY-TO-SARALA-MAPPING.md`
4. Contact: support@livion.lk

## Migration Checklist

- [ ] Backup BUSY database
- [ ] Backup Sarala database
- [ ] Update connection settings
- [ ] Verify MasterType values
- [ ] Test connection to both databases
- [ ] Run sample migration (10 records)
- [ ] Verify sample data
- [ ] Run full migration
- [ ] Verify counts
- [ ] Check foreign key integrity
- [ ] Validate sample records
- [ ] Create indexes
- [ ] Update sequences
- [ ] Document any custom mappings

## Next Steps After Migration

1. **User Training**: Train users on new system
2. **Parallel Run**: Run both systems for a period
3. **Data Reconciliation**: Regular data comparison
4. **Go Live**: Switch to Sarala completely
5. **Archive BUSY**: Keep BUSY as read-only archive
# BUSY to Sarala ERP - Data Migration Guide

## Overview
This module provides tools and utilities to migrate master data from BUSY ERP (MSSQL Server) to Sarala ERP (MySQL).

## Architecture

### Source System
- **BUSY ERP**: Microsoft SQL Server database
- **Table**: Master1 (single table with all master types)
- **Column Structure**: Generic columns (CM1-CM11, D1-D26, I1-I30, B1-B40, etc.)

### Target System
- **Sarala ERP**: MySQL database
- **Tables**: Normalized tables with meaningful column names
- **Structure**: item_master, party_master, unit_of_measurement, etc.

## Prerequisites

### 1. Software Requirements
- Java 21
- Maven 3.8+
- Microsoft SQL Server (BUSY database)
- MySQL 8.0+ (Sarala database)

### 2. BUSY Database Access
- Database name (e.g., `BusyComp0001_db12025`)
- SQL Server instance address
- Username and password with READ access

### 3. Sarala Database Setup
- MySQL database created (`sarala_masters`)
- Schema initialized (run `schema.sql`)
- Write access credentials

## Configuration

### Step 1: Update Database Connection Settings

Edit `data-migration/src/main/resources/application.properties`:

```properties
# Source Database (BUSY - MSSQL)
source.datasource.url=jdbc:sqlserver://YOUR_SERVER:1433;databaseName=YOUR_BUSY_DB;encrypt=false
source.datasource.username=YOUR_MSSQL_USERNAME
source.datasource.password=YOUR_MSSQL_PASSWORD

# Target Database (Sarala - MySQL)
target.datasource.url=jdbc:mysql://localhost:3306/sarala_masters?useSSL=false
target.datasource.username=root
target.datasource.password=YOUR_MYSQL_PASSWORD
```

### Step 2: Verify BUSY MasterType Values

Connect to your BUSY database and run:

```sql
-- Find MasterType values in your BUSY database
SELECT DISTINCT MasterType, COUNT(*) as Count
FROM Master1
GROUP BY MasterType
ORDER BY MasterType;
```

Common MasterType values:
- `1` = Item Master
- `2` = Party Master (Accounts/Ledger)
- `3` = Item Group
- `4` = Party Group
- `5` = Unit of Measurement (UOM)
- `6` = Godown/Warehouse

Update the constants in migration service files if your values differ.

## Migration Process

### Option 1: Using REST API (Recommended)

1. **Start the Migration Service**:
```bash
cd data-migration
mvn spring-boot:run
```

2. **Execute Migration**:
```bash
# Full migration
curl -X POST http://localhost:8092/api/migration/execute

# Check statistics
curl http://localhost:8092/api/migration/stats
```

### Option 2: Using Command Line

1. **Build the project**:
```bash
cd data-migration
mvn clean package
```

2. **Run migration**:
```bash
java -jar target/data-migration-1.0.0-SNAPSHOT.jar
```

### Option 3: Using SQL Scripts (Manual)

We've provided SQL scripts for manual migration if needed.

## Migration Steps (Automatic)

The migration process follows this sequence:

### Phase 1: Independent Masters (No Foreign Keys)
1. Unit of Measurement (UOM)
2. Currency
3. GST Rates
4. Payment Terms
5. Departments
6. Territories

### Phase 2: Group Masters
1. Item Groups
2. Party Groups
3. Brands
4. Item Categories

### Phase 3: Main Masters (With Foreign Keys)
1. Warehouses
2. Item Masters
3. Party Masters
4. Batch Masters

## Field Mapping Reference

### BUSY Master1 → Sarala Item Master

| BUSY Field | Sarala Column | Description |
|-----------|---------------|-------------|
| Code | item_id | Primary key |
| Alias | item_code | Unique item code |
| Name | item_name | Item name |
| PrintName | print_name | Print name |
| CM1 | item_group_id | Item group reference |
| CM4 | primary_uom_id | Primary UOM |
| CM5 | secondary_uom_id | Secondary UOM |
| D1 | purchase_rate | Purchase price |
| D2 | sale_rate | Sale price |
| D3 | mrp | Maximum Retail Price |
| D4 | minimum_sale_rate | Minimum selling price |
| D5 | wholesale_rate | Wholesale price |
| D6 | opening_stock | Opening stock quantity |
| D7 | opening_stock_value | Opening stock value |
| D8 | reorder_level | Reorder level |
| D12 | conversion_factor | UOM conversion |
| B1 | is_batch_applicable | Batch tracking flag |
| B2 | is_serial_number_applicable | Serial number flag |
| B4 | is_taxable | Taxable flag |
| C1 | barcode | Barcode |
| C2 | sku | Stock Keeping Unit |
| HSNCode | hsn_code | HSN/SAC code |

### BUSY Master1 → Sarala Party Master

| BUSY Field | Sarala Column | Description |
|-----------|---------------|-------------|
| Code | party_id | Primary key |
| Alias | party_code | Unique party code |
| Name | party_name | Party name |
| CM1 | party_group_id | Party group reference |
| D1 | opening_balance | Opening balance |
| D2 | credit_limit | Credit limit |
| I1 | credit_days | Credit period days |
| B1 | is_tds_applicable | TDS applicable flag |
| B2 | is_tcs_applicable | TCS applicable flag |
| C1 | gst_number | GST Number |
| C2 | pan_number | PAN Number |
| C3 | mobile_number | Mobile number |
| C4 | email_address | Email address |
| C5 | account_number | Bank account |
| C6 | ifsc_code | IFSC code |
| BlockedMaster | is_blacklisted | Blacklist flag |

## Manual SQL Migration Scripts

If you prefer manual SQL-based migration:

### Extract from BUSY to CSV

```sql
-- Export Items from BUSY
SELECT 
    Alias as item_code,
    Name as item_name,
    PrintName as print_name,
    CM1 as item_group_id,
    CM4 as primary_uom_id,
    D1 as purchase_rate,
    D2 as sale_rate,
    D3 as mrp,
    B1 as is_batch_applicable,
    HSNCode as hsn_code,
    CASE WHEN DeactiveMaster = 0 THEN 1 ELSE 0 END as is_active
FROM Master1
WHERE MasterType = 1
  AND DeactiveMaster = 0
```

### Import to MySQL

```bash
# Load CSV into MySQL
mysql -u root -p sarala_masters
LOAD DATA INFILE '/path/to/items.csv'
INTO TABLE item_master
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;
```

## Post-Migration Tasks

### 1. Verify Data Integrity

```sql
-- Check migrated counts
SELECT 'Items' as Entity, COUNT(*) as Count FROM item_master
UNION ALL
SELECT 'Parties', COUNT(*) FROM party_master
UNION ALL
SELECT 'UOMs', COUNT(*) FROM unit_of_measurement;

-- Check for missing foreign keys
SELECT * FROM item_master WHERE item_group_id IS NOT NULL 
AND item_group_id NOT IN (SELECT group_id FROM item_group);
```

### 2. Update Sequences/Auto-increment

```sql
-- Reset auto-increment values
ALTER TABLE item_master AUTO_INCREMENT = 1001;
ALTER TABLE party_master AUTO_INCREMENT = 2001;
```

### 3. Create Indexes (if not exists)

```sql
-- Additional indexes for performance
CREATE INDEX idx_item_name ON item_master(item_name);
CREATE INDEX idx_party_name ON party_master(party_name);
CREATE INDEX idx_item_active ON item_master(is_active);
```

## Troubleshooting

### Connection Issues

**Problem**: Cannot connect to BUSY database

**Solutions**:
1. Verify SQL Server is accessible
2. Check firewall settings
3. Enable TCP/IP in SQL Server Configuration Manager
4. Verify SQL Server Authentication mode

```sql
-- Enable SQL Server authentication
EXEC xp_instance_regwrite N'HKEY_LOCAL_MACHINE', 
     N'Software\Microsoft\MSSQLServer\MSSQLServer', 
     N'LoginMode', REG_DWORD, 2;
```

### Character Encoding Issues

**Problem**: Special characters not displaying correctly

**Solution**: Update connection strings:

```properties
# MSSQL
source.datasource.url=jdbc:sqlserver://...;characterEncoding=UTF-8

# MySQL
target.datasource.url=jdbc:mysql://...?characterEncoding=utf8mb4
```

### Foreign Key Violations

**Problem**: Cannot insert due to missing parent records

**Solution**: Migrate in correct order:
1. First migrate all independent masters (UOM, Currency)
2. Then migrate groups (Item Groups, Party Groups)
3. Finally migrate main masters (Items, Parties)

### Duplicate Key Errors

**Problem**: Duplicate entry for primary key

**Solution**: The migration uses `ON DUPLICATE KEY UPDATE` to handle duplicates. If you want to skip duplicates instead:

```sql
INSERT IGNORE INTO item_master (...) VALUES (...);
```

## Data Validation

### Compare Counts

```sql
-- BUSY counts
SELECT MasterType, COUNT(*) FROM Master1 
WHERE DeactiveMaster = 0 
GROUP BY MasterType;

-- Sarala counts
SELECT 'Items' as Type, COUNT(*) FROM item_master WHERE is_active = 1
UNION ALL
SELECT 'Parties', COUNT(*) FROM party_master WHERE is_active = 1;
```

### Sample Data Verification

```sql
-- Compare first 10 items
-- In BUSY:
SELECT TOP 10 Alias, Name, D2 as SaleRate 
FROM Master1 WHERE MasterType = 1 ORDER BY Code;

-- In Sarala:
SELECT item_code, item_name, sale_rate 
FROM item_master ORDER BY item_id LIMIT 10;
```

## Performance Tuning

### Batch Processing

The migration service uses batch processing (1000 records per batch by default). Adjust in `application.properties`:

```properties
migration.batch-size=5000
```

### Parallel Processing

For large datasets, consider running migrations in parallel:

```java
// Process items in parallel
List<BusyMaster1DTO> items = extractorService.extractMastersByType(1);
items.parallelStream().forEach(item -> migrateItemMaster(item));
```

package lk.livion.sarala.erp.migration;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

/**
 * Data Migration Utility Application
 * Migrates data from BUSY (MSSQL) to Sarala ERP (MySQL)
 */
@SpringBootApplication
public class DataMigrationApplication {
    public static void main(String[] args) {
        SpringApplication.run(DataMigrationApplication.class, args);
    }
}

