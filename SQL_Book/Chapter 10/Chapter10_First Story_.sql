CREATE TABLE customers (
    customer_id INTEGER PRIMARY KEY,
    name VARCHAR(5),
    email VARCHAR(19),
    signup_date VARCHAR(10),
    total_spent NUMERIC
);

INSERT INTO customers (customer_id, name, email, signup_date, total_spent) VALUES (1, 'Alice', 'alice@mail.com', '2022-03-15', 300.50);
INSERT INTO customers (customer_id, name, email, signup_date, total_spent) VALUES (2, 'Bob', 'bob@mail.com', '2021-07-10', 150.00);
INSERT INTO customers (customer_id, name, email, signup_date, total_spent) VALUES (3, 'Carol', 'carol123@mail.com', '2023-01-20', 450.75);
INSERT INTO customers (customer_id, name, email, signup_date, total_spent) VALUES (4, 'David', 'dave99@mail.com', '2021-12-05', 1200.00);
INSERT INTO customers (customer_id, name, email, signup_date, total_spent) VALUES (5, 'Eve', 'eve_wonder@mail.com', '2022-08-25', 550.25);


CREATE TABLE products (
    product_id INTEGER PRIMARY KEY,
    name VARCHAR(8),
    category VARCHAR(8),
    price INTEGER,
    stock INTEGER,
    attributes JSONB
);

INSERT INTO products (product_id, name, category, price, stock, attributes) VALUES (101, 'T-Shirt', 'Clothing', 20.00, 100, '{"color": "red", "size": "M"}');
INSERT INTO products (product_id, name, category, price, stock, attributes) VALUES (102, 'Jeans', 'Clothing', 50.00, 50, '{"color": "blue", "size": "L"}');
INSERT INTO products (product_id, name, category, price, stock, attributes) VALUES (103, 'Jacket', 'Clothing', 100.00, 30, '{"color": "black", "size": "XL"}');
INSERT INTO products (product_id, name, category, price, stock, attributes) VALUES (104, 'Sneakers', 'Footwear', 80.00, 40, '{"color": "white", "size": "10"}');
INSERT INTO products (product_id, name, category, price, stock, attributes) VALUES (105, 'Hoodie', 'Clothing', 60.00, 25, '{"color": "gray", "size": "L"}');


CREATE TABLE orders (
    order_id INTEGER PRIMARY KEY,
    customer_id INTEGER,
    product_id INTEGER,
    quantity INTEGER,
    order_date DATE,
    total_price INTEGER
);

INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date, total_price) VALUES (1, 1, 101, 2, '2023-02-05', 40);
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date, total_price) VALUES (2, 2, 102, 1, '2023-02-10', 50);
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date, total_price) VALUES (3, 3, 103, 1, '2023-02-15', 100);
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date, total_price) VALUES (4, 4, 104, 2, '2023-02-20', 160);
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date, total_price) VALUES (5, 5, 105, 1, '2023-02-25', 60);
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date, total_price) VALUES (6, 1, 102, 1, '2023-03-01', 50);
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date, total_price) VALUES (7, 3, 101, 3, '2023-03-05', 60);
INSERT INTO orders (order_id, customer_id, product_id, quantity, order_date, total_price) VALUES (8, 4, 105, 2, '2023-03-10', 120);


SELECT 
    SUM(total_price) AS total_revenue, 
    AVG(total_price) AS avg_order_value 
FROM orders;


SELECT 
    DATE_TRUNC('month', order_date) AS month, 
    COUNT(order_id) AS total_orders 
FROM orders 
GROUP BY month 
ORDER BY month;


SELECT 
    product_id, 
    SUM(quantity) AS total_sold, 
    RANK() OVER (ORDER BY SUM(quantity) DESC) AS rank 
FROM orders 
GROUP BY product_id;


SELECT 
    customer_id, 
    SUM(total_price) AS total_spent, 
    RANK() OVER (ORDER BY SUM(total_price) DESC) AS rank 
FROM orders 
GROUP BY customer_id;

SELECT 
    name, 
    email, 
    SPLIT_PART(email, '@', 2) AS domain 
FROM customers;

SELECT 
    name, 
    attributes->>'color' AS color 
FROM products;

SELECT 
    name, 
    COALESCE(CAST(stock AS TEXT), 'Out of Stock') AS stock_status 
FROM products;


CREATE FUNCTION calculate_loyalty_score(total_spent NUMERIC) 
RETURNS TEXT AS $$
BEGIN
    IF total_spent >= 1000 THEN
        RETURN 'Platinum';
    ELSIF total_spent >= 500 THEN
        RETURN 'Gold';
    ELSIF total_spent >= 200 THEN
        RETURN 'Silver';
    ELSE
        RETURN 'Bronze';
    END IF;
END;
$$ LANGUAGE plpgsql;

SELECT 
    name, 
    total_spent, 
    calculate_loyalty_score(total_spent) AS loyalty_level
FROM customers;



