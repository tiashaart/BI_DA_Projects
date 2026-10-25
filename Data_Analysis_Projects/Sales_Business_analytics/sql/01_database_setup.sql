
-- ============================================================
-- SALES & BUSINESS ANALYTICS
-- 01_database_setup.sql
-- PostgreSQL Database Setup
-- ============================================================


-- ============================================================
-- 1. DROP EXISTING TABLE
-- ============================================================

DROP TABLE IF EXISTS sales_data;


-- ============================================================
-- 2. CREATE SALES TABLE
-- ============================================================

CREATE TABLE sales_data (
    
    row_id          INTEGER,
    order_id        VARCHAR(50),
    order_date      DATE,
    ship_date       DATE,
    ship_mode       VARCHAR(50),

    customer_id     VARCHAR(50),
    customer_name   VARCHAR(150),
    segment         VARCHAR(50),

    country         VARCHAR(100),
    city            VARCHAR(100),
    state           VARCHAR(100),
    postal_code     VARCHAR(20),
    region          VARCHAR(50),

    product_id      VARCHAR(50),
    category        VARCHAR(100),
    sub_category    VARCHAR(100),
    product_name    VARCHAR(255),

    sales           NUMERIC(12,2),

    shipping_days   INTEGER,

    year            INTEGER,
    month           INTEGER,
    month_name      VARCHAR(20),
    quarter         VARCHAR(10),
    year_month      VARCHAR(10)
);


-- ============================================================
-- 3. CHECK TABLE STRUCTURE
-- ============================================================

SELECT *
FROM sales_data
LIMIT 10;

SELECT COUNT(*)
FROM sales_data;

SELECT
    order_id,
    order_date,
    customer_name,
    category,
    sales
FROM sales_data
LIMIT 10;


-- ============================================================
-- 4. AFTER IMPORTING CSV, CHECK ROW COUNT
-- ============================================================

SELECT COUNT(*) AS total_rows
FROM sales_data;


-- ============================================================
-- 5. CREATE INDEXES
-- ============================================================

CREATE INDEX idx_sales_order_date
ON sales_data(order_date);

CREATE INDEX idx_sales_customer_id
ON sales_data(customer_id);

CREATE INDEX idx_sales_product_id
ON sales_data(product_id);

CREATE INDEX idx_sales_category
ON sales_data(category);

CREATE INDEX idx_sales_region
ON sales_data(region);


-- ============================================================
-- 6. BASIC DATA INFORMATION
-- ============================================================

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date,
    COUNT(*) AS total_records
FROM sales_data;