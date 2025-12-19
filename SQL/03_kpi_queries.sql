-- 1. Total Sales
SELECT
    SUM(total_amount) AS total_sales
FROM clean_retail_sales;

-- 2. Total orders
SELECT
    COUNT(transaction_id) AS total_orders
FROM clean_retail_sales;

-- 3. Avg Order Value (AOV)
SELECT
    SUM(total_amount)/COUNT(transaction_id) AS avg_order_value
FROM clean_retail_sales;

-- 4. Top Products by Revenue

SELECT
    product_category,
    SUM(total_amount) AS total_revenue
FROM clean_retail_sales
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 10;

-- 5. Monthly Sales & MoM Growth
WITH monthly_sales AS (
    SELECT
        DATE_TRUNC('month', order_date ) AS month,
        SUM(total_amount) AS total_revenue
    FROM clean_retail_sales
    GROUP BY month
    ORDER BY month
)
SELECT
    month,
    total_revenue,
    LAG(total_revenue) OVER (ORDER BY month) AS prev_month,
    ROUND((total_revenue-LAG(total_revenue) OVER (ORDER BY month))*100.0/LAG(total_revenue) OVER (ORDER BY month ), 2) AS mom_growth_pct
FROM monthly_sales;

