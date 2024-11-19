create database lab8;

drop table if exists salesman cascade ;
CREATE TABLE salesman (
    salesman_id INT PRIMARY KEY,
    name VARCHAR(50),
    city VARCHAR(50),
    commission DECIMAL(4, 2)
);

INSERT INTO salesman (salesman_id, name, city, commission)
VALUES
    (5001, 'James Hoog', 'New York', 0.15),
    (5002, 'Nail Knite', 'Paris', 0.13),
    (5005, 'Pit Alex', 'London', 0.11),
    (5006, 'Mc Lyon', 'Paris', 0.14),
    (5003, 'Lauson Hen', 'Rome', 0.12),
    (5007, 'Paul Adam', 'Rome', 0.13);

drop table if exists customers cascade ;
CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    cust_name VARCHAR(50),
    city VARCHAR(50),
    grade INT,
    salesman_id INT REFERENCES salesman(salesman_id)
);

INSERT INTO customers (customer_id, cust_name, city, grade, salesman_id)
VALUES
    (3002, 'Nick Rimando', 'New York', 100, 5001),
    (3005, 'Graham Zusi', 'California', 200, 5002),
    (3001, 'Brad Guzan', 'London', 0, 5005),
    (3004, 'Fabian Johns', 'Paris', 300, 5006),
    (3007, 'Brad Davis', 'New York', 200, 5001),
    (3009, 'Geoff Camero', 'Berlin', 100, 5003),
    (3008, 'Julian Green', 'London', 300, 5002);

drop table if exists orders cascade ;
CREATE TABLE orders (
    ord_no INT PRIMARY KEY,
    purch_amt DECIMAL(10, 2),
    ord_date DATE,
    customer_id INT REFERENCES customers(customer_id),
    salesman_id INT REFERENCES salesman(salesman_id)
);

INSERT INTO orders (ord_no, purch_amt, ord_date, customer_id, salesman_id)
VALUES
    (70001, 150.5, '2012-10-05', 3005, 5002),
    (70009, 270.65, '2012-09-10', 3001, 5005),
    (70002, 65.26, '2012-10-05', 3002, 5001),
    (70004, 110.5, '2012-08-17', 3009, 5003),
    (70007, 948.5, '2012-09-10', 3005, 5002),
    (70005, 2400.6, '2012-07-27', 3007, 5001),
    (70008, 5760, '2012-09-10', 3002, 5001);


-- 3. Create role named «junior_dev» with login privilege
create role junior_dev with login;

-- 4. Create a view for those salesmen belongs to the city New York
create view newYork_salesman as
select name
from salesman
where city = 'New York';

--5. Create a view that shows for each order the salesman and customer by name. Grant all privileges to «junior_dev»
create view order_salesman_customer as
    select o.ord_no, c.cust_name, s.name
    from orders o
    join salesman s on o.salesman_id = s.salesman_id
    join customers c on o.customer_id = c.customer_id;

grant all privileges on order_salesman_customer to junior_dev;

-- 6. Create a view that shows all of the customers who have the
-- highest grade. Grant only select statements to «junior_dev»
create view highest_grade as
    select grade
    from customers
    where grade = (select max(grade) from customers);

grant select on highest_grade to junior_dev;

-- 7. Create a view that shows the number of the salesman in each city.
create view salesmans_num as
    select count(*)
    from salesman
    group by city;

-- 8. Create a view that shows each salesman with more than one customer
CREATE VIEW salesmen_with_multiple_customers AS
SELECT s.name AS salesman_name
FROM salesman s
JOIN customers c ON s.salesman_id = c.salesman_id
GROUP BY s.salesman_id
HAVING COUNT(c.customer_id) > 1;

CREATE ROLE intern;
GRANT junior_dev TO inter;

