-- Direct SQL Migration Script: BUSY to Sarala
-- This script can be run directly if you have linked servers or manual CSV export/import

-- =====================================================
-- STEP 1: MIGRATE UNIT OF MEASUREMENT (UOM)
-- =====================================================
-- Export from BUSY (MasterType = 5, adjust if different)
/*
In BUSY MSSQL, run:
SELECT
    Alias as uom_code,
    Name as uom_name,
    PrintName as uom_symbol,
    GETDATE() as created_at,
    'MIGRATION' as created_by
FROM Master1
WHERE MasterType = 5
  AND DeactiveMaster = 0;

Save as CSV, then import to MySQL
*/

-- =====================================================
-- STEP 2: MIGRATE ITEM GROUPS
-- =====================================================
/*
In BUSY MSSQL:
SELECT
    Code as group_id,
    Alias as group_code,
    Name as group_name,
    Notes1 as group_description,
    ParentGrp as parent_group_id,
    Level as group_level,
    CASE WHEN DeactiveMaster = 0 THEN 1 ELSE 0 END as is_active,
    CreatedBy as created_by,
    CreationTime as created_at
FROM Master1
WHERE MasterType = 3
ORDER BY Level, Code;
*/

-- =====================================================
-- STEP 3: MIGRATE ITEM MASTERS
-- =====================================================
/*
In BUSY MSSQL:
SELECT
    Code as item_id,
    Alias as item_code,
    Name as item_name,
    PrintName as print_name,
    MasterNotes as item_description,

    -- Foreign Keys
    CM1 as item_group_id,
    CM2 as item_category_id,
    CM3 as brand_id,
    CM4 as primary_uom_id,
    CM5 as secondary_uom_id,
    CM6 as gst_rate_id,
    CM7 as default_warehouse_id,

    -- Pricing
    D1 as purchase_rate,
    D2 as sale_rate,
    D3 as mrp,
    D4 as minimum_sale_rate,
    D5 as wholesale_rate,

    -- Stock
    D6 as opening_stock,
    D7 as opening_stock_value,
    D8 as reorder_level,
    D9 as reorder_quantity,
    D10 as minimum_stock_level,
    D11 as maximum_stock_level,
    D12 as conversion_factor,
    D13 as weight,

    -- Flags
    B1 as is_batch_applicable,
    B2 as is_serial_number_applicable,
    B3 as is_expiry_applicable,
    B4 as is_taxable,
    B5 as is_discontinued,

    -- Additional
    HSNCode as hsn_code,
    C1 as barcode,
    C2 as sku,
    C3 as manufacturer_part_number,
    C7 as rack_number,

    -- Status
    CASE WHEN DeactiveMaster = 0 THEN 1 ELSE 0 END as is_active,
    Notes1 as remarks,

    -- Audit
    CreatedBy as created_by,
    CreationTime as created_at,
    ModifiedBy as updated_by,
    ModificationTime as updated_at
FROM Master1
WHERE MasterType = 1
ORDER BY Code;
*/

-- =====================================================
-- STEP 4: MIGRATE PARTY MASTERS
-- =====================================================
/*
In BUSY MSSQL:
SELECT
    Code as party_id,
    Alias as party_code,
    Name as party_name,
    PrintName as print_name,

    -- Foreign Keys
    CM1 as party_group_id,
    CM2 as agent_id,
    CM3 as territory_id,

    -- Contact
    C7 as primary_contact_person,
    C3 as mobile_number,
    C4 as email_address,

    -- Tax
    C1 as gst_number,
    C2 as pan_number,

    -- Credit
    I1 as credit_days,
    D2 as credit_limit,
    D1 as opening_balance,
    D3 as commission_rate,

    -- Flags
    B1 as is_tds_applicable,
    B2 as is_tcs_applicable,
    BlockedMaster as is_blacklisted,
    BlockedNotes as blacklist_reason,

    -- Status
    CASE WHEN DeactiveMaster = 0 THEN 1 ELSE 0 END as is_active,
    Notes1 as remarks,

    -- Audit
    CreatedBy as created_by,
    CreationTime as created_at,
    ModifiedBy as updated_by,
    ModificationTime as updated_at
FROM Master1
WHERE MasterType = 2
ORDER BY Code;
*/

-- =====================================================
-- VERIFICATION QUERIES FOR MYSQL
-- =====================================================

-- After migration, run these in MySQL to verify:

-- Check counts
SELECT 'Items' as Entity, COUNT(*) as Total,
       SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END) as Active
FROM item_master
UNION ALL
SELECT 'Parties', COUNT(*), SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END)
FROM party_master
UNION ALL
SELECT 'Item Groups', COUNT(*), SUM(CASE WHEN is_active = 1 THEN 1 ELSE 0 END)
FROM item_group;

-- Check for orphaned records (missing foreign keys)
SELECT 'Items with missing group' as Issue, COUNT(*) as Count
FROM item_master
WHERE item_group_id IS NOT NULL
  AND item_group_id NOT IN (SELECT group_id FROM item_group)
UNION ALL
SELECT 'Items with missing UOM', COUNT(*)
FROM item_master
WHERE primary_uom_id IS NOT NULL
  AND primary_uom_id NOT IN (SELECT uom_id FROM unit_of_measurement);

-- Sample data comparison
SELECT item_code, item_name, sale_rate, opening_stock
FROM item_master
ORDER BY item_id
LIMIT 20;

