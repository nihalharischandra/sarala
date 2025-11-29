-- Sample Master Data for Sarala ERP
-- MySQL Insert Statements for Initial Setup

USE sarala_masters;

-- =====================================================
-- UNIT OF MEASUREMENT
-- =====================================================

INSERT INTO unit_of_measurement (uom_code, uom_name, uom_symbol, uom_type, decimal_places, is_active) VALUES
('PCS', 'Pieces', 'Pcs', 'QUANTITY', 0, TRUE),
('NOS', 'Numbers', 'Nos', 'QUANTITY', 0, TRUE),
('KG', 'Kilogram', 'Kg', 'WEIGHT', 3, TRUE),
('GM', 'Gram', 'g', 'WEIGHT', 3, TRUE),
('LTR', 'Liter', 'L', 'VOLUME', 3, TRUE),
('ML', 'Milliliter', 'mL', 'VOLUME', 3, TRUE),
('MTR', 'Meter', 'm', 'LENGTH', 2, TRUE),
('CM', 'Centimeter', 'cm', 'LENGTH', 2, TRUE),
('FT', 'Feet', 'ft', 'LENGTH', 2, TRUE),
('BOX', 'Box', 'Box', 'QUANTITY', 0, TRUE),
('CTN', 'Carton', 'Ctn', 'QUANTITY', 0, TRUE),
('DOZ', 'Dozen', 'Doz', 'QUANTITY', 0, TRUE),
('PKT', 'Packet', 'Pkt', 'QUANTITY', 0, TRUE),
('BAG', 'Bag', 'Bag', 'QUANTITY', 0, TRUE),
('BTL', 'Bottle', 'Btl', 'QUANTITY', 0, TRUE);

-- =====================================================
-- GST RATES
-- =====================================================

INSERT INTO gst_rate (rate_name, cgst_rate, sgst_rate, igst_rate, cess_rate, total_gst_rate, applicable_on, is_active) VALUES
('GST 0%', 0.00, 0.00, 0.00, 0.00, 0.00, 'BOTH', TRUE),
('GST 5%', 2.50, 2.50, 5.00, 0.00, 5.00, 'BOTH', TRUE),
('GST 12%', 6.00, 6.00, 12.00, 0.00, 12.00, 'BOTH', TRUE),
('GST 18%', 9.00, 9.00, 18.00, 0.00, 18.00, 'BOTH', TRUE),
('GST 28%', 14.00, 14.00, 28.00, 0.00, 28.00, 'BOTH', TRUE);

-- =====================================================
-- CURRENCY
-- =====================================================

INSERT INTO currency (currency_code, currency_name, currency_symbol, decimal_places, exchange_rate, is_active, is_base_currency) VALUES
('LKR', 'Sri Lankan Rupee', 'Rs.', 2, 1.00, TRUE, TRUE),
('USD', 'US Dollar', '$', 2, 320.00, TRUE, FALSE),
('EUR', 'Euro', '€', 2, 350.00, TRUE, FALSE),
('GBP', 'British Pound', '£', 2, 400.00, TRUE, FALSE),
('INR', 'Indian Rupee', '₹', 2, 3.85, TRUE, FALSE);

-- =====================================================
-- PAYMENT TERMS
-- =====================================================

INSERT INTO payment_terms (term_code, term_name, term_description, credit_days, payment_type, is_active) VALUES
('CASH', 'Cash on Delivery', 'Immediate payment', 0, 'IMMEDIATE', TRUE),
('NET7', 'Net 7 Days', 'Payment within 7 days', 7, 'NET_DAYS', TRUE),
('NET15', 'Net 15 Days', 'Payment within 15 days', 15, 'NET_DAYS', TRUE),
('NET30', 'Net 30 Days', 'Payment within 30 days', 30, 'NET_DAYS', TRUE),
('NET45', 'Net 45 Days', 'Payment within 45 days', 45, 'NET_DAYS', TRUE),
('NET60', 'Net 60 Days', 'Payment within 60 days', 60, 'NET_DAYS', TRUE),
('ADV100', '100% Advance', 'Full payment in advance', 0, 'ADVANCE', TRUE),
('ADV50', '50% Advance', '50% advance, balance on delivery', 0, 'ADVANCE', TRUE);

-- =====================================================
-- ITEM GROUPS
-- =====================================================

INSERT INTO item_group (group_code, group_name, group_description, group_level, is_active) VALUES
('RAW-MAT', 'Raw Materials', 'Raw materials for production', 1, TRUE),
('FIN-GOODS', 'Finished Goods', 'Finished products', 1, TRUE),
('CONSUMABLES', 'Consumables', 'Consumable items', 1, TRUE),
('SPARE-PARTS', 'Spare Parts', 'Spare parts and accessories', 1, TRUE),
('ELECTRONICS', 'Electronics', 'Electronic items', 1, TRUE),
('FURNITURE', 'Furniture', 'Furniture items', 1, TRUE),
('STATIONERY', 'Stationery', 'Office stationery', 1, TRUE);

