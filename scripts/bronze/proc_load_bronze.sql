/*  
=============================================================  
 PostgreSQL Script: Load Data into Bronze Tables  
=============================================================  

Purpose:  
This procedure loads CSV data into the `bronze` schema tables.  
It truncates each table before loading new data to ensure no duplication.  
Errors during the load process are captured and displayed as warnings.  

Recommended Usage:  
- Run this script inside the `psql` terminal for best results.  
- Ensure that the `bronze` schema and tables exist before executing this procedure.  
- The file paths should be updated based on the actual CSV file locations on your system.  
*/

CREATE OR REPLACE PROCEDURE bronze.load_bronze_tables()
LANGUAGE plpgsql
AS $$
DECLARE 
	startTime TIMESTAMP;
	endTime TIMESTAMP;
BEGIN
	-- Capture the start time for performance monitoring  
	startTime := clock_timestamp();
    RAISE NOTICE 'Loading Bronze layer...';

    -- Load data into crm_cust_info table  
    BEGIN
        TRUNCATE TABLE bronze.crm_cust_info;
        COPY bronze.crm_cust_info (cst_id, cst_key, cst_firstname, cst_lastname, cst_marital_status, cst_gndr, cst_create_date)
        FROM 'C:/SQL Data Warehouse/datasets/source_crm/cust_info.csv'
        DELIMITER ','
        CSV HEADER;
    EXCEPTION WHEN others THEN
        RAISE WARNING 'Error loading crm_cust_info: %', SQLERRM;
    END;
	
    -- Load data into crm_prd_info table  
    BEGIN
        TRUNCATE TABLE bronze.crm_prd_info;
        COPY bronze.crm_prd_info (prd_id, prd_key, prd_nm, prd_cost, prd_line, prd_start_dt, prd_end_dt)
        FROM 'C:/SQL Data Warehouse/datasets/source_crm/prd_info.csv'
        DELIMITER ','
        CSV HEADER;
    EXCEPTION WHEN others THEN
        RAISE WARNING 'Error loading crm_prd_info: %', SQLERRM;
    END;

    -- Load data into crm_sales_details table  
    BEGIN
        TRUNCATE TABLE bronze.crm_sales_details;
        COPY bronze.crm_sales_details (sls_ord_num, sls_prd_key, sls_cust_id, sls_order_dt, sls_ship_dt, sls_due_dt, sls_sales, sls_quantity, sls_price)
        FROM 'C:/SQL Data Warehouse/datasets/source_crm/sales_details.csv'
        DELIMITER ','
        CSV HEADER;
    EXCEPTION WHEN others THEN
        RAISE WARNING 'Error loading crm_sales_details: %', SQLERRM;
    END;

    -- Load data into erp_cust_az12 table  
    BEGIN
        TRUNCATE TABLE bronze.erp_cust_az12;
        COPY bronze.erp_cust_az12 (cid, bdate, gen)
        FROM 'C:/SQL Data Warehouse/datasets/source_erp/cust_az12.csv'
        DELIMITER ','
        CSV HEADER;
    EXCEPTION WHEN others THEN
        RAISE WARNING 'Error loading erp_cust_az12: %', SQLERRM;
    END;

    -- Load data into erp_loc_a101 table  
    BEGIN
        TRUNCATE TABLE bronze.erp_loc_a101;
        COPY bronze.erp_loc_a101 (cid, cntry)
        FROM 'C:/SQL Data Warehouse/datasets/source_erp/loc_a101.csv'
        DELIMITER ','
        CSV HEADER;
    EXCEPTION WHEN others THEN
        RAISE WARNING 'Error loading erp_loc_a101: %', SQLERRM;
    END;

    -- Load data into erp_px_cat_g1v2 table  
    BEGIN
        TRUNCATE TABLE bronze.erp_px_cat_g1v2;
        COPY bronze.erp_px_cat_g1v2 (id, cat, subcat, maintenance)
        FROM 'C:/SQL Data Warehouse/datasets/source_erp/px_cat_g1v2.csv'
        DELIMITER ','
        CSV HEADER;
    EXCEPTION WHEN others THEN
        RAISE WARNING 'Error loading erp_px_cat_g1v2: %', SQLERRM;
    END;

    -- Indicate completion of the data loading process  
    RAISE NOTICE 'Finished loading tables into Bronze layer';
	
	-- Capture the end time  
	endTime := clock_timestamp();
	
	-- Display execution time  
    RAISE NOTICE 'Start Time: %', startTime;
    RAISE NOTICE 'End Time: %', endTime;
    RAISE NOTICE 'Elapsed Time: % seconds', EXTRACT(EPOCH FROM (endTime - startTime));

END;
$$;

/*  
=============================================================  
 Data loading procedure creation is complete  
=============================================================  
*/
