
CREATE TABLE Orders (
    OrderID INT,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount NUMERIC(10, 2),
    Status VARCHAR(20)
);

INSERT INTO Orders VALUES (1, 10, '2023-05-01', 120, 'Delivered');
INSERT INTO Orders VALUES (2, 20, '2023-05-02', 75, 'Shipped');
INSERT INTO Orders VALUES (3, 10, '2023-05-03', 200, 'Pending');
INSERT INTO Orders VALUES (4, 30, '2023-05-04', 150, 'Canceled');
INSERT INTO Orders VALUES (5, 20, '2023-05-05', 500, 'Delivered');
INSERT INTO Orders VALUES (6, 30, '2023-05-01', 60, 'Pending');

SELECT * FROM Orders;

SELECT *  
FROM Orders 
WHERE TotalAmount > 100 ;

SELECT *  
FROM Orders 
WHERE Status = 'Shipped' ;


SELECT *  
FROM Orders 
WHERE OrderDate = '2023-05-01'; 

SELECT *  
FROM Orders 
WHERE TotalAmount > 200 AND Status = 'Delivered';

SELECT *  
FROM Orders 
WHERE Status = 'Pending' OR TotalAmount > 500 ;

SELECT *  
FROM Orders 
WHERE OrderDate = '2023-05-01' AND TotalAmount BETWEEN 50 AND 150 


