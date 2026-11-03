-- Capstone Project 1
-- Israel Colman

-- Sales Territory State:
-- MA


-- What is total revenue overall for sales in the assigned territory, plus the start date and end date
-- that tell you what period the data covers?

USE sample_sales;


SELECT 
FORMAT(SUM(ss.Sale_Amount), 2) AS Total_Sales,
MIN(ss.Transaction_Date) AS Start_Date,
MAX(ss.Transaction_Date) AS End_Date
FROM store_sales ss
INNER JOIN store_locations sl
ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'Massachusetts';

-- What is the revenue breakdown by year and month for the sales territory?

SELECT YEAR(ss.Transaction_Date) AS Year,
MONTH (ss.Transaction_Date) AS Month,
FORMAT(SUM(ss.Sale_Amount), 2) AS Total_Sales
FROM store_sales ss
INNER JOIN store_locations sl
ON ss.Store_ID = sl.StoreId
WHERE sl.State = 'Massachusetts'
GROUP BY Year, Month;



-- Provide a comparison of total revenue for the specific sales territory and the region it belongs to.
-- (region is Maryland, Massachusetts, Maine, and New Jersey)


SELECT 
'Region' AS Sales_Type,
FORMAT(SUM(Sale_Amount), 2) AS Total_Sales
FROM store_sales ss
INNER JOIN store_locations sl
ON sl.StoreId = Store_ID
WHERE sl.State IN ('Massachusetts', 'Maryland', 'Maine', 'New Jersey')

UNION ALL

SELECT 
'Territory' AS Sales_Type,
FORMAT(SUM(Sale_Amount), 2) AS Total_Sales
FROM store_sales ss
INNER JOIN store_locations sl
ON sl.StoreId = Store_ID
WHERE sl.State = 'Massachusetts';


-- What is the number of transactions per month and average transaction amount by product
-- category for the sales territory?

SELECT MONTH(Transaction_Date) AS MONTH,
YEAR(Transaction_Date) AS YEAR,
COUNT(id) AS Transactions
FROM store_sales
WHERE (Store_ID BETWEEN 801 AND 817) OR Store_ID = 730
GROUP BY MONTH, YEAR;

SELECT p.Categoryid, ic.Category, ROUND(AVG(ss.Sale_Amount), 2) AS Avg_Transaction_Amount
FROM store_sales ss
INNER JOIN products p
ON p.ProdNum = ss.Prod_Num
INNER JOIN inventory_categories ic
ON ic.Categoryid = p.Categoryid
WHERE (ss.Store_ID BETWEEN 801 AND 817) OR ss.Store_ID = 730
GROUP BY p.Categoryid, ic.Category
ORDER BY Avg_Transaction_Amount DESC;


-- Can you provide a ranking of in-store sales performance by each store in the sales territory, or a
-- ranking of online sales performance by state within an online sales territory?

SELECT sl.StoreLocation,
FORMAT(SUM(Sale_Amount), 2) AS Total_Revenue,
MIN(Transaction_Date) AS Start_Date,
MAX(Transaction_Date) AS End_Date
FROM store_sales ss
INNER JOIN store_locations sl
ON sl.StoreId = ss.Store_ID
WHERE (Store_ID BETWEEN 801 AND 817) OR Store_ID = (730)
GROUP BY sl.StoreLocation
ORDER BY SUM(Sale_Amount) DESC;

-- What is your recommendation for where to focus sales attention in the next quarter?
--
-- My recommendation is to find out why the Worcester store is performing so good. Set up a meeting with that store and gain insight
-- as to why that store is performing so well. I would then 
