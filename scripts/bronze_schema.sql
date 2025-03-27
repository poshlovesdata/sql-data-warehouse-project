-- Start a transaction to ensure all table creation operations execute as a single unit
BEGIN;

-- Drop and recreate the customer information table in the bronze schema
DROP TABLE IF EXISTS bronze.crm_cust_info;
CREATE TABLE bronze.crm_cust_info (
    cust_id INT,
    cst_key VARCHAR,
    cst_firstname VARCHAR(50),
    cst_lastname VARCHAR(50),
    cst_marital_status VARCHAR(50),
    cst_gender VARCHAR(50),
    cst_create_date DATE
);

-- Drop and recreate the product information table in the bronze schema
DROP TABLE IF EXISTS bronze.prd_info;
CREATE TABLE bronze.prd_info (
    prd_id INT,
    prd_key VARCHAR(50),
    prd_nm VARCHAR(50),
    prd_cost INT,
    prd_line VARCHAR(50),
    prd_start_dt TIMESTAMP,
    prd_end_dt TIMESTAMP
);

-- Drop and recreate the sales transaction details table in the bronze schema
DROP TABLE IF EXISTS bronze.sales_details;
CREATE TABLE bronze.sales_details (
    sls_ord_num VARCHAR(50),
    sls_prod_key VARCHAR(50),
    sls_cust_id INT,
    sls_order_dt INT,
    sls_ship_dt INT,
    sls_due_dt INT,
    sls_sales INT,
    sls_quantity INT,
    sls_price INT
);

-- Drop and recreate the customer-specific data table in the bronze schema
DROP TABLE IF EXISTS bronze.cust_az12;
CREATE TABLE bronze.cust_az12 (
    cid VARCHAR(50),
    bdate DATE,
    gen VARCHAR(50)
);

-- Drop and recreate the customer location details table in the bronze schema
DROP TABLE IF EXISTS bronze.loc_a101;
CREATE TABLE bronze.loc_a101 (
    cid VARCHAR(50),
    cntry VARCHAR(50)
);

-- Drop and recreate the product category and maintenance information table in the bronze schema
DROP TABLE IF EXISTS bronze.px_cat_g1v2;
CREATE TABLE bronze.px_cat_g1v2 (
    id VARCHAR(50),
    cat VARCHAR(50),
    maintenance VARCHAR(50)
);

-- Commit the transaction, ensuring all table creations are applied
COMMIT;
