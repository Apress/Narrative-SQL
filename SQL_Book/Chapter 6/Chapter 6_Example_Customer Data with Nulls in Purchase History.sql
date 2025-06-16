CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    last_purchase_date DATE
);

INSERT INTO customers (customer_id, customer_name, last_purchase_date) VALUES
(1, 'Alice', '2023-06-15'),
(2, 'Bob', NULL),
(3, 'Charlie', '2023-07-20'),
(4, 'Diana', NULL),
(5, 'Eve', '2023-05-10');

SELECT * FROM  customers;


SELECT * FROM customers 
ORDER BY last_purchase_date  
DESC NULLS FIRST; 

SELECT * FROM customers 
ORDER BY last_purchase_date 
DESC NULLS LAST; 


