CREATE TABLE sales (
    sale_id VARCHAR(7),
    product_id VARCHAR(10),
    amount FLOAT(6),
    sale_date VARCHAR(10)
);

INSERT INTO sales (sale_id, product_id, amount, sale_date) VALUES ('1', '101', '120.5', '2024-03-01');
INSERT INTO sales (sale_id, product_id, amount, sale_date) VALUES ('2', '102', '85.75', '2024-03-02');
INSERT INTO sales (sale_id, product_id, amount, sale_date) VALUES ('3', '101', '99.99', '2024-03-02');
INSERT INTO sales (sale_id, product_id, amount, sale_date) VALUES ('4', '103', '150', '2024-03-03');
INSERT INTO sales (sale_id, product_id, amount, sale_date) VALUES ('5', '101', '110', '2024-03-04');
INSERT INTO sales (sale_id, product_id, amount, sale_date) VALUES ('6', '104', '200', '2024-03-05');
INSERT INTO sales (sale_id, product_id, amount, sale_date) VALUES ('7', '102', '80.5', '2024-03-06');
INSERT INTO sales (sale_id, product_id, amount, sale_date) VALUES ('8', '103', '175.25', '2024-03-07');
INSERT INTO sales (sale_id, product_id, amount, sale_date) VALUES ('9', '101', '125', '2024-03-08');
INSERT INTO sales (sale_id, product_id, amount, sale_date) VALUES ('10', '105', '300', '2024-03-09');

SELECT * FROM sales;

CREATE INDEX idx_sale_date ON sales(sale_date);

CREATE VIEW sales_summary AS
SELECT product_id, SUM(amount) AS total_sales
FROM sales
GROUP BY product_id;


CREATE MATERIALIZED VIEW sales_summary_mat AS
SELECT product_id, SUM(amount) AS total_sales
FROM sales
GROUP BY product_id;

CREATE INDEX idx_sales_summary ON sales_summary_mat(product_id);


SELECT * FROM sales_summary_mat;

REFRESH MATERIALIZED VIEW sales_summary_mat;