/*  
=============================================================
 PostgreSQL Script: Drop and Recreate a Data Warehouse  
=============================================================

Purpose:  
This script safely drops and recreates the `datawarehouse` database in PostgreSQL.  
It ensures that existing connections are terminated before dropping the database  
to avoid "database is being accessed" errors.  

Recommended Usage:  
- Run this script inside the `psql` terminal for best results.  
- Using `pgAdmin` may cause session issues because `pgAdmin` keeps an open  
  connection to the database being dropped.  
- Ensure you have proper backups before running this script, as it deletes all data  
  in the existing `datawarehouse` database.

What This Script Does:  
1. Switches to `postgres` database to avoid connection conflicts.  
2. Terminates all active connections to `datawarehouse`.  
3. Drops `datawarehouse` if it exists (avoids errors if it's already absent).  
4. Creates a new `datawarehouse` database from scratch.  
5. Reconnects to `datawarehouse` to continue database setup.  
6. Creates `bronze`, `silver`, and `gold` schemas for structured data storage.  
*/

-- Step 1: Switch to `postgres` to avoid self-disconnection issues
\connect postgres;

-- Step 2: Terminate any active connections to `datawarehouse`
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'datawarehouse';

-- Step 3: Drop `datawarehouse` if it exists to start fresh
DROP DATABASE IF EXISTS datawarehouse;

-- Step 4: Create a new `datawarehouse` database
CREATE DATABASE datawarehouse;

-- Step 5: Connect to the newly created `datawarehouse` database
\connect datawarehouse;

-- Step 6: Create schemas for structured data processing
CREATE SCHEMA bronze;  -- Stores raw ingested data
CREATE SCHEMA silver;  -- Stores cleaned and transformed data
CREATE SCHEMA gold;    -- Stores final, enriched datasets for analysis

/*  
=============================================================
 Database setup is now complete  
=============================================================
*/
