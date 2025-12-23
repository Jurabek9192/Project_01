
-- Here I created table to load dataset from csv file
-- Здесь я создал таблицу, чтобы загрузить данные из csv-фацла

CREATE TABLE retail_sales (
    transaction_id     VARCHAR(50),
    order_date         DATE,
    customer_id        VARCHAR(50),
    gender             VARCHAR(10),
    age                INT,
    product_category   VARCHAR(100),
    quantity           INT,
    price_per_unit     NUMERIC(10,2),
    total_amount       NUMERIC(12,2)
);

-- After importing data I check
-- После загрузки проверил

SELECT * FROM retail_sales;

-- Checking how many rows are imported
-- Проверка количества полученных строк

SELECT COUNT(*) FROM retail_sales;
