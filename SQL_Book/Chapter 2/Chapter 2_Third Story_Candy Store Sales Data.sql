CREATE TABLE sales_log (
    OrderID INTEGER,
    Candy  VARCHAR(255),   
    Quantity INTEGER  
);


INSERT INTO sales_log (OrderID, Candy, Quantity)
VALUES
    (1, 'Gummy Bears', 2),
    (2, 'Lollipops', 1),
    (3, 'Gummy Bears', 3),
    (4, 'Chocolate Bars', 2),
    (5, 'Lollipops', 2), 
    (6, 'Gummy Bears', 1);
    
SELECT * FROM  sales_log;

SELECT DISTINCT Candy 
FROM sales_log;


CREATE TABLE orders (
    OrderID VARCHAR(255),
    CustomerID VARCHAR(255),
    Amount DECIMAL(10,2) 
);

INSERT INTO orders (OrderID, CustomerID, Amount)
VALUES
   ('1', '101', 100.00),
   ('2', '102', 50.00),
   ('3', '103', 75.00),
   ('4', '101', 275.00);
   
SELECT OrderID, CustomerID, Amount , Amount * 0.1 AS Discount 
FROM Orders;

SELECT 
  CustomerID, 
  COUNT(*) AS TotalOrders, 
  SUM(Amount) AS TotalSales 
FROM Orders 
GROUP BY CustomerID;

