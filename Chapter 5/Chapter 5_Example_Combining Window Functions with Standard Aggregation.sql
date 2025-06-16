
CREATE TABLE Sales (
    Sale_ID INT PRIMARY KEY,
    Customer_ID INT,
    Product_ID VARCHAR(10),
    Sale_Amount DECIMAL(10, 2),
    Sale_Date DATE,
    Region VARCHAR(50)
);


INSERT INTO Sales (Sale_ID, Customer_ID, Product_ID, Sale_Amount, Sale_Date, Region) VALUES
(1, 101, 'P001', 500.00, '2024-01-05', 'North'),
(2, 102, 'P002', 300.00, '2024-01-08', 'South'),
(3, 101, 'P003', 200.00, '2024-01-12', 'North'),
(4, 103, 'P001', 900.00, '2024-01-15', 'East'),
(5, 104, 'P002', 600.00, '2024-01-18', 'West'),
(6, 102, 'P003', 150.00, '2024-01-22', 'South'),
(7, 101, 'P002', 700.00, '2024-01-25', 'North'),
(8, 105, 'P003', 250.00, '2024-01-30', 'West'),
(9, 103, 'P001', 400.00, '2024-02-01', 'East'),
(10, 104, 'P003', 1000.00, '2024-02-05', 'West');

SELECT * FROM Sales;

SELECT  Customer_ID,  
    COUNT(*) OVER (PARTITION BY Customer_ID) AS Total_Sales,  
    SUM(Sale_Amount) OVER (PARTITION BY Customer_ID) AS Total_Purchases,  
    ROW_NUMBER() OVER (PARTITION BY Customer_ID ORDER BY Sale_Date) AS Sale_Rank 
FROM Sales; 


WITH CustomerTotals AS ( 
    SELECT Customer_ID, Region, SUM(Sale_Amount) AS Total_Purchase 
    FROM Sales 
    GROUP BY Customer_ID, Region 
) 
SELECT  
    Customer_ID,  
    Region,  
    Total_Purchase,  
    RANK() OVER (PARTITION BY Region ORDER BY Total_Purchase DESC) AS Region_Rank 
FROM CustomerTotals 
WHERE Customer_ID IN (
    SELECT Customer_ID
    FROM (
        SELECT  
            Customer_ID,  
            Region,  
            Total_Purchase,  
            RANK() OVER (PARTITION BY Region ORDER BY Total_Purchase DESC) AS Region_Rank 
        FROM CustomerTotals
    ) AS RankedCustomers
    WHERE Region_Rank <= 3
);


SELECT  
    Customer_ID,  
    COUNT(*) OVER (PARTITION BY Customer_ID) AS Total_Sales,  
    SUM(Sale_Amount) OVER (PARTITION BY Customer_ID) AS Total_Purchases,  
    ROW_NUMBER() OVER (PARTITION BY Customer_ID ORDER BY Sale_Date) AS Sale_Rank 
FROM Sales; 

WITH CustomerPurchases AS ( 
    SELECT Customer_ID, SUM(Sale_Amount) AS Total_Purchase 
    FROM Sales 
    GROUP BY Customer_ID 
),  
CustomerSegments AS ( 
    SELECT Customer_ID, Total_Purchase, 
           CASE  
               WHEN Total_Purchase >= 1000 THEN 'High Spender' 
               WHEN Total_Purchase BETWEEN 500 AND 999 THEN 'Medium Spender' 
               ELSE 'Low Spender' 
           END AS Segment 
    FROM CustomerPurchases 
) 
SELECT * FROM CustomerSegments; 


WITH RankedCustomers AS ( 
    SELECT Customer_ID, SUM(Sale_Amount) AS Total_Purchase, 
           ROW_NUMBER() OVER (ORDER BY SUM(Sale_Amount) DESC) AS Purchase_Rank 
    FROM Sales 
    GROUP BY Customer_ID 
) 
SELECT * FROM RankedCustomers 
WHERE Purchase_Rank < 3; 



