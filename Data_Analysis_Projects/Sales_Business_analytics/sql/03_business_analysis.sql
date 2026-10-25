-- ============================================================
-- SALES & BUSINESS ANALYTICS
-- 03_business_analysis.sql
-- Business Analysis Queries
-- ============================================================


-- ============================================================
-- 1. TOTAL SALES
-- ============================================================

SELECT
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data;


-- ============================================================
-- 2. TOTAL ORDERS
-- ============================================================

SELECT
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_data;


-- ============================================================
-- 3. TOTAL CUSTOMERS
-- ============================================================

SELECT
    COUNT(DISTINCT customer_id) AS total_customers
FROM sales_data;


-- ============================================================
-- 4. TOTAL PRODUCTS
-- ============================================================

SELECT
    COUNT(DISTINCT product_id) AS total_products
FROM sales_data;


-- ============================================================
-- 5. AVERAGE ORDER VALUE
-- ============================================================

SELECT
    ROUND(
        SUM(sales) /
        NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value
FROM sales_data;


-- ============================================================
-- 6. AVERAGE CUSTOMER SALES
-- ============================================================

SELECT
    ROUND(
        SUM(sales) /
        NULLIF(COUNT(DISTINCT customer_id), 0),
        2
    ) AS average_customer_sales
FROM sales_data;

-- ============================================================
-- 7. SALES BY CATEGORY
-- ============================================================

SELECT
    category,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY category
ORDER BY total_sales DESC;

-- ============================================================
-- 8. SALES BY SUB-CATEGORY
-- ============================================================

SELECT
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY sub_category
ORDER BY total_sales DESC;

-- ============================================================
-- 9. CATEGORY AND SUB-CATEGORY PERFORMANCE
-- ============================================================

SELECT
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY
    category,
    sub_category
ORDER BY
    category,
    total_sales DESC;

-- ============================================================
-- 10. SALES BY REGION
-- ============================================================

SELECT
    region,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY region
ORDER BY total_sales DESC;


-- ============================================================
-- 11. SALES BY STATE
-- ============================================================

SELECT
    state,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY state
ORDER BY total_sales DESC;


-- ============================================================
-- 12. TOP 10 STATES
-- ============================================================

SELECT
    state,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY state
ORDER BY total_sales DESC
LIMIT 10;


-- ============================================================
-- 13. SALES BY CUSTOMER SEGMENT
-- ============================================================

SELECT
    segment,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY segment
ORDER BY total_sales DESC;


-- ============================================================
-- 14. SALES BY SHIP MODE
-- ============================================================

SELECT
    ship_mode,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_data
GROUP BY ship_mode
ORDER BY total_sales DESC;
Section J — Monthly Sales


-- ============================================================
-- 15. MONTHLY SALES
-- ============================================================

SELECT
    DATE_TRUNC('month', order_date)::DATE AS month,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY month
ORDER BY month;


-- ============================================================
-- 16. QUARTERLY SALES
-- ============================================================

SELECT
    DATE_TRUNC('quarter', order_date)::DATE AS quarter,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY quarter
ORDER BY quarter;


-- ============================================================
-- 17. YEARLY SALES
-- ============================================================

SELECT
    EXTRACT(YEAR FROM order_date)::INTEGER AS year,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY year
ORDER BY year;


-- ============================================================
-- 18. YEAR + MONTH SALES
-- ============================================================

SELECT
    EXTRACT(YEAR FROM order_date)::INTEGER AS year,
    EXTRACT(MONTH FROM order_date)::INTEGER AS month,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY
    year,
    month
ORDER BY
    year,
    month;


-- ============================================================
-- 19. TOP 10 CUSTOMERS
-- ============================================================

SELECT
    customer_id,
    customer_name,
    ROUND(SUM(sales), 2) AS total_sales,
    COUNT(DISTINCT order_id) AS total_orders
FROM sales_data
GROUP BY
    customer_id,
    customer_name
ORDER BY total_sales DESC
LIMIT 10;


-- ============================================================
-- 20. CUSTOMER SALES ANALYSIS
-- ============================================================

SELECT
    customer_id,
    customer_name,
    segment,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales,
    ROUND(
        SUM(sales) /
        NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value
FROM sales_data
GROUP BY
    customer_id,
    customer_name,
    segment
ORDER BY total_sales DESC;


-- ============================================================
-- 21. TOP 10 PRODUCTS
-- ============================================================

SELECT
    product_id,
    product_name,
    category,
    sub_category,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY
    product_id,
    product_name,
    category,
    sub_category
ORDER BY total_sales DESC
LIMIT 10;


-- ============================================================
-- 22. PRODUCT PERFORMANCE
-- ============================================================

SELECT
    product_id,
    product_name,
    category,
    sub_category,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY
    product_id,
    product_name,
    category,
    sub_category
ORDER BY total_sales DESC;


-- ============================================================
-- 23. SHIPPING PERFORMANCE
-- ============================================================

SELECT
    ship_mode,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(AVG(shipping_days), 2) AS average_shipping_days
FROM sales_data
GROUP BY ship_mode
ORDER BY average_shipping_days;


-- ============================================================
-- 24. REGION + CATEGORY PERFORMANCE
-- ============================================================

SELECT
    region,
    category,
    ROUND(SUM(sales), 2) AS total_sales
FROM sales_data
GROUP BY
    region,
    category
ORDER BY
    region,
    total_sales DESC;



-- ============================================================
-- 25. CATEGORY SALES CONTRIBUTION
-- ============================================================

WITH category_sales AS (

    SELECT
        category,
        SUM(sales) AS total_sales
    FROM sales_data
    GROUP BY category

)

SELECT
    category,
    ROUND(total_sales, 2) AS total_sales,
    ROUND(
        total_sales * 100.0 /
        SUM(total_sales) OVER (),
        2
    ) AS sales_percentage
FROM category_sales
ORDER BY total_sales DESC;
