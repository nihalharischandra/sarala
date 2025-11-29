-- Sarala ERP Masters Database Schema
-- MySQL Database Schema for Masters Service

USE sarala_masters;

-- =====================================================
-- ITEM RELATED MASTERS
-- =====================================================

-- Item Group Master
CREATE TABLE IF NOT EXISTS item_group (
    group_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    group_code VARCHAR(50) NOT NULL UNIQUE,
    group_name VARCHAR(200) NOT NULL,
    group_description TEXT,
    parent_group_id BIGINT,
    group_level INT DEFAULT 1,
    default_uom_id BIGINT,
    default_gst_rate_id BIGINT,
    is_batch_applicable_by_default BOOLEAN DEFAULT FALSE,
    is_active BOOLEAN DEFAULT TRUE,
    remarks TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,
    FOREIGN KEY (parent_group_id) REFERENCES item_group(group_id),
    INDEX idx_group_code (group_code),
    INDEX idx_parent_group (parent_group_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Item Category Master
CREATE TABLE IF NOT EXISTS item_category (
    category_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    category_code VARCHAR(50) NOT NULL UNIQUE,
    category_name VARCHAR(200) NOT NULL,
    category_description TEXT,
    is_active BOOLEAN DEFAULT TRUE,
    remarks TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,
    INDEX idx_category_code (category_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Brand Master
CREATE TABLE IF NOT EXISTS brand (
    brand_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    brand_code VARCHAR(50) NOT NULL UNIQUE,
    brand_name VARCHAR(200) NOT NULL,
    brand_description TEXT,
    manufacturer_name VARCHAR(200),
    country VARCHAR(100),
    website VARCHAR(255),
    is_active BOOLEAN DEFAULT TRUE,
    remarks TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,
    INDEX idx_brand_code (brand_code),
    INDEX idx_brand_name (brand_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Unit of Measurement Master
CREATE TABLE IF NOT EXISTS unit_of_measurement (
    uom_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    uom_code VARCHAR(20) NOT NULL UNIQUE,
    uom_name VARCHAR(100) NOT NULL,
    uom_symbol VARCHAR(20),
    uom_type VARCHAR(50) COMMENT 'WEIGHT, VOLUME, LENGTH, QUANTITY, AREA, TIME',
    decimal_places INT DEFAULT 2,
    base_uom_id BIGINT,
    conversion_factor DECIMAL(18,6) DEFAULT 1.00,
    is_active BOOLEAN DEFAULT TRUE,
    remarks TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,
    FOREIGN KEY (base_uom_id) REFERENCES unit_of_measurement(uom_id),
    INDEX idx_uom_code (uom_code),
    INDEX idx_uom_type (uom_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- GST Rate Master
CREATE TABLE IF NOT EXISTS gst_rate (
    gst_rate_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    rate_name VARCHAR(100) NOT NULL,
    cgst_rate DECIMAL(5,2) DEFAULT 0.00,
    sgst_rate DECIMAL(5,2) DEFAULT 0.00,
    igst_rate DECIMAL(5,2) DEFAULT 0.00,
    cess_rate DECIMAL(5,2) DEFAULT 0.00,
    total_gst_rate DECIMAL(5,2) DEFAULT 0.00,
    applicable_on VARCHAR(50) COMMENT 'GOODS, SERVICES, BOTH',
    is_active BOOLEAN DEFAULT TRUE,
    remarks TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,
    INDEX idx_total_rate (total_gst_rate)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- HSN/SAC Code Master
CREATE TABLE IF NOT EXISTS hsn_sac_code (
    hsn_sac_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    code VARCHAR(20) NOT NULL UNIQUE,
    code_type VARCHAR(10) COMMENT 'HSN, SAC',
    description TEXT,
    default_gst_rate_id BIGINT,
    chapter VARCHAR(2),
    heading VARCHAR(4),
    sub_heading VARCHAR(6),
    is_active BOOLEAN DEFAULT TRUE,
    remarks TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,
    FOREIGN KEY (default_gst_rate_id) REFERENCES gst_rate(gst_rate_id),
    INDEX idx_code (code),
    INDEX idx_code_type (code_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Item Master
CREATE TABLE IF NOT EXISTS item_master (
    item_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    item_code VARCHAR(100) NOT NULL UNIQUE,
    item_name VARCHAR(300) NOT NULL,
    print_name VARCHAR(300),
    item_description TEXT,

    -- Category & Classification
    item_group_id BIGINT,
    item_category_id BIGINT,
    brand_id BIGINT,
    hsn_code VARCHAR(20),

    -- Unit of Measurement
    primary_uom_id BIGINT,
    secondary_uom_id BIGINT,
    conversion_factor DECIMAL(18,6) DEFAULT 1.00,

    -- Item Type & Nature
    item_type VARCHAR(50) COMMENT 'GOODS, SERVICES, FIXED_ASSET',
    item_nature VARCHAR(50) COMMENT 'TRADING, MANUFACTURING, CONSUMABLE',
    is_batch_applicable BOOLEAN DEFAULT FALSE,
    is_serial_number_applicable BOOLEAN DEFAULT FALSE,
    is_expiry_applicable BOOLEAN DEFAULT FALSE,

    -- Pricing
    purchase_rate DECIMAL(18,2) DEFAULT 0.00,
    sale_rate DECIMAL(18,2) DEFAULT 0.00,
    mrp DECIMAL(18,2) DEFAULT 0.00,
    minimum_sale_rate DECIMAL(18,2) DEFAULT 0.00,
    wholesale_rate DECIMAL(18,2) DEFAULT 0.00,

    -- Stock Control
    opening_stock DECIMAL(18,3) DEFAULT 0.000,
    opening_stock_value DECIMAL(18,2) DEFAULT 0.00,
    reorder_level DECIMAL(18,3) DEFAULT 0.000,
    reorder_quantity DECIMAL(18,3) DEFAULT 0.000,
    minimum_stock_level DECIMAL(18,3) DEFAULT 0.000,
    maximum_stock_level DECIMAL(18,3) DEFAULT 0.000,

    -- Tax Information
    gst_rate_id BIGINT,
    is_taxable BOOLEAN DEFAULT TRUE,
    tax_preference VARCHAR(50) COMMENT 'TAXABLE, EXEMPT, NIL_RATED',

    -- Location
    rack_number VARCHAR(50),
    bin_location VARCHAR(50),
    default_warehouse_id BIGINT,

    -- Additional Details
    barcode VARCHAR(100),
    manufacturer_part_number VARCHAR(100),
    sku VARCHAR(100),
    weight DECIMAL(10,3),
    weight_unit VARCHAR(20),
    dimension_length VARCHAR(20),
    dimension_width VARCHAR(20),
    dimension_height VARCHAR(20),
    dimension_unit VARCHAR(20),

    -- Accounting
    sales_account_id BIGINT,
    purchase_account_id BIGINT,
    stock_account_id BIGINT,

    -- Status & Control
    is_active BOOLEAN DEFAULT TRUE,
    is_discontinued BOOLEAN DEFAULT FALSE,
    remarks TEXT,

    -- Audit Fields
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,

    FOREIGN KEY (item_group_id) REFERENCES item_group(group_id),
    FOREIGN KEY (item_category_id) REFERENCES item_category(category_id),
    FOREIGN KEY (brand_id) REFERENCES brand(brand_id),
    FOREIGN KEY (primary_uom_id) REFERENCES unit_of_measurement(uom_id),
    FOREIGN KEY (secondary_uom_id) REFERENCES unit_of_measurement(uom_id),
    FOREIGN KEY (gst_rate_id) REFERENCES gst_rate(gst_rate_id),

    INDEX idx_item_code (item_code),
    INDEX idx_item_name (item_name),
    INDEX idx_item_group (item_group_id),
    INDEX idx_barcode (barcode),
    INDEX idx_sku (sku),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- PARTY RELATED MASTERS
-- =====================================================

-- Party Group Master
CREATE TABLE IF NOT EXISTS party_group (
    group_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    group_code VARCHAR(50) NOT NULL UNIQUE,
    group_name VARCHAR(200) NOT NULL,
    group_description TEXT,
    group_type VARCHAR(50) COMMENT 'CUSTOMER_GROUP, SUPPLIER_GROUP, EMPLOYEE_GROUP',
    default_credit_days INT DEFAULT 0,
    default_credit_limit DECIMAL(18,2) DEFAULT 0.00,
    default_price_list VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    remarks TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,
    INDEX idx_group_code (group_code),
    INDEX idx_group_type (group_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Party Master
CREATE TABLE IF NOT EXISTS party_master (
    party_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    party_code VARCHAR(100) NOT NULL UNIQUE,
    party_name VARCHAR(300) NOT NULL,
    print_name VARCHAR(300),

    -- Party Type & Category
    party_type VARCHAR(50) COMMENT 'CUSTOMER, SUPPLIER, BOTH, EMPLOYEE, TRANSPORTER, AGENT',
    party_group_id BIGINT,
    party_category VARCHAR(50) COMMENT 'RETAIL, WHOLESALE, DISTRIBUTOR, END_USER',

    -- Contact Information
    primary_contact_person VARCHAR(200),
    designation VARCHAR(100),
    mobile_number VARCHAR(20),
    alternate_number VARCHAR(20),
    email_address VARCHAR(255),
    website VARCHAR(255),

    -- Address Details
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    address_line3 VARCHAR(255),
    city VARCHAR(100),
    district VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),

    -- Shipping Address
    shipping_address_line1 VARCHAR(255),
    shipping_address_line2 VARCHAR(255),
    shipping_city VARCHAR(100),
    shipping_state VARCHAR(100),
    shipping_postal_code VARCHAR(20),

    -- Tax & Legal Information
    gst_number VARCHAR(20),
    pan_number VARCHAR(20),
    tin_number VARCHAR(20),
    vat_number VARCHAR(20),
    aadhar_number VARCHAR(20),
    registration_type VARCHAR(50) COMMENT 'REGULAR, COMPOSITION, UNREGISTERED',

    -- Credit & Payment Terms
    credit_days INT DEFAULT 0,
    credit_limit DECIMAL(18,2) DEFAULT 0.00,
    payment_terms VARCHAR(100),
    default_price_list VARCHAR(50),

    -- Banking Details
    bank_name VARCHAR(200),
    bank_branch VARCHAR(200),
    account_number VARCHAR(50),
    ifsc_code VARCHAR(20),
    account_holder_name VARCHAR(200),

    -- Opening Balance
    opening_balance DECIMAL(18,2) DEFAULT 0.00,
    opening_balance_type VARCHAR(20) COMMENT 'RECEIVABLE, PAYABLE',
    opening_balance_date DATE,

    -- Business Details
    business_type VARCHAR(100),
    incorporation_date DATE,
    license_number VARCHAR(100),

    -- Tax Settings
    is_tds_applicable BOOLEAN DEFAULT FALSE,
    is_tcs_applicable BOOLEAN DEFAULT FALSE,
    tds_rate_id BIGINT,
    tcs_rate_id BIGINT,

    -- Agent/Commission Details
    agent_id BIGINT,
    commission_rate DECIMAL(5,2) DEFAULT 0.00,

    -- Additional Information
    territory_id BIGINT,
    industry_type VARCHAR(100),
    remarks TEXT,
    reference_source VARCHAR(200),

    -- Loyalty & Rating
    customer_rating VARCHAR(10) COMMENT 'A, B, C',
    loyalty_points INT DEFAULT 0,

    -- Status & Control
    is_active BOOLEAN DEFAULT TRUE,
    is_blacklisted BOOLEAN DEFAULT FALSE,
    blacklist_reason TEXT,

    -- Audit Fields
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,

    FOREIGN KEY (party_group_id) REFERENCES party_group(group_id),

    INDEX idx_party_code (party_code),
    INDEX idx_party_name (party_name),
    INDEX idx_party_type (party_type),
    INDEX idx_gst_number (gst_number),
    INDEX idx_mobile_number (mobile_number),
    INDEX idx_active (is_active)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- WAREHOUSE & STORAGE
-- =====================================================

-- Warehouse Master
CREATE TABLE IF NOT EXISTS warehouse (
    warehouse_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    warehouse_code VARCHAR(50) NOT NULL UNIQUE,
    warehouse_name VARCHAR(200) NOT NULL,
    warehouse_type VARCHAR(50) COMMENT 'MAIN, BRANCH, TRANSIT, VIRTUAL',

    -- Location Details
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    state VARCHAR(100),
    country VARCHAR(100),
    postal_code VARCHAR(20),

    -- Contact Information
    contact_person VARCHAR(200),
    phone_number VARCHAR(20),
    email_address VARCHAR(255),

    -- Capacity
    total_capacity DECIMAL(18,3),
    capacity_unit VARCHAR(20),

    -- Warehouse Manager
    manager_id BIGINT,

    -- Status
    is_active BOOLEAN DEFAULT TRUE,
    remarks TEXT,

    -- Audit Fields
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,

    INDEX idx_warehouse_code (warehouse_code),
    INDEX idx_warehouse_type (warehouse_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Batch Master
CREATE TABLE IF NOT EXISTS batch_master (
    batch_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    batch_number VARCHAR(100) NOT NULL,
    item_id BIGINT NOT NULL,

    -- Batch Details
    manufacturing_date DATE,
    expiry_date DATE,
    lot_number VARCHAR(100),

    -- Quantity & Valuation
    batch_quantity DECIMAL(18,3) DEFAULT 0.000,
    available_quantity DECIMAL(18,3) DEFAULT 0.000,
    cost_price DECIMAL(18,2) DEFAULT 0.00,
    selling_price DECIMAL(18,2) DEFAULT 0.00,

    -- Storage Location
    warehouse_id BIGINT,
    rack_number VARCHAR(50),
    bin_location VARCHAR(50),

    -- Quality Control
    quality_status VARCHAR(50) COMMENT 'PASSED, FAILED, UNDER_INSPECTION',
    quality_remarks TEXT,

    -- Purchase Reference
    purchase_invoice_id BIGINT,
    supplier_batch_number VARCHAR(100),

    -- Status
    is_active BOOLEAN DEFAULT TRUE,
    remarks TEXT,

    -- Audit Fields
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,

    FOREIGN KEY (item_id) REFERENCES item_master(item_id),
    FOREIGN KEY (warehouse_id) REFERENCES warehouse(warehouse_id),

    UNIQUE KEY unique_batch_item (batch_number, item_id),
    INDEX idx_batch_number (batch_number),
    INDEX idx_item_id (item_id),
    INDEX idx_expiry_date (expiry_date)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- PRICING & CURRENCY
-- =====================================================

-- Currency Master
CREATE TABLE IF NOT EXISTS currency (
    currency_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    currency_code VARCHAR(10) NOT NULL UNIQUE,
    currency_name VARCHAR(100) NOT NULL,
    currency_symbol VARCHAR(10),

    -- Formatting
    decimal_places INT DEFAULT 2,
    thousands_separator VARCHAR(5) DEFAULT ',',
    decimal_separator VARCHAR(5) DEFAULT '.',

    -- Exchange Rate
    exchange_rate DECIMAL(18,6) DEFAULT 1.000000,
    base_currency VARCHAR(10),

    -- Status
    is_active BOOLEAN DEFAULT TRUE,
    is_base_currency BOOLEAN DEFAULT FALSE,
    remarks TEXT,

    -- Audit Fields
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,

    INDEX idx_currency_code (currency_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Price List Master
CREATE TABLE IF NOT EXISTS price_list (
    price_list_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    price_list_code VARCHAR(50) NOT NULL UNIQUE,
    price_list_name VARCHAR(200) NOT NULL,
    price_list_type VARCHAR(50) COMMENT 'RETAIL, WHOLESALE, DISTRIBUTOR, SPECIAL',
    currency_id BIGINT,
    valid_from DATETIME,
    valid_to DATETIME,
    is_active BOOLEAN DEFAULT TRUE,
    is_default BOOLEAN DEFAULT FALSE,
    remarks TEXT,

    -- Audit Fields
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,

    FOREIGN KEY (currency_id) REFERENCES currency(currency_id),
    INDEX idx_price_list_code (price_list_code),
    INDEX idx_price_list_type (price_list_type)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Price List Details
CREATE TABLE IF NOT EXISTS price_list_detail (
    price_list_detail_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    price_list_id BIGINT NOT NULL,
    item_id BIGINT NOT NULL,
    rate DECIMAL(18,2) DEFAULT 0.00,
    minimum_rate DECIMAL(18,2) DEFAULT 0.00,
    discount_percentage DECIMAL(5,2) DEFAULT 0.00,
    uom_id BIGINT,
    is_active BOOLEAN DEFAULT TRUE,

    -- Audit Fields
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,

    FOREIGN KEY (price_list_id) REFERENCES price_list(price_list_id),
    FOREIGN KEY (item_id) REFERENCES item_master(item_id),
    FOREIGN KEY (uom_id) REFERENCES unit_of_measurement(uom_id),

    UNIQUE KEY unique_price_list_item (price_list_id, item_id, uom_id),
    INDEX idx_price_list (price_list_id),
    INDEX idx_item (item_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- =====================================================
-- OTHER MASTERS
-- =====================================================

-- Payment Terms Master
CREATE TABLE IF NOT EXISTS payment_terms (
    payment_term_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    term_code VARCHAR(50) NOT NULL UNIQUE,
    term_name VARCHAR(200) NOT NULL,
    term_description TEXT,
    credit_days INT DEFAULT 0,
    payment_type VARCHAR(50) COMMENT 'IMMEDIATE, NET_DAYS, ADVANCE, COD',
    early_payment_discount_percentage DECIMAL(5,2) DEFAULT 0.00,
    early_payment_days INT DEFAULT 0,
    is_active BOOLEAN DEFAULT TRUE,
    remarks TEXT,

    -- Audit Fields
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,

    INDEX idx_term_code (term_code)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Transporter Master
CREATE TABLE IF NOT EXISTS transporter (
    transporter_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    transporter_code VARCHAR(50) NOT NULL UNIQUE,
    transporter_name VARCHAR(200) NOT NULL,
    contact_person VARCHAR(200),
    mobile_number VARCHAR(20),
    email_address VARCHAR(255),
    address VARCHAR(500),
    city VARCHAR(100),
    state VARCHAR(100),
    gst_number VARCHAR(20),
    pan_number VARCHAR(20),
    is_active BOOLEAN DEFAULT TRUE,
    remarks TEXT,

    -- Audit Fields
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,

    INDEX idx_transporter_code (transporter_code),
    INDEX idx_transporter_name (transporter_name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Department Master
CREATE TABLE IF NOT EXISTS department (
    department_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    department_code VARCHAR(50) NOT NULL UNIQUE,
    department_name VARCHAR(200) NOT NULL,
    department_description TEXT,
    parent_department_id BIGINT,
    department_head_id BIGINT,
    location VARCHAR(200),
    is_active BOOLEAN DEFAULT TRUE,
    remarks TEXT,

    -- Audit Fields
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,

    FOREIGN KEY (parent_department_id) REFERENCES department(department_id),
    INDEX idx_department_code (department_code),
    INDEX idx_parent_department (parent_department_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Territory Master
CREATE TABLE IF NOT EXISTS territory (
    territory_id BIGINT AUTO_INCREMENT PRIMARY KEY,
    territory_code VARCHAR(50) NOT NULL UNIQUE,
    territory_name VARCHAR(200) NOT NULL,
    territory_description TEXT,
    parent_territory_id BIGINT,
    territory_manager_id BIGINT,
    region VARCHAR(100),
    zone VARCHAR(100),
    is_active BOOLEAN DEFAULT TRUE,
    remarks TEXT,

    -- Audit Fields
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100),
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    updated_by VARCHAR(100),
    version BIGINT DEFAULT 0,

    FOREIGN KEY (parent_territory_id) REFERENCES territory(territory_id),
    INDEX idx_territory_code (territory_code),
    INDEX idx_parent_territory (parent_territory_id)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

