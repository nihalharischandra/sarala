# BUSY to Sarala ERP - Quick Start Migration Guide

## Prerequisites Checklist
- [ ] Java 21 installed
- [ ] Maven 3.8+ installed
- [ ] BUSY database accessible (MSSQL Server)
- [ ] Sarala MySQL database created and schema initialized
- [ ] Database credentials ready

## Quick Start (5 Minutes)

### Step 1: Configure Databases (2 minutes)

Edit `data-migration/src/main/resources/application.properties`:

```properties
# BUSY Database (Source)
source.datasource.url=jdbc:sqlserver://YOUR_SERVER:1433;databaseName=YOUR_BUSY_DB
source.datasource.username=YOUR_USERNAME
source.datasource.password=YOUR_PASSWORD

# Sarala Database (Target)  
target.datasource.url=jdbc:mysql://localhost:3306/sarala_masters
target.datasource.username=root
target.datasource.password=YOUR_PASSWORD
```

### Step 2: Start Migration Service (1 minute)

**Option A - Using provided script:**
```bash
cd data-migration
start-migration-service.bat
```

**Option B - Using Maven:**
```bash
cd data-migration
mvn spring-boot:run
```

Wait for: `Started DataMigrationApplication in X seconds`

### Step 3: Execute Migration (2 minutes)

**Option A - Using interactive menu:**
```bash
migrate.bat
# Select option 5 for full migration
```

**Option B - Using REST API:**
```bash
# Full migration
curl -X POST http://localhost:8092/api/migration/execute

# Check statistics
curl http://localhost:8092/api/migration/stats
```

**Option C - Using Browser:**
- Open: http://localhost:8092/api/migration/execute (POST request)
- Use Postman or similar tool

### Step 4: Verify Results

```bash
# Check statistics
curl http://localhost:8092/api/migration/stats
```

Or login to MySQL:
```sql
USE sarala_masters;

-- Check counts
SELECT COUNT(*) as Items FROM item_master;
SELECT COUNT(*) as Parties FROM party_master;

-- View sample data
SELECT * FROM item_master LIMIT 10;
SELECT * FROM party_master LIMIT 10;
```

## Migration Phases

The migration runs in this order:
1. ✅ **UOM** (Unit of Measurements)
2. ✅ **Item Groups** (Categories)
3. ✅ **Party Groups** 
4. ✅ **Item Masters** (Products)
5. ✅ **Party Masters** (Customers/Suppliers)

## What Gets Migrated?

### Item Masters
- ✅ Basic info (code, name, description)
- ✅ Groups and categories
- ✅ Pricing (purchase, sale, MRP, wholesale)
- ✅ Stock levels (opening, reorder, min, max)
- ✅ UOM and conversion
- ✅ Tax info (HSN, GST)
- ✅ Batch/Serial settings
- ✅ Barcode, SKU
- ✅ Audit trail

### Party Masters
- ✅ Basic info (code, name, type)
- ✅ Contact details (mobile, email)
- ✅ Tax details (GST, PAN)
- ✅ Credit terms (days, limit)
- ✅ Opening balance
- ✅ Banking details
- ✅ TDS/TCS settings
- ✅ Blacklist status
- ✅ Audit trail

## Field Mappings (Quick Reference)

### BUSY → Sarala (Items)
```
Code → item_id
Alias → item_code
Name → item_name
CM1 → item_group_id
CM4 → primary_uom_id
D1 → purchase_rate
D2 → sale_rate
D3 → mrp
D6 → opening_stock
B1 → is_batch_applicable
C1 → barcode
HSNCode → hsn_code
```

### BUSY → Sarala (Parties)
```
Code → party_id
Alias → party_code
Name → party_name
CM1 → party_group_id
D1 → opening_balance
D2 → credit_limit
I1 → credit_days
C1 → gst_number
C2 → pan_number
C3 → mobile_number
B1 → is_tds_applicable
```

## Troubleshooting

### "Cannot connect to database"
1. Check firewall settings
2. Verify SQL Server allows remote connections
3. Test connection with SSMS or MySQL Workbench
4. Check credentials in application.properties

### "Foreign key violation"
- Migration runs in proper order automatically
- If manual migration, ensure parent records exist first

### "Duplicate key error"
- The migration uses `ON DUPLICATE KEY UPDATE`
- Duplicates will be updated, not cause errors

### "Special characters garbled"
- Ensure UTF-8 encoding in connection strings
- Check database charset: `utf8mb4`

## Rollback

### Before Migration (Recommended)
```bash
# Backup Sarala database
mysqldump -u root -p sarala_masters > backup_before_migration.sql
```

### To Rollback
```sql
# Drop all data
DROP DATABASE sarala_masters;
CREATE DATABASE sarala_masters;

# Restore schema
mysql -u root -p sarala_masters < schema.sql

# Restore backup (if needed)
mysql -u root -p sarala_masters < backup_before_migration.sql
```

## Performance Tips

### For Large Datasets (>10,000 records)
1. Increase batch size:
   ```properties
   migration.batch-size=5000
   ```

2. Increase MySQL packet size:
   ```sql
   SET GLOBAL max_allowed_packet=67108864;
   ```

3. Disable foreign key checks temporarily:
   ```sql
   SET FOREIGN_KEY_CHECKS=0;
   -- Run migration
   SET FOREIGN_KEY_CHECKS=1;
   ```

## Validation Queries

### Compare Counts (BUSY vs Sarala)
```sql
-- In BUSY (MSSQL):
SELECT MasterType, COUNT(*) 
FROM Master1 
WHERE DeactiveMaster = 0 
GROUP BY MasterType;

-- In Sarala (MySQL):
SELECT 'Items' as Type, COUNT(*) FROM item_master WHERE is_active=1
UNION ALL
SELECT 'Parties', COUNT(*) FROM party_master WHERE is_active=1;
```

### Check Data Quality
```sql
-- Items without groups
SELECT COUNT(*) FROM item_master WHERE item_group_id IS NULL;

-- Parties without contact
SELECT COUNT(*) FROM party_master WHERE mobile_number = '';

-- Items with missing prices
SELECT COUNT(*) FROM item_master WHERE sale_rate = 0;
```

## Support

- 📖 Full Documentation: See `MIGRATION-GUIDE.md`
- 🗺️ Field Mappings: See `BUSY-TO-SARALA-MAPPING.md`
- 📝 Logs: Check `migration.log`
- 📧 Support: support@livion.lk

## Next Steps After Migration

1. ✅ Verify data counts match
2. ✅ Spot-check sample records
3. ✅ Test foreign key integrity
4. ✅ Update auto-increment sequences
5. ✅ Create additional indexes if needed
6. ✅ Train users on new system
7. ✅ Run parallel for 1-2 weeks
8. ✅ Go live with Sarala ERP

