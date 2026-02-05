create database E_Commerce ;
use E_Commerce;



create table customers( customer_id int primary key ,first_name varchar(20),last_name varchar(30), email varchar(40),phone int, city varchar(40),state varchar(50),country varchar(50),created_at timestamp default current_timestamp);

INSERT INTO customers 
(customer_id, first_name, last_name, email, phone, city, state, country)
VALUES
(1, 'John', 'Doe', 'john.doe@gmail.com', 987654321, 'New York', 'NY', 'USA'),
(2, 'Jane', 'Smith', 'jane.smith@gmail.com', 987654322, 'Los Angeles', 'CA', 'USA'),
(3, 'Rahul', 'Sharma', 'rahul@gmail.com', 987654323, 'Delhi', 'Delhi', 'India'),
(4, 'Anita', 'Verma', 'anita@gmail.com', 987654324, 'Mumbai', 'Maharashtra', 'India'),
(5, 'Ali', 'Khan', 'ali@gmail.com', 987654325, 'Dubai', 'Dubai', 'UAE');

select * from customers;



create table products( product_id int primary key ,product_name varchar(20),category varchar(30), price varchar(40),stock_quantity int,created_at timestamp default current_timestamp);

INSERT INTO products
(product_id, product_name, category, price, stock_quantity)
VALUES
(1, 'Laptop', 'Electronics', '70000', 20),
(2, 'Phone', 'Electronics', '30000', 50),
(3, 'Headphones', 'Accessories', '2000', 100),
(4, 'Keyboard', 'Accessories', '1500', 70),
(5, 'Mouse', 'Accessories', '800', 120);

select * from products;



create table orders( order_id int primary key ,customer_id int ,order_date varchar(30),order_status enum ("placed","shipped","delivered","cancelled") not null, total_amount int, foreign key (customer_id) references customers(customer_id) );


INSERT INTO orders
(order_id, customer_id, order_date, order_status, total_amount)
VALUES
(1, 1, '2024-01-10', 'placed', 70000),
(2, 2, '2024-01-11', 'shipped', 30000),
(3, 3, '2024-01-12', 'delivered', 2000),
(4, 4, '2024-01-13', 'cancelled', 1500),
(5, 5, '2024-01-14', 'placed', 800);

select * from orders;



create table order_items( order_item_id int primary key ,order_id int ,product_id int,quantity int, price int, foreign key (order_id) references orders(order_id), foreign key (product_id) references products(product_id));

INSERT INTO order_items
(order_item_id, order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 1, 70000),
(2, 2, 2, 1, 30000),
(3, 3, 3, 2, 2000),
(4, 4, 4, 1, 1500),
(5, 5, 5, 1, 800);

select * from order_items;



create table payments(payment_id int primary key , order_id int, payment_date int , payment_method enum ( "card", "upi", "netbanking","cod"),payment_status enum ("success", "failed", "pending"),foreign key (order_id) references orders(order_id));


INSERT INTO payments
(payment_id, order_id, payment_date, payment_method, payment_status)
VALUES
(1, 1, 20240110, 'card', 'success'),
(2, 2, 20240111, 'upi', 'success'),
(3, 3, 20240112, 'netbanking', 'success'),
(4, 4, 20240113, 'cod', 'failed'),
(5, 5, 20240114, 'upi', 'pending');

select * from payments;



SELECT 
    c.first_name,
    c.last_name,
    c.email,
    c.phone,
    c.city,
    c.state,
    c.country,
    p.product_name,
    p.category,
    p.price AS product_price,
    o.order_date,
    o.order_status,
    o.total_amount,
    oi.quantity,
    oi.price AS item_price,
    pay.payment_date,
    pay.payment_method,
    pay.payment_status
FROM customers c
JOIN orders o 
    ON c.customer_id = o.customer_id
JOIN order_items oi 
    ON o.order_id = oi.order_id
JOIN products p 
    ON oi.product_id = p.product_id
LEFT JOIN payments pay 
    ON o.order_id = pay.order_id;
