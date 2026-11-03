-- Capstone Project 1
-- Israel Colman

-- Sales Territory State:
-- MA


-- What is total revenue overall for sales in the assigned territory, plus the start date and end date
-- that tell you what period the data covers?

USE sample_sales;


SELECT sl.StoreId, sl.StoreLocation,
SUM(ss.Sale_Amount) AS Total_Sales,
MIN(ss.Transaction_Date) AS Start_Date,
MAX(ss.Transaction_Date) AS End_Date
FROM store_sales ss
INNER JOIN store_locations sl
ON ss.Store_ID = sl.StoreId
GROUP BY sl.StoreId
HAVING sl.StoreId Between 801 AND 817;

