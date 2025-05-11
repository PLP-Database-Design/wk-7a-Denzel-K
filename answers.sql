-- Question 1: Transforming ProductDetail table to 1NF
-- Create a new table with each product in a separate row
CREATE TABLE ProductDetail_1NF AS
SELECT 
    OrderID,
    CustomerName,
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.digit+1), ',', -1)) AS Product
FROM 
    ProductDetail
JOIN 
    (SELECT 0 AS digit UNION ALL SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3) n
    ON LENGTH(REPLACE(Products, ',', '')) <= LENGTH(Products)-n.digit
WHERE
    TRIM(SUBSTRING_INDEX(SUBSTRING_INDEX(Products, ',', n.digit+1), ',', -1)) != '';

-- Question 2: Transforming OrderDetails table to 2NF
-- Step 1: Create Orders table (removes partial dependency)
CREATE TABLE Orders_2NF AS
SELECT DISTINCT
    OrderID,
    CustomerName
FROM 
    OrderDetails;

-- Step 2: Create OrderItems table (contains only full dependencies)
CREATE TABLE OrderItems_2NF AS
SELECT
    OrderID,
    Product,
    Quantity
FROM
    OrderDetails;
