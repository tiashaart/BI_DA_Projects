
-- ============================================================
-- SALES & BUSINESS ANALYTICS
-- 04_advanced_analysis.sql
-- Advanced SQL Analysis
-- ============================================================

-- ============================================================
-- 1. CATEGORY RANKING
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
    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS sales_rank
FROM category_sales
ORDER BY sales_rank;


-- ============================================================
-- 2. REGION RANKING
-- ============================================================

WITH region_sales AS (

    SELECT
        region,
        SUM(sales) AS total_sales
    FROM sales_data
    GROUP BY region

)

SELECT
    region,
    ROUND(total_sales, 2) AS total_sales,
    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS region_rank
FROM region_sales
ORDER BY region_rank;


-- ============================================================
-- 3. TOP 3 STATES WITHIN EACH REGION
-- ============================================================

WITH state_sales AS (

    SELECT
        region,
        state,
        SUM(sales) AS total_sales
    FROM sales_data
    GROUP BY
        region,
        state

),

ranked_states AS (

    SELECT
        region,
        state,
        total_sales,
        ROW_NUMBER() OVER (
            PARTITION BY region
            ORDER BY total_sales DESC
        ) AS state_rank
    FROM state_sales

)

SELECT
    region,
    state,
    ROUND(total_sales, 2) AS total_sales,
    state_rank
FROM ranked_states
WHERE state_rank <= 3
ORDER BY
    region,
    state_rank;


-- ============================================================
-- 4. MONTHLY RUNNING SALES
-- ============================================================

WITH monthly_sales AS (

    SELECT
        DATE_TRUNC('month', order_date)::DATE AS month,
        SUM(sales) AS monthly_sales
    FROM sales_data
    GROUP BY month

)

SELECT
    month,
    ROUND(monthly_sales, 2) AS monthly_sales,

    ROUND(
        SUM(monthly_sales) OVER (
            ORDER BY month
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        ),
        2
    ) AS running_sales

FROM monthly_sales
ORDER BY month;


-- ============================================================
-- 5. MONTH-OVER-MONTH SALES GROWTH
-- ============================================================

WITH monthly_sales AS (

    SELECT
        DATE_TRUNC('month', order_date)::DATE AS month,
        SUM(sales) AS total_sales
    FROM sales_data
    GROUP BY month

),

sales_with_previous AS (

    SELECT
        month,
        total_sales,

        LAG(total_sales) OVER (
            ORDER BY month
        ) AS previous_month_sales

    FROM monthly_sales

)

SELECT
    month,

    ROUND(total_sales, 2) AS total_sales,

    ROUND(previous_month_sales, 2)
        AS previous_month_sales,

    ROUND(
        (
            total_sales - previous_month_sales
        )
        * 100.0
        / NULLIF(previous_month_sales, 0),
        2
    ) AS mom_growth_percentage

FROM sales_with_previous
ORDER BY month;


-- ============================================================
-- 6. YEAR-OVER-YEAR SALES
-- ============================================================

WITH yearly_sales AS (

    SELECT
        EXTRACT(YEAR FROM order_date)::INTEGER AS year,
        SUM(sales) AS total_sales
    FROM sales_data
    GROUP BY year

),

sales_with_previous AS (

    SELECT
        year,
        total_sales,

        LAG(total_sales) OVER (
            ORDER BY year
        ) AS previous_year_sales

    FROM yearly_sales

)

SELECT
    year,

    ROUND(total_sales, 2) AS total_sales,

    ROUND(previous_year_sales, 2)
        AS previous_year_sales,

    ROUND(
        (
            total_sales - previous_year_sales
        )
        * 100.0
        / NULLIF(previous_year_sales, 0),
        2
    ) AS yoy_growth_percentage

FROM sales_with_previous
ORDER BY year;


-- ============================================================
-- 7. CUSTOMER RANKING
-- ============================================================

WITH customer_sales AS (

    SELECT
        customer_id,
        customer_name,
        SUM(sales) AS total_sales
    FROM sales_data
    GROUP BY
        customer_id,
        customer_name

)

