CREATE TABLE Sales (
    CustomerID INT,
    ProductName VARCHAR(100),
    Price DECIMAL(5,2),
    Quantity INT,
    RegularPrice DECIMAL(5,2),
    Discount DECIMAL(5,2)
);

INSERT INTO Sales (CustomerID, ProductName, Price, Quantity, RegularPrice, Discount) VALUES
(743663, 'Glazed Donut', 2.50, 2, 3.00, 0.50),
(743663, 'Chocolate Muffin', 3.00, 1, 3.00, 0.00),
(223424, 'Blueberry Muffin', 3.00, 2, 3.00, 0.00),
(323423, 'Chocolate Chip Cookie', 1.50, 3, 2.00, 0.50),
(432424, 'Sugar Cookie', 1.00, 4, 1.00, 0.00);

SELECT * FROM  Sales;

SELECT 
    ProductName, 
    SUM(Quantity) AS TotalSold  
FROM 
    Sales
GROUP BY 
    ProductName;

SELECT CustomerID, COUNT(*) AS PurchaseCount  
FROM Sales  
GROUP BY CustomerID;

SELECT  
  CASE  
    WHEN ProductName LIKE '%Donut%' THEN 'Donuts'  
    WHEN ProductName LIKE '%Muffin%' THEN 'Muffins'  
    ELSE 'Cookies'  
  END AS Category,  
  SUM(Price * Quantity) AS TotalRevenue  
FROM Sales  
GROUP BY  
  CASE  
    WHEN ProductName LIKE '%Donut%' THEN 'Donuts'  
    WHEN ProductName LIKE '%Muffin%' THEN 'Muffins'  
    ELSE 'Cookies'  
  END;

SELECT ProductName, Quantity, 
  CASE  
    WHEN Quantity >= (SELECT AVG(Quantity) FROM Sales) THEN 'Popular' 
    ELSE 'Less Popular' 
  END AS Popularity, 
  CASE WHEN RegularPrice > Price THEN 'Discounted' ELSE 'Regular Price' END AS Price_Status 
FROM Sales 
  
  