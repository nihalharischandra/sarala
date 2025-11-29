-- Database creation script for Sarala ERP - MySQL

-- Drop databases if they exist (use with caution!)
-- DROP DATABASE IF EXISTS sarala_inventory;
-- DROP DATABASE IF EXISTS sarala_accounts;
-- DROP DATABASE IF EXISTS sarala_sales;
-- DROP DATABASE IF EXISTS sarala_purchases;
-- DROP DATABASE IF EXISTS sarala_hr;
-- DROP DATABASE IF EXISTS sarala_taxation;
-- DROP DATABASE IF EXISTS sarala_masters;
-- DROP DATABASE IF EXISTS sarala_reports;
-- DROP DATABASE IF EXISTS sarala_settings;
-- DROP DATABASE IF EXISTS sarala_notifications;
-- DROP DATABASE IF EXISTS sarala_audit;

-- Create databases
CREATE DATABASE IF NOT EXISTS sarala_inventory CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS sarala_accounts CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS sarala_sales CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS sarala_purchases CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS sarala_hr CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS sarala_taxation CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS sarala_masters CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS sarala_reports CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS sarala_settings CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS sarala_notifications CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
CREATE DATABASE IF NOT EXISTS sarala_audit CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;

-- Note: MySQL uses database-level permissions
-- You can create a specific user and grant privileges like this:
-- CREATE USER 'sarala_user'@'localhost' IDENTIFIED BY 'sarala_password';
-- GRANT ALL PRIVILEGES ON sarala_*.* TO 'sarala_user'@'localhost';
-- FLUSH PRIVILEGES;
