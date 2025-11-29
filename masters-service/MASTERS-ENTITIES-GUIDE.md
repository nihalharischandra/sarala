# Masters Service - Entity Documentation

## Overview
The Masters Service manages all master data for the Sarala ERP system, including Items, Parties, UOM, Batches, and various other reference data.

## Database: MySQL
- **Spring JDBC Template** is used instead of JPA for direct SQL control
- **Database**: `sarala_masters`
- **Port**: 8087

## Entity Relationships

### Core Master Entities

#### 1. Item Master (`item_master`)
**Purpose**: Complete product/inventory item information

**Key Fields**:
- `item_code` - Unique item identifier (e.g., ITEM-001)
- `item_name` - Full name of the item
- `hsn_code` - HSN/SAC code for taxation
- `item_type` - GOODS, SERVICES, FIXED_ASSET
- `item_nature` - TRADING, MANUFACTURING, CONSUMABLE

**Relationships**:
- Belongs to `item_group`
- Belongs to `item_category`
- Belongs to `brand`
- Has `primary_uom` and `secondary_uom`
- Has `gst_rate`
- Located in default `warehouse`

**Features**:
- Batch tracking support
- Serial number tracking
- Multi-level pricing (purchase, sale, MRP, wholesale)
- Stock level management (reorder, min, max)
- Barcode, SKU support

---

#### 2. Party Master (`party_master`)
**Purpose**: Unified master for all business partners (Customers, Suppliers, Employees, etc.)

**Key Fields**:
- `party_code` - Unique party identifier
- `party_type` - CUSTOMER, SUPPLIER, BOTH, EMPLOYEE, TRANSPORTER, AGENT
- `party_category` - RETAIL, WHOLESALE, DISTRIBUTOR, END_USER

**Contact Information**:
- Primary & alternate contact details
- Email, website

**Address**:
- Billing address (full)
- Separate shipping address

**Tax & Legal**:
- GST Number, PAN, TIN, VAT, Aadhar
- Registration type (REGULAR, COMPOSITION, UNREGISTERED)

**Credit Management**:
- Credit days and limits
- Opening balance (receivable/payable)

**Banking**:
- Bank account details for payments

**Features**:
- TDS/TCS applicability
- Agent commission tracking
- Loyalty points
- Customer rating (A, B, C)
- Blacklist support

---

#### 3. Unit of Measurement (`unit_of_measurement`)
**Purpose**: Define measurement units with conversion support

**Types**:
- WEIGHT (KG, GM)
- VOLUME (LTR, ML)
- LENGTH (MTR, CM, FT)
- QUANTITY (PCS, NOS, BOX, DOZ)
- AREA, TIME

**Features**:
- Base unit conversion
- Decimal place precision
- Conversion factors

---

#### 4. Batch Master (`batch_master`)
**Purpose**: Track inventory in batches with expiry dates

**Key Fields**:
- `batch_number` - Unique batch identifier
- `manufacturing_date` - Production date
- `expiry_date` - Expiry date
- `lot_number` - Manufacturing lot number

**Tracking**:
- Batch quantity vs available quantity
- Cost price & selling price per batch
- Warehouse & bin location
- Quality status (PASSED, FAILED, UNDER_INSPECTION)

---

#### 5. Item Group (`item_group`)
**Purpose**: Hierarchical categorization of items

**Features**:
- Multi-level hierarchy (parent-child)
- Default settings for group (UOM, GST rate)
- Batch applicability by default

---

#### 6. Warehouse (`warehouse`)
**Purpose**: Storage location management

**Types**:
- MAIN - Main warehouse
- BRANCH - Branch warehouse
- TRANSIT - Temporary storage
- VIRTUAL - Logical warehouse

**Features**:
- Full address details
- Contact information
- Capacity tracking
- Manager assignment

---

#### 7. GST Rate (`gst_rate`)
**Purpose**: Tax rate definitions

**Components**:
- CGST (Central GST)
- SGST (State GST)
- IGST (Integrated GST)
- CESS (Additional cess)

**Applicability**: GOODS, SERVICES, BOTH

---

#### 8. HSN/SAC Code (`hsn_sac_code`)
**Purpose**: Tax classification codes

