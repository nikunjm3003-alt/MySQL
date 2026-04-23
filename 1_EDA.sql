-- SQL RETAIL SALE ANALYSIS
CREATE DATABASE RETAIL;


SELECT * FROM retail_sales;

ALTER TABLE retail_sales
MODIFY COLUMN sale_date DATE;

ALTER TABLE retail_sales
MODIFY COLUMN sale_time TIME;

-- CREATING A COPY OF THE TABLE FOR PERFORMIN THE TASK
CREATE TABLE retail_sales_2 
LIKE retail_sales;

INSERT INTO retail_sales_2 
SELECT * FROM retail_sales;

-- VERIFYING IT
SELECT * FROM retail_sales_2
LIMIT 10;

SELECT COUNT(*) FROM retail_sales_2; -- checking the number of rows

DESCRIBE retail_sales_2;

ALTER TABLE retail_sales_2
RENAME COLUMN ï»¿transactions_id TO transactions_id;

ALTER TABLE retail_sales_2
RENAME COLUMN quantiy TO quantity;


-- checking duplicate values
SELECT *, COUNT(*) as duplicate_count
FROM retail_sales_2
GROUP BY transactions_id, sale_date, sale_time, customer_id, gender, age, category, quantiy, price_per_unit, cogs, total_sale
HAVING COUNT(*) > 1;


-- DATA CLEANING
SELECT * FROM retail_sales_2
WHERE
	transactions_id IS NULL
	OR
	sale_date IS NULL
	OR
	sale_time IS NULL
	OR
	customer_id IS NULL
	OR
	gender IS NULL
	OR
	category IS NULL
	OR
	quantity IS NULL
	OR
	cogs IS NULL
	OR 
	total_sale IS NULL;
    
-- no null values [no need for deletion]

-- DATA EXPLORATION

-- total_number of sales
SELECT COUNT(*) AS TOTAL_SALES FROM retail_sales_2;

-- TOTAL REVENUE
SELECT SUM(total_sale) as TOTAL_REVENUE FROM retail_sales_2; -- 908230

-- AVERAGE ORDER values
SELECT ROUND(AVG(total_sale),2) AS AVG_ORDER_VALUE FROM retail_sales_2;  -- 457.09

-- TOTAL UNIQUE CUSTOMER 
SELECT COUNT(DISTINCT customer_id) AS unique_customers FROM retail_sales_2; -- 155

-- TOTAL COUNT OF REPEAT CUSTOMERS
SELECT COUNT(*) AS repeat_customers
FROM (
    SELECT customer_id
    FROM retail_sales_2
    GROUP BY customer_id
    HAVING COUNT(*) > 1
) AS r;




-- SALES BY GENDER 
SELECT gender , SUM(total_sale) AS TOTAL_SALES,
COUNT(*) AS NO_OF_ORDERS,
ROUND(AVG(total_sale),2) AS AVG_ORDER_VALUE
FROM retail_sales_2
GROUP BY gender
ORDER BY 2 DESC;

-- SALES MADE ON '2022-11-05'
SELECT COUNT(sale_date) FROM retail_sales_2
WHERE sale_date = '2022-11-05'; -- 11 

SELECT * FROM retail_sales_2
WHERE sale_date = '2022-11-05'
ORDER BY sale_time ASC;

-- SALES MADE ON 2022-11 WHERE THE CATEGORY IS CLOTHING AND QUANTITY IS GREATER AND EQUALS TO 4
SELECT * FROM retail_sales_2
WHERE 
	category = 'Clothing'
    AND
    quantity >= 4
    AND 
    sale_date LIKE '2022-11%'
ORDER BY age DESC;

-- TOTAL SALES FOR EACH CATEGORY
SELECT category,
 SUM(total_sale) AS TOTAL_SALES , 
 COUNT(*) AS TOTAL_ORDERS,
 SUM(quantity) AS TOTAL_ITEMS_ORDERED,
 ROUND(AVG(total_sale),2) as AVG_ORDER_VALUE
FROM retail_sales_2
GROUP BY category
ORDER BY 2 DESC;

-- AVERAGE AGE OF CUSTOMER WHO BOUGHT BEAUTY PRODUCTS
SELECT ROUND(AVG(AGE),2) AS AVG_AGE FROM retail_sales_2
WHERE category = 'Beauty';


-- transactions where total_sale is greater than 1000

SELECT transactions_id,total_sale FROM retail_sales_2
WHERE total_sale > 1000
ORDER BY total_sale DESC;

-- transaction made by each gender in each category
SELECT gender , category , SUM(total_sale) as TOTAL_SALES, COUNT(*) AS TOTAL_ORDERS
FROM retail_sales_2
GROUP BY gender,category
ORDER BY gender;

-- AVERAGE SALE IN ALL THE MONTHS
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    EXTRACT(YEAR FROM sale_date) as year,
    EXTRACT(MONTH FROM sale_date) as month,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) as `rank`
FROM retail_sales
GROUP BY 1, 2
) as t1
ORDER BY year,month; 

-- TOP 5 CUSTOMERS with the most purchase 
SELECT customer_id, SUM(total_sale) as total_sales FROM retail_sales_2
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- FINDING UNIQUE CUSTOMER WHO PURCHASED ITEM FROM EACH CATEGORY
SELECT COUNT(DISTINCT customer_id) AS UNIQUE_CUSTOMERS , category FROM retail_sales_2
GROUP BY category;



