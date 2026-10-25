-- ============================================================
-- SALES & BUSINESS ANALYTICS
-- 02_data_quality.sql
-- Data Quality & Validation
-- ============================================================


-- ============================================================
-- 1. TOTAL ROWS
-- ============================================================

SELECT
    COUNT(*) AS total_rows
FROM sales_data;


-- ============================================================
-- 2. CHECK DUPLICATE ROW_ID
-- ============================================================

SELECT
    row_id,
    COUNT(*) AS duplicate_count
FROM sales_data
GROUP BY row_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- ============================================================
-- 3. CHECK DUPLICATE ORDER_ID + PRODUCT_ID
-- ============================================================

SELECT
    order_id,
    product_id,
    COUNT(*) AS duplicate_count
FROM sales_data
GROUP BY
    order_id,
    product_id
HAVING COUNT(*) > 1
ORDER BY duplicate_count DESC;


-- ============================================================
-- 4. CHECK NULL VALUES
-- ============================================================

SELECT
    COUNT(*) FILTER (WHERE row_id IS NULL) AS null_row_id,
    COUNT(*) FILTER (WHERE order_id IS NULL) AS null_order_id,
    COUNT(*) FILTER (WHERE order_date IS NULL) AS null_order_date,
    COUNT(*) FILTER (WHERE customer_id IS NULL) AS null_customer_id,
    COUNT(*) FILTER (WHERE product_id IS NULL) AS null_product_id,
    COUNT(*) FILTER (WHERE sales IS NULL) AS null_sales
FROM sales_data;


-- ============================================================
-- 5. CHECK INVALID SALES
-- ============================================================

SELECT
    COUNT(*) AS invalid_sales_rows
FROM sales_data
WHERE sales <= 0;


-- ============================================================
-- 6. CHECK INVALID DATES
-- ============================================================

SELECT
    COUNT(*) AS invalid_date_rows
FROM sales_data
WHERE ship_date < order_date;


-- ============================================================
-- 7. CHECK SHIPPING DAYS
-- ============================================================

SELECT
    MIN(shipping_days) AS minimum_shipping_days,
    MAX(shipping_days) AS maximum_shipping_days,
    AVG(shipping_days) AS average_shipping_days
FROM sales_data;


-- ============================================================
-- 8. VERIFY SHIPPING DAYS
-- ============================================================

SELECT
    order_id,
    order_date,
    ship_date,
    shipping_days,
    (ship_date - order_date) AS calculated_shipping_days
FROM sales_data
WHERE shipping_days <>
      (ship_date - order_date)
LIMIT 20;


-- ============================================================
-- 9. CHECK CATEGORIES
-- ============================================================

SELECT DISTINCT
    category
FROM sales_data
ORDER BY category;


-- ============================================================
-- 10. CHECK SUB-CATEGORIES
-- ============================================================

SELECT DISTINCT
    sub_category
FROM sales_data
ORDER BY sub_category;


-- ============================================================
-- 11. CHECK REGIONS
-- ============================================================

SELECT DISTINCT
    region
FROM sales_data
ORDER BY region;


-- ============================================================
-- 12. CHECK SEGMENTS
-- ============================================================

SELECT DISTINCT
    segment
FROM sales_data
ORDER BY segment;


-- ============================================================
-- 13. CHECK SHIP MODES
-- ============================================================

SELECT DISTINCT
    ship_mode
FROM sales_data
ORDER BY ship_mode;


-- ============================================================
-- 14. CHECK DATE RANGE
-- ============================================================

SELECT
    MIN(order_date) AS first_order_date,
    MAX(order_date) AS last_order_date
FROM sales_data;


-- ============================================================
-- 15. CHECK SALES STATISTICS
-- ============================================================

SELECT
    MIN(sales) AS minimum_sales,
    MAX(sales) AS maximum_sales,
    ROUND(AVG(sales), 2) AS average_sales,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data;