-- =====================================================
-- ITEM CATEGORIES
-- =====================================================

INSERT INTO item_category (category_code, category_name, category_description, is_active) VALUES
('STANDARD', 'Standard', 'Standard items', TRUE),
('PREMIUM', 'Premium', 'Premium quality items', TRUE),
('ECONOMY', 'Economy', 'Economy range items', TRUE),
('LUXURY', 'Luxury', 'Luxury items', TRUE);

-- =====================================================
-- BRANDS
-- =====================================================

INSERT INTO brand (brand_code, brand_name, manufacturer_name, country, is_active) VALUES
('SAMSUNG', 'Samsung', 'Samsung Electronics', 'South Korea', TRUE),
('APPLE', 'Apple', 'Apple Inc.', 'USA', TRUE),
('SONY', 'Sony', 'Sony Corporation', 'Japan', TRUE),
('LG', 'LG', 'LG Electronics', 'South Korea', TRUE),
('DELL', 'Dell', 'Dell Technologies', 'USA', TRUE);

-- =====================================================
-- PARTY GROUPS
-- =====================================================

INSERT INTO party_group (group_code, group_name, group_description, group_type, default_credit_days, default_price_list, is_active) VALUES
('RETAIL-CUST', 'Retail Customers', 'Individual retail customers', 'CUSTOMER_GROUP', 0, 'RETAIL', TRUE),
('WHOLESALE-CUST', 'Wholesale Customers', 'Wholesale customers', 'CUSTOMER_GROUP', 30, 'WHOLESALE', TRUE),
('DIST-CUST', 'Distributors', 'Authorized distributors', 'CUSTOMER_GROUP', 45, 'DISTRIBUTOR', TRUE),
('LOCAL-SUPP', 'Local Suppliers', 'Local suppliers', 'SUPPLIER_GROUP', 30, NULL, TRUE),
('IMPORT-SUPP', 'Import Suppliers', 'International suppliers', 'SUPPLIER_GROUP', 60, NULL, TRUE);

-- =====================================================
-- WAREHOUSES
-- =====================================================

INSERT INTO warehouse (warehouse_code, warehouse_name, warehouse_type, city, state, country, is_active) VALUES
('WH-MAIN', 'Main Warehouse', 'MAIN', 'Colombo', 'Western', 'Sri Lanka', TRUE),
('WH-BRANCH-01', 'Branch Warehouse - Kandy', 'BRANCH', 'Kandy', 'Central', 'Sri Lanka', TRUE),
('WH-BRANCH-02', 'Branch Warehouse - Galle', 'BRANCH', 'Galle', 'Southern', 'Sri Lanka', TRUE),
('WH-TRANSIT', 'Transit Warehouse', 'TRANSIT', 'Colombo', 'Western', 'Sri Lanka', TRUE);

-- =====================================================
-- DEPARTMENTS
-- =====================================================

INSERT INTO department (department_code, department_name, department_description, is_active) VALUES
('SALES', 'Sales', 'Sales department', TRUE),
('PURCHASE', 'Purchase', 'Purchase department', TRUE),
('ACCOUNTS', 'Accounts', 'Accounts department', TRUE),
('HR', 'Human Resources', 'HR department', TRUE),
('IT', 'Information Technology', 'IT department', TRUE),
('WAREHOUSE', 'Warehouse', 'Warehouse operations', TRUE),
('PRODUCTION', 'Production', 'Production department', TRUE);

-- =====================================================
-- TERRITORIES
-- =====================================================

INSERT INTO territory (territory_code, territory_name, region, zone, is_active) VALUES
('WEST-COL', 'Western - Colombo', 'Western Province', 'Zone 1', TRUE),
('WEST-GAM', 'Western - Gampaha', 'Western Province', 'Zone 1', TRUE),
('CENT-KAN', 'Central - Kandy', 'Central Province', 'Zone 2', TRUE),
('SOUTH-GAL', 'Southern - Galle', 'Southern Province', 'Zone 3', TRUE),
('NORTH-JAF', 'Northern - Jaffna', 'Northern Province', 'Zone 4', TRUE);

-- =====================================================
-- PRICE LISTS
-- =====================================================

INSERT INTO price_list (price_list_code, price_list_name, price_list_type, currency_id, is_active, is_default) VALUES
('RETAIL', 'Retail Price List', 'RETAIL', (SELECT currency_id FROM currency WHERE currency_code = 'LKR'), TRUE, TRUE),
('WHOLESALE', 'Wholesale Price List', 'WHOLESALE', (SELECT currency_id FROM currency WHERE currency_code = 'LKR'), TRUE, FALSE),
('DISTRIBUTOR', 'Distributor Price List', 'DISTRIBUTOR', (SELECT currency_id FROM currency WHERE currency_code = 'LKR'), TRUE, FALSE);

