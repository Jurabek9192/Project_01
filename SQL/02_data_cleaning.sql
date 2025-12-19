-- find nulls
SELECT COUNT(*) FILTER (WHERE transaction_id IS NULL)   AS null_transaction_id,
       COUNT(*) FILTER (WHERE order_date IS NULL)       AS null_order_date,
       COUNT(*) FILTER (WHERE customer_id IS NULL)      AS null_customer_id,
       COUNT(*) FILTER (WHERE product_category IS NULL) AS null_product_category
FROM retail_sales;


-- finding problems
SELECT COUNT(*) FILTER (WHERE quantity <= 0)       AS invalid_quantity,
       COUNT(*) FILTER (WHERE price_per_unit <= 0) AS invalid_price,
       COUNT(*) FILTER (WHERE total_amount <= 0)   AS invalid_total
FROM retail_sales;

-- Finding duplicates
SELECT transaction_id,
       count(*) AS cnt
FROM retail_sales
GROUP BY transaction_id
HAVING count(*) > 1;


-- creating clean table
CREATE TABLE clean_retail_sales AS
SELECT *
FROM retail_sales
WHERE quantity > 0
  AND price_per_unit > 0
  AND total_amount > 0
  AND customer_id IS NOT NULL;

SELECT count(*)
FROM clean_retail_sales;

SELECT *
FROM clean_retail_sales
LIMIT 10;