SELECT
    customer_id,
    customer_name,
    ROUND(total_sales, 2) AS total_sales,

    RANK() OVER (
        ORDER BY total_sales DESC
    ) AS customer_rank

FROM customer_sales
ORDER BY customer_rank
LIMIT 10;


-- ============================================================
-- 8. TOP PRODUCTS WITHIN EACH CATEGORY
-- ============================================================

WITH product_sales AS (

    SELECT
        category,
        product_id,
        product_name,
        SUM(sales) AS total_sales
    FROM sales_data
    GROUP BY
        category,
        product_id,
        product_name

),

ranked_products AS (

    SELECT
        category,
        product_id,
        product_name,
        total_sales,

        ROW_NUMBER() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS product_rank

    FROM product_sales

)

SELECT
    category,
    product_id,
    product_name,
    ROUND(total_sales, 2) AS total_sales,
    product_rank

FROM ranked_products

WHERE product_rank <= 5

ORDER BY
    category,
    product_rank;


-- ============================================================
-- 9. CUSTOMER SALES CONTRIBUTION
-- ============================================================

WITH customer_sales AS (

    SELECT
        customer_id,
        customer_name,
        SUM(sales) AS total_sales
    FROM sales_data
    GROUP BY
        customer_id,
        customer_name

)

SELECT
    customer_id,
    customer_name,

    ROUND(total_sales, 2)
        AS total_sales,

    ROUND(
        total_sales * 100.0 /
        SUM(total_sales) OVER (),
        2
    ) AS sales_contribution_percentage

FROM customer_sales

ORDER BY total_sales DESC;


-- ============================================================
-- 10. CUSTOMER ORDER FREQUENCY
-- ============================================================

SELECT
    customer_id,
    customer_name,

    COUNT(DISTINCT order_id)
        AS total_orders,

    ROUND(SUM(sales), 2)
        AS total_sales,

    ROUND(
        SUM(sales) /
        NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value

FROM sales_data

GROUP BY
    customer_id,
    customer_name

ORDER BY total_orders DESC;


-- ============================================================
-- 11. TOP CITIES
-- ============================================================

SELECT
    city,
    state,
    region,

    COUNT(DISTINCT order_id)
        AS total_orders,

    ROUND(SUM(sales), 2)
        AS total_sales

FROM sales_data

GROUP BY
    city,
    state,
    region

ORDER BY total_sales DESC

LIMIT 20;


-- ============================================================
-- 12. SHIPPING PERFORMANCE BY REGION
-- ============================================================

SELECT
    region,

    COUNT(DISTINCT order_id)
        AS total_orders,

    ROUND(AVG(shipping_days), 2)
        AS average_shipping_days,

    MIN(shipping_days)
        AS minimum_shipping_days,

    MAX(shipping_days)
        AS maximum_shipping_days

FROM sales_data

GROUP BY region

ORDER BY average_shipping_days;


-- ============================================================
-- 13. SALES + SHIPPING BY SHIP MODE
-- ============================================================

SELECT
    ship_mode,

    COUNT(DISTINCT order_id)
        AS total_orders,

    ROUND(SUM(sales), 2)
        AS total_sales,

    ROUND(AVG(shipping_days), 2)
        AS average_shipping_days

FROM sales_data

GROUP BY ship_mode

ORDER BY total_sales DESC;


-- ============================================================
-- 14. CREATE MONTHLY SALES VIEW
-- ============================================================

DROP VIEW IF EXISTS monthly_sales_analysis;

CREATE VIEW monthly_sales_analysis AS

SELECT
    DATE_TRUNC('month', order_date)::DATE AS month,

    COUNT(DISTINCT order_id)
        AS total_orders,

    COUNT(DISTINCT customer_id)
        AS total_customers,

    ROUND(SUM(sales), 2)
        AS total_sales,

    ROUND(
        SUM(sales) /
        NULLIF(COUNT(DISTINCT order_id), 0),
        2
    ) AS average_order_value

FROM sales_data

GROUP BY month;

Then:

SELECT *
FROM monthly_sales_analysis
ORDER BY month;