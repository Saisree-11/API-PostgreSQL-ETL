CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100)
);

SELECT * FROM customers;


CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

SELECT * FROM products;


CREATE TABLE orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    amount DECIMAL(10,2),

    FOREIGN KEY(customer_id)
    REFERENCES customers(customer_id),

    FOREIGN KEY(product_id)
    REFERENCES products(product_id)
);


SELECT COUNT(*)
FROM orders;


SELECT table_name
FROM information_schema.tables
WHERE table_schema='public';



INSERT INTO products
VALUES
(1,'Laptop',50000),
(2,'Keyboard',1000),
(3,'Mouse',500);



SELECT *
FROM orders;


INSERT INTO orders
VALUES
(101,1,1,5000),
(102,1,2,7000),
(103,2,1,3000),
(104,3,3,6000),
(105,2,2,8000);


SELECT AVG(amount) AS average_order
FROM orders;



SELECT SUM(amount) AS total_sales
FROM orders;


SELECT MAX(amount) AS highest_order
FROM orders;


SELECT MIN(amount) AS lowest_order
FROM orders;


SELECT COUNT(*) AS total_orders
FROM orders;

SELECT
customer_id,
SUM(amount) AS total_sales
FROM orders
GROUP BY customer_id;


SELECT
customer_id,
COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id;

SELECT
product_id,
SUM(amount) AS sales
FROM orders
GROUP BY product_id;


SELECT
customer_id,
SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(amount) > 10000;


SELECT
customer_id,
COUNT(*) AS total_orders
FROM orders
GROUP BY customer_id
HAVING COUNT(*) > 2;



SELECT
c.customer_name,
o.order_id,
o.amount
FROM customers c
INNER JOIN orders o
ON c.customer_id = o.customer_id;


SELECT
p.product_name,
SUM(o.amount) AS total_sales
FROM products p
INNER JOIN orders o
ON p.product_id = o.product_id
GROUP BY p.product_name;




SELECT
c.customer_name,
SUM(o.amount) AS total_spent
FROM customers c
INNER JOIN orders o
ON c.customer_id=o.customer_id
GROUP BY c.customer_name
ORDER BY total_spent DESC;


SELECT
c.customer_name,
p.product_name,
o.order_id,
o.amount
FROM orders o
INNER JOIN customers c
ON o.customer_id = c.customer_id
INNER JOIN products p
ON o.product_id = p.product_id
ORDER BY o.amount DESC;


SELECT
c.customer_name,
o.order_id
FROM customers c
LEFT JOIN orders o
ON c.customer_id = o.customer_id
WHERE o.order_id IS NULL;


SELECT
customer_id,
SUM(amount) AS total_spent
FROM orders
GROUP BY customer_id
HAVING SUM(amount) >
(
    SELECT AVG(amount)
    FROM orders
);


SELECT
customer_id,
SUM(amount) AS total_spent,
RANK() OVER(
ORDER BY SUM(amount) DESC
) AS customer_rank
FROM orders
GROUP BY customer_id;


SELECT
customer_id,
SUM(amount) AS total_spent,
DENSE_RANK() OVER(
ORDER BY SUM(amount) DESC
) AS rank_no
FROM orders
GROUP BY customer_id;


SELECT
order_id,
amount,
SUM(amount) OVER(
ORDER BY order_id
) AS running_total
FROM orders;


CREATE INDEX idx_customer
ON orders(customer_id);

CREATE INDEX idx_product_id
ON orders(product_id);