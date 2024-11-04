create database lab6;

CREATE TABLE locations(
    location_id SERIAL PRIMARY KEY,
    street_address VARCHAR(25),
    postal_code VARCHAR(12),
    city VARCHAR(30),
    state_province VARCHAR(12)
);
drop table if exists departments cascade ;
CREATE TABLE departments(
    department_id SERIAL PRIMARY KEY,
    department_name VARCHAR(50) UNIQUE,
    budget INTEGER,
    location_id INTEGER REFERENCES locations
);

drop table if exists employees cascade ;
CREATE TABLE employees(
    employee_id SERIAL PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(50),
    phone_number VARCHAR(20),
    salary INTEGER,
    department_id INTEGER REFERENCES departments
);

INSERT INTO locations (street_address, postal_code, city, state_province)
VALUES
    ('123 Main St', '12345', 'New York', 'NY'),
    ('456 Elm St', '67890', 'Los Angeles', 'CA'),
    ('789 Maple Ave', '11223', 'Chicago', 'IL');

INSERT INTO departments (department_name, budget, location_id)
VALUES
    ('Human Resources', 50000, 1),
    ('Finance', 75000, 2),
    ('Engineering', 100000, 3);

INSERT INTO employees (first_name, last_name, email, phone_number, salary, department_id)
VALUES
    ('John', 'Doe', 'john.doe@example.com', '555-1234', 60000, 1),
    ('Jane', 'Smith', 'jane.smith@example.com', '555-5678', 80000, 2),
    ('Emily', 'Jones', 'emily.jones@example.com', '555-8765', 90000, 3);

select employees.first_name, employees.last_name,
       employees.department_id, d.department_name
from employees
join departments as d on employees.department_id = d.department_id;

select employees.first_name, employees.last_name,
       employees.department_id, d.department_name
from employees
join departments as d on employees.department_id = d.department_id
where employees.department_id = 40 or employees.department_id = 80;

select e.first_name, e.last_name,
       e.department_id, l.city,
       l.state_province
from employees e
join departments d on d.department_id = e.department_id
join locations l on l.location_id = d.location_id;

SELECT d.department_id,  d.department_name,
    d.budget, l.city, l.state_province,
    e.first_name, e.last_name
from departments d
left join locations l ON d.location_id = l.location_id
left join employees e ON d.department_id = e.department_id;

select e.first_name, e.last_name,
    d.department_id, d.department_name
from employees e
left join departments d ON e.department_id = d.department_id;



