-- Total Sales
-- Обьщий объём продажа
SELECT
    SUM(total_amount) AS total_sales
FROM clean_retail_sales;

-- Total orders
-- Количества заказов

SELECT
    COUNT(transaction_id) AS total_orders
FROM clean_retail_sales;

-- Average Order Value (AOV)
-- Средный чек по заказу

SELECT
    SUM(total_amount)/COUNT(transaction_id) AS avg_order_value
FROM clean_retail_sales;

-- Top Products by Revenue
-- Топ продукти по выручке

SELECT
    product_category,
    SUM(total_amount) AS total_revenue
FROM clean_retail_sales
GROUP BY product_category
ORDER BY total_revenue DESC
LIMIT 10;

-- Monthly Sales & MoM Growth
-- Месячные продажи и рост по сравнению с предыдущим месяцем

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

