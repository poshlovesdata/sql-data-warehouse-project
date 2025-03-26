-- Switch to a different database to avoid connection issues
\connect postgres;

-- Terminate active connections to the database
SELECT pg_terminate_backend(pid)
FROM pg_stat_activity
WHERE datname = 'datawarehouse';

-- Drop the database if it exists
DROP DATABASE IF EXISTS datawarehouse;

-- Create the new database
CREATE DATABASE datawarehouse;

-- Connect to the new database
\connect datawarehouse;

-- Create schemas
CREATE SCHEMA bronze;
CREATE SCHEMA silver;
CREATE SCHEMA gold;
