
CREATE TABLE Car_Sales (
    Sale_ID INT PRIMARY KEY,
    Model_Name VARCHAR(100) NOT NULL,
    Region VARCHAR(50) NOT NULL,
    Sale_Date DATE NOT NULL,
    Sales_Amount DECIMAL(10,2) NOT NULL
);


INSERT INTO Car_Sales (Sale_ID, Model_Name, Region, Sale_Date, Sales_Amount) VALUES
(1, 'Speedster', 'North', '2024-01-01', 25000.00),
(2, 'Cruiser', 'South', '2024-01-03', 20000.00),
(3, 'Speedster', 'North', '2024-01-05', 27000.00),
(4, 'Zoomer', 'East', '2024-01-07', 30000.00),
(5, 'Speedster', 'West', '2024-01-10', 28000.00),
(6, 'Cruiser', 'South', '2024-01-12', 22000.00),
(7, 'Zoomer', 'North', '2024-01-15', 26000.00),
(8, 'Speedster', 'South', '2024-01-17', 29000.00);

SELECT * FROM  Car_Sales;

SELECT Sale_ID, Region, Model_Name,  
       ROW_NUMBER() OVER (PARTITION BY Region ORDER BY Sale_Date) AS Sale_Rank 
FROM Car_Sales; 

SELECT Model_Name, Region,  
       RANK() OVER (PARTITION BY Region ORDER BY SUM(Sales_Amount) DESC) AS Sales_Rank 
FROM Car_Sales 
GROUP BY Model_Name, Region; 

SELECT Model_Name, Region,  
       DENSE_RANK() OVER (PARTITION BY Region ORDER BY SUM(Sales_Amount) DESC) AS Dense_Rank 
FROM Car_Sales 
GROUP BY Model_Name, Region; 

SELECT Sale_ID, Model_Name, Sale_Date,  
       SUM(Sales_Amount) OVER (PARTITION BY Model_Name ORDER BY Sale_Date) AS Cumulative_Sales 
FROM Car_Sales; 

SELECT Sale_ID, Model_Name, Sale_Date,  
       AVG(Sales_Amount) OVER (PARTITION BY Model_Name ORDER BY Sale_Date ROWS BETWEEN 2 PRECEDING AND CURRENT ROW) AS Moving_Avg 
FROM Car_Sales; 


SELECT 
    Model_Name, 
    Region, 
    Total_Sales, 
    SUM(Total_Sales) OVER (PARTITION BY Region) AS Total_Sales_Region,  
    RANK() OVER (PARTITION BY Region ORDER BY Total_Sales DESC) AS Sales_Rank
FROM (
    SELECT 
        Model_Name, 
        Region, 
        SUM(Sales_Amount) AS Total_Sales
    FROM 
        Car_Sales
    GROUP BY 
        Model_Name, Region
) AS AggregatedSales;
