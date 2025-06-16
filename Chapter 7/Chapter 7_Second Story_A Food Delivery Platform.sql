
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    restaurant_id INT,
    total_amount DECIMAL(10, 2),
    order_date DATE
);

CREATE TABLE restaurants (
    restaurant_id INT PRIMARY KEY,
    name VARCHAR(100),
    city VARCHAR(100)
);

INSERT INTO customers (customer_id, name, city) VALUES
(1, 'Alice Johnson', 'New York'),
(2, 'Bob Smith', 'Chicago'),
(3, 'Charlie Davis', 'Boston'),
(4, 'David Brown', 'New York'),
(5, 'Eva White', 'Chicago'),
(6, 'Frank Green', 'Boston'),
(7, 'Grace Black', 'New York'),
(8, 'Hannah Blue', 'Chicago'),
(9, 'Ivy Red', 'New York'),
(10, 'Jack Gray', 'Chicago'),
(11, 'Liam Yellow', 'Boston'),
(12, 'Mia Purple', 'New York'),
(13, 'Noah Orange', 'Chicago'),
(14, 'Olivia Pink', 'Boston'),
(15, 'Paul Silver', 'New York'),
(16, 'Quinn Gold', 'Chicago');

INSERT INTO orders (order_id, customer_id, restaurant_id, total_amount, order_date) VALUES
(1001, 1, 101, 50.00, '2025-01-01'),
(1002, 1, 102, 20.00, '2025-01-02'),
(1003, 2, 101, 45.00, '2025-01-03'),
(1004, 3, 103, 35.00, '2025-01-04'),
(1005, 3, 102, 55.00, '2025-01-05'),
(1006, 4, 101, 70.00, '2025-01-06'),
(1007, 5, 102, 30.00, '2025-01-07'),
(1008, 5, 101, 60.00, '2025-01-08'),
(1009, 5, 102, 40.00, '2025-01-09'),
(1010, 6, 103, 25.00, '2025-01-10'),
(1011, 6, 102, 45.00, '2025-01-11'),
(1012, 7, 101, 90.00, '2025-01-12'),
(1013, 7, 102, 50.00, '2025-01-13'),
(1014, 8, 101, 80.00, '2025-01-14'),
(1015, 8, 102, 20.00, '2025-01-15'),
(1016, 9, 101, 100.00, '2025-01-16'),
(1017, 9, 102, 60.00, '2025-01-17'),
(1018, 10, 101, 90.00, '2025-01-18'),
(1019, 10, 102, 70.00, '2025-01-19'),
(1020, 11, 103, 55.00, '2025-01-20'),
(1021, 11, 102, 45.00, '2025-01-21'),
(1022, 11, 101, 120.00, '2025-01-22'),
(1023, 11, 102, 80.00, '2025-01-23');

INSERT INTO restaurants (restaurant_id, name, city) VALUES
(101, 'Pizza Palace', 'New York'),
(102, 'Sushi Spot', 'Chicago'),
(103, 'Burger Barn', 'Boston');

SELECT * FROM customers;

SELECT * FROM orders;

SELECT * FROM restaurants;

--Calculate the Average Total Amount Spent by Customers in Each City

SELECT 
    c.city,
    AVG(o.total_amount) AS avg_city_spending
FROM 
    customers c
JOIN 
    orders o
ON 
    c.customer_id = o.customer_id
GROUP BY 
    c.city;

-- Identify Customers Who Have Spent More Than the Average in Their City

SELECT 
    c.customer_id,
    c.name,
    c.city,
    SUM(o.total_amount) AS total_spent
FROM 
    customers c
JOIN 
    orders o
ON 
    c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.name, c.city
HAVING 
    SUM(o.total_amount) > (
        SELECT 
            AVG(o2.total_amount)
        FROM 
            customers c2
        JOIN 
            orders o2
        ON 
            c2.customer_id = o2.customer_id
        WHERE 
            c2.city = c.city
        GROUP BY 
            c2.city
    );


--Filter Customers Who Have Placed More Than Two Orders

SELECT 
    c.customer_id,
    c.name,
    c.city,
    SUM(o.total_amount) AS total_spent,
    COUNT(o.order_id) AS order_count
FROM 
    customers c
JOIN 
    orders o
ON 
    c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.name, c.city
HAVING 
    COUNT(o.order_id) > 2
    AND SUM(o.total_amount) > (
        SELECT 
            AVG(o2.total_amount)
        FROM 
            customers c2
        JOIN 
            orders o2
        ON 
            c2.customer_id = o2.customer_id
        WHERE 
            c2.city = c.city
        GROUP BY 
            c2.city
    );

-- final 

SELECT 
    c.customer_id,
    c.name,
    c.city,
    SUM(o.total_amount) AS total_spent,
    COUNT(o.order_id) AS order_count
FROM 
    customers c
JOIN 
    orders o
ON 
    c.customer_id = o.customer_id
GROUP BY 
    c.customer_id, c.name, c.city
HAVING 
    COUNT(o.order_id) > 2
    AND SUM(o.total_amount) > (
        SELECT 
            AVG(o2.total_amount)
        FROM 
            customers c2
        JOIN 
            orders o2
        ON 
            c2.customer_id = o2.customer_id
        WHERE 
            c2.city = c.city
        GROUP BY 
            c2.city
    );


--CTE

WITH city_spending AS (
    SELECT city, AVG(total_customer_spent) AS avg_city_spending
    FROM (
        SELECT c.customer_id, c.city, SUM(o.total_amount) AS total_customer_spent
        FROM customers c
        JOIN orders o ON c.customer_id = o.customer_id
        GROUP BY c.customer_id, c.city
    ) AS customer_totals
    GROUP BY city
),
customer_spending AS (
    SELECT c.customer_id, c.name, c.city, SUM(o.total_amount) AS total_spent, COUNT(o.order_id) AS order_count
    FROM customers c
    JOIN orders o ON c.customer_id = o.customer_id
    GROUP BY c.customer_id, c.name, c.city
    HAVING COUNT(o.order_id) > 2
)
SELECT cs.customer_id, cs.name, cs.city, cs.total_spent, cs.order_count
FROM customer_spending cs
JOIN city_spending csp ON cs.city = csp.city
WHERE cs.total_spent > csp.avg_city_spending;














