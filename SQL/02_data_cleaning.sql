-- At this stage, the data is checked for null values, as missing data may distort the results.
-- The dataset is validated for null values to ensure accurate analysis results.
-- На этом этапе данные проверяются на наличие пропущенных значений,
-- так как они могут повлиять на результаты анализа.

SELECT COUNT(*) FILTER (WHERE transaction_id IS NULL)   AS null_transaction_id,
       COUNT(*) FILTER (WHERE order_date IS NULL)       AS null_order_date,
       COUNT(*) FILTER (WHERE customer_id IS NULL)      AS null_customer_id,
       COUNT(*) FILTER (WHERE product_category IS NULL) AS null_product_category
FROM retail_sales;


-- Now data should be checked for wrong values they also affect to the results
-- Некоторый данные не могут быть меньше нуля, так как такие значения считаеются некорректными

SELECT COUNT(*) FILTER (WHERE quantity <= 0)       AS invalid_quantity,
       COUNT(*) FILTER (WHERE price_per_unit <= 0) AS invalid_price,
       COUNT(*) FILTER (WHERE total_amount <= 0)   AS invalid_total
FROM retail_sales;

-- At this stage, duplicate records can be identified in the data.
-- На этом этапе в данных могут быть выявлены дубликаты.

SELECT transaction_id,
       count(*) AS cnt
FROM retail_sales
GROUP BY transaction_id
HAVING count(*) > 1;


-- Creating clean data
-- Создания готовый данные

CREATE TABLE clean_retail_sales AS
SELECT *
FROM retail_sales
WHERE quantity > 0
  AND price_per_unit > 0
  AND total_amount > 0
  AND customer_id IS NOT NULL;

-- Checking rows
-- Проверка строки

SELECT count(*)
FROM clean_retail_sales;

-- Last checking
-- Последная проверка

SELECT *
FROM clean_retail_sales
LIMIT 10;
