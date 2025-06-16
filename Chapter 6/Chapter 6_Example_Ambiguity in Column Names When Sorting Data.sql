CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(50)
);

INSERT INTO customers (customer_id, name) VALUES
(1, 'Alice'),
(2, 'Bob'),
(3, 'Charlie'),
(4, 'Diana'),
(5, 'Eve');

CREATE TABLE orders  (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

INSERT INTO orders  (order_id, customer_id, order_date) VALUES
(1, 1, '2023-06-15'),
(2, 1, '2023-07-20'),
(3, 2, '2023-05-10'),
(4, 3, '2023-08-01'),
(5, 3, '2023-07-22'),
(6, 4, '2023-04-18'),
(7, 5, '2023-05-25');

SELECT * FROM Customers;

SELECT * FROM Orders;


SELECT customers.customer_id, orders.order_date 
FROM customers 
JOIN orders ON customers.customer_id = orders.customer_id 
ORDER BY orders.order_date DESC; 