**Types**:
- HSN - Harmonized System of Nomenclature (Goods)
- SAC - Service Accounting Code (Services)

**Hierarchy**:
- Chapter (2 digits)
- Heading (4 digits)
- Sub-heading (6 digits)

---

#### 9. Currency (`currency`)
**Purpose**: Multi-currency support

**Features**:
- Exchange rate management
- Decimal formatting
- Base currency designation

---

#### 10. Price List (`price_list` & `price_list_detail`)
**Purpose**: Different pricing for different customer categories

**Types**:
- RETAIL
- WHOLESALE
- DISTRIBUTOR
- SPECIAL

**Features**:
- Validity period (from/to dates)
- Item-wise rates with UOM
- Minimum rates
- Discount percentages

---

#### 11. Payment Terms (`payment_terms`)
**Purpose**: Credit and payment terms

**Types**:
- IMMEDIATE - Cash on delivery
- NET_DAYS - Payment within X days
- ADVANCE - Advance payment
- COD - Cash on delivery

**Features**:
- Early payment discounts
- Credit period definition

---

#### 12. Party Group (`party_group`)
**Purpose**: Categorize parties with default settings

**Types**:
- CUSTOMER_GROUP
- SUPPLIER_GROUP
- EMPLOYEE_GROUP

**Default Settings**:
- Credit days
- Credit limits
- Default price list

---

#### 13. Transporter (`transporter`)
**Purpose**: Logistics and transport providers

**Features**:
- Contact details
- GST & PAN for legal compliance
- Address information

---

#### 14. Department (`department`)
**Purpose**: Company organizational structure

**Features**:
- Hierarchical structure
- Department head assignment
- Location tracking

---

#### 15. Territory (`territory`)
**Purpose**: Sales territory management

**Features**:
- Hierarchical structure
- Territory manager assignment
- Region and zone classification

---

## Data Types Used

### Common Patterns
- **IDs**: `BIGINT AUTO_INCREMENT`
- **Codes**: `VARCHAR(50-100)` - Unique identifiers
- **Names**: `VARCHAR(200-300)` - Display names
- **Amounts**: `DECIMAL(18,2)` - Monetary values
- **Quantities**: `DECIMAL(18,3)` - Inventory quantities
- **Percentages**: `DECIMAL(5,2)` - Rates, discounts
- **Dates**: `DATE` - Date only
- **Timestamps**: `DATETIME` - Date and time

### Audit Fields (All Tables)
- `created_at` - Record creation timestamp
- `created_by` - User who created
- `updated_at` - Last update timestamp
- `updated_by` - User who last updated
- `version` - Optimistic locking version

### Status Fields
- `is_active` - Soft delete flag (TRUE/FALSE)
- `remarks` - Additional notes (TEXT)

## Meaningful Column Names

All column names follow these principles:
1. **Self-descriptive**: `credit_days` instead of `cd`
2. **Clear purpose**: `opening_balance_type` instead of `obt`
3. **Standard naming**: `snake_case` for consistency
4. **Full words**: `quantity` instead of `qty`
5. **Contextual**: `primary_contact_person` instead of `contact`

## Index Strategy

**Primary Indexes**:
- Unique codes (item_code, party_code, etc.)
- Foreign keys
- Frequently searched fields

**Performance Indexes**:
- Active status flags
- Date fields (expiry_date)
- Search fields (names, mobile numbers)

## Best Practices

1. **Always use meaningful codes** - e.g., ITEM-ELEC-001 for electronics
2. **Maintain audit trail** - All tables have created/updated tracking
3. **Soft deletes** - Use is_active flag instead of DELETE
4. **Version control** - Optimistic locking with version field
5. **Proper data types** - DECIMAL for money, BIGINT for IDs
6. **Referential integrity** - Foreign keys with proper constraints

## Sample Data
Sample data is provided in `sample-data.sql` including:
- Common UOMs (KG, LTR, PCS, etc.)
- Standard GST rates (0%, 5%, 12%, 18%, 28%)
- Currency setup (LKR, USD, EUR, etc.)
- Payment terms (Cash, Net 30, etc.)
- Basic warehouses and departments

