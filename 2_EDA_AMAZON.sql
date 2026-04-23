CREATE TABLE amazon_sales (
    OrderID VARCHAR(20),
    OrderDate DATE,
    CustomerID VARCHAR(20),
    CustomerName VARCHAR(100),
    ProductID VARCHAR(20),
    ProductName VARCHAR(100),
    Category VARCHAR(50),
    Brand VARCHAR(50),
    Quantity INT,
    UnitPrice DECIMAL(10,2),
    Discount DECIMAL(5,2),
    Tax DECIMAL(10,2),
    ShippingCost DECIMAL(10,2),
    TotalAmount DECIMAL(10,2),
    PaymentMethod VARCHAR(50),
    OrderStatus VARCHAR(50),
    City VARCHAR(50),
    State VARCHAR(10),
    Country VARCHAR(50),
    SellerID VARCHAR(20)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/2_Amazon.csv'
INTO TABLE amazon_sales
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

SELECT * FROM amazon_sales
LIMIT 1000;


   -- EDA
   
-- TOTAL_ORDER , UNIQUE_CUSTOMERS AND UNIQUE_PRODUCTS

SELECT 
    COUNT(*) AS total_orders,
    COUNT(DISTINCT CustomerID) AS unique_customers,
    COUNT(DISTINCT ProductID) AS unique_products
FROM amazon_sales;

-- TOTAL_REVENUE AVERGAE ORDER VALUE AND MAXIMUM ORDER VALUE

SELECT SUM(TotalAmount) AS TOTAL_REVENUE, ROUND(AVG(TotalAmount),2) as AVG_ORDER_VALUE , MAX(TotalAmount) AS MAXIMUM_ORDER_VALUE
FROM amazon_sales;


-- CHECKING FOR NULL VALUES

SELECT 
    SUM(CASE WHEN OrderID IS NULL THEN 1 ELSE 0 END) AS OrderID_nulls,
    SUM(CASE WHEN OrderDate IS NULL THEN 1 ELSE 0 END) AS OrderDate_nulls,
    SUM(CASE WHEN CustomerID IS NULL THEN 1 ELSE 0 END) AS CustomerID_nulls,
    SUM(CASE WHEN CustomerName IS NULL THEN 1 ELSE 0 END) AS CustomerName_nulls,
    SUM(CASE WHEN ProductID IS NULL THEN 1 ELSE 0 END) AS ProductID_nulls,
    SUM(CASE WHEN ProductName IS NULL THEN 1 ELSE 0 END) AS ProductName_nulls,
    SUM(CASE WHEN Category IS NULL THEN 1 ELSE 0 END) AS Category_nulls,
    SUM(CASE WHEN Brand IS NULL THEN 1 ELSE 0 END) AS Brand_nulls,
    SUM(CASE WHEN Quantity IS NULL THEN 1 ELSE 0 END) AS Quantity_nulls,
    SUM(CASE WHEN UnitPrice IS NULL THEN 1 ELSE 0 END) AS UnitPrice_nulls,
    SUM(CASE WHEN Discount IS NULL THEN 1 ELSE 0 END) AS Discount_nulls,
    SUM(CASE WHEN Tax IS NULL THEN 1 ELSE 0 END) AS Tax_nulls,
    SUM(CASE WHEN ShippingCost IS NULL THEN 1 ELSE 0 END) AS ShippingCost_nulls,
    SUM(CASE WHEN TotalAmount IS NULL THEN 1 ELSE 0 END) AS TotalAmount_nulls,
    SUM(CASE WHEN PaymentMethod IS NULL THEN 1 ELSE 0 END) AS PaymentMethod_nulls,
    SUM(CASE WHEN OrderStatus IS NULL THEN 1 ELSE 0 END) AS OrderStatus_nulls,
    SUM(CASE WHEN City IS NULL THEN 1 ELSE 0 END) AS City_nulls,
    SUM(CASE WHEN State IS NULL THEN 1 ELSE 0 END) AS State_nulls,
    SUM(CASE WHEN Country IS NULL THEN 1 ELSE 0 END) AS Country_nulls,
    SUM(CASE WHEN SellerID IS NULL THEN 1 ELSE 0 END) AS SellerID_nulls
FROM amazon_sales;


-- TOP 5 CATEGORY WITH THE MOST REVENUE
SELECT Category , SUM(TotalAmount) AS REVENUE FROM amazon_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5;

-- BRAND WITH THE HIGHEST NO OF ORDERS AND TOTAL SALES
SELECT * FROM amazon_sales LIMIT 1000;

SELECT DISTINCT Brand , COUNT(Quantity) AS NO_OF_ORDERS, SUM(TotalAmount) as TOTAL_SALES  FROM amazon_sales 
GROUP BY 1
order by 2  DESC;

-- AVERAGE DISCOUNT GIVEN PER CATEGORY
SELECT Category , ROUND(AVG(Discount),2) as AVG_DISCOUNT 
FROM amazon_sales
GROUP BY Category
ORDER BY AVG_DISCOUNT DESC; -- THE DISCOUNT IS IN PERCENT

-- MONTH AND YEAR WITH HIGHEST TOTAL SALES
SELECT year , month , total_sales
FROM 
(
	SELECT
    EXTRACT(YEAR FROM OrderDate) as year,
    EXTRACT(MONTH FROM OrderDate) as month,
    SUM(TotalAmount) as Total_sales
    FROM amazon_sales
    GROUP BY 1,2
) AS T1
ORDER BY 1, 3;

-- TOP 10 CUSTOMERS BY AMOUNT SPENT
SELECT 
    CustomerID, 
    CustomerName, 
    Category,
    SUM(TotalAmount) AS Amount_Spent
FROM amazon_sales
GROUP BY 1,2,3
ORDER BY Amount_Spent DESC
LIMIT 10;

-- MOST USED PAYMENT METHOD AND WHICH GENERATES THE MOST REVENUE
select * FROM amazon_sales LIMIT 1000;

SELECT PaymentMethod , SUM(TotalAmount) as REVENUE
FROM amazon_sales
GROUP BY 1
ORDER BY REVENUE DESC;