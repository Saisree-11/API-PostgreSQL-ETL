CREATE DATABASE sales_db;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

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
