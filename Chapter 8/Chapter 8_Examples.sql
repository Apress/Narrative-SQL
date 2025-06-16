
CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    amount INT
);

INSERT INTO orders (order_id, amount) VALUES
(101, 1200),
(102, 700),
(103, 300);


SELECT order_id, amount, 
    CASE  
        WHEN amount >= 1000 THEN 'High' 
        WHEN amount >= 500 THEN 'Medium' 
        ELSE 'Low' 
    END AS category 
FROM orders; 

CREATE TABLE sales_data (
    product_category VARCHAR(50),
    sale_amount DECIMAL(10, 2),
    sale_date DATE
);

INSERT INTO sales_data (product_category, sale_amount, sale_date) VALUES
('Electronics', 1500, '2024-01-15'),
('Clothing', 450, '2024-01-16'),
('Electronics', 2300, '2024-01-17'),
('Books', 750, '2024-01-18'),
('Clothing', 1100, '2024-01-19'),
('Electronics', 3200, '2024-01-20'),
('Books', 250, '2024-01-21'),
('Clothing', 600, '2024-01-22'),
('Electronics', 4500, '2024-01-23'),
('Books', 890, '2024-01-24'),
('Clothing', 1750, '2024-01-25'),
('Electronics', 5600, '2024-01-26'),
('Books', 330, '2024-01-27'),
('Clothing', 880, '2024-01-28'),
('Electronics', 6700, '2024-01-29');


SELECT 
    product_category,  
    CASE 
        WHEN SUM(sale_amount) >= 10000 THEN 'High Volume'  
        WHEN SUM(sale_amount) >= 5000 THEN 'Medium Volume'  
        ELSE 'Low Volume'  
    END AS sales_volume_category,  
    COUNT(*) AS number_of_sales,  
    AVG(sale_amount) AS average_sale,  
    SUM(sale_amount) AS total_sales  
FROM sales_data 
GROUP BY product_category 
ORDER BY total_sales DESC; 




CREATE TABLE employee_metrics (
    emp_id INT PRIMARY KEY,
    name VARCHAR(50),
    sales INT,
    target INT,
    training_hours INT,
    projects_completed INT
);

INSERT INTO employee_metrics (emp_id, name, sales, target, training_hours, projects_completed) VALUES
(101, 'Alice', 50000, 45000, 20, 5),
(102, 'Bob', 30000, 0, 15, 3),
(103, 'Charlie', 75000, 60000, 0, 8),
(104, 'Diana', 45000, 40000, 25, 0),
(105, 'Eve', 0, 35000, 30, 4),
(106, 'Frank', 85000, 80000, 10, 7),
(107, 'Grace', 25000, 30000, 0, 2),
(108, 'Henry', 55000, 0, 40, 6),
(109, 'Ivy', 65000, 50000, 35, 0),
(110, 'Jack', 40000, 45000, 0, 5);


SELECT * FROM employee_metrics;


WITH performance_metrics AS ( 
    SELECT  
        emp_id, 
        name, 
        ROUND( 
            sales::numeric / NULLIF(target, 0) * 100,  
            2 
        ) AS target_achievement, 
        ROUND( 
            projects_completed::numeric / NULLIF(training_hours, 0) * 100, 
            2 
        ) AS productivity_ratio, 
        CASE  
            WHEN sales = 0 THEN NULL  
            WHEN target = 0 THEN NULL 
            ELSE ROUND((sales - target)::numeric / target * 100, 2) 
        END AS performance_variance 
    FROM employee_metrics 
) 
SELECT  
    pm.*, 
    CASE  
        WHEN target_achievement IS NULL THEN 'Invalid Target' 
        WHEN target_achievement >= 100 THEN 'Exceeded' 
        WHEN target_achievement >= 80 THEN 'On Track' 
        ELSE 'Below Target' 
    END AS performance_status, 
    CASE  
        WHEN productivity_ratio IS NULL THEN 'No Training Data' 
        WHEN productivity_ratio > 20 THEN 'High Efficiency' 
        WHEN productivity_ratio > 10 THEN 'Moderate Efficiency' 
        ELSE 'Needs Improvement' 
    END AS efficiency_rating 
FROM performance_metrics pm 
ORDER BY target_achievement DESC NULLS LAST; 

CREATE TABLE memberships (
    member_id INT PRIMARY KEY,
    member_name VARCHAR(50),
    membership_type VARCHAR(20),
    expiration_date DATE
);

INSERT INTO memberships (member_id, member_name, membership_type, expiration_date) VALUES
(1, 'John Doe', 'Gold', '2025-06-15'),
(2, 'Jane Smith', 'Silver', NULL),
(3, 'Mike Johnson', 'Gold', '2025-08-10'),
(4, 'Sarah Williams', 'Bronze', NULL),
(5, 'David Brown', 'Gold', '2025-07-01'),
(6, 'Emily Davis', 'Silver', NULL),
(7, 'James Wilson', 'Bronze', '2025-05-20'),
(8, 'Laura Martinez', 'Gold', NULL),
(9, 'Robert Taylor', 'Silver', '2025-09-25'),
(10, 'Sophia Anderson', 'Bronze', NULL);

SELECT * FROM memberships;



SELECT  
    member_id,  
    member_name,  
    membership_type,  
    COALESCE(expiration_date,  
        CASE  
            WHEN membership_type = 'Gold' THEN DATE '2025-12-31' 
            WHEN membership_type = 'Silver' THEN DATE '2025-11-30' 
            WHEN membership_type = 'Bronze' THEN DATE '2025-10-31' 
        END 
    ) AS adjusted_expiration_date 
FROM memberships; 

