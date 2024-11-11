create database lab7;

drop table if exists countries cascade;
CREATE TABLE countries (
    name VARCHAR(100) NOT NULL,
    region VARCHAR(50)
);

INSERT INTO countries (name, region) VALUES
('Kazakhstan', 'Central Asia'),
('Russia', 'Eastern Europe'),
('France', 'Western Europe');

drop table if exists employees;
CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    surname VARCHAR(100) NOT NULL,
    salary DECIMAL(10, 2),      -- Зарплата сотрудника
    budget DECIMAL(12, 2),      -- Бюджет, выделенный сотруднику или его проекту
    department_id INTEGER       -- ID департамента, к которому относится сотрудник
);

INSERT INTO employees (name, surname, salary, budget, department_id) VALUES
('John', 'Doe', 50000.00, 100000.00, 1),
('Jane', 'Smith', 60000.00, 120000.00, 2),
('Alice', 'Johnson', 55000.00, 110000.00, 1);



-- 1
-- SELECT * FROM countries WHERE name = ‘string’;
drop index if exists country_name;
create index country_name on countries (name);


-- 2
-- SELECT * FROM employees WHERE name = ‘string’ AND surname = ‘string’;
drop index if exists name_employees;
create index name_employees on employees (name, surname);

-- 3
-- SELECT * FROM employees WHERE salary < value1 AND salary > value2;
drop index if exists new_salary;
create unique index new_salary on employees (salary);
--where salary < value1 and salary > value2;

-- 4
-- SELECT * FROM employees WHERE substring(name from 1 for 4) = ‘abcd’;
drop index if exists new_name;
create index new_name on employees (substring(name from 1 for 4));

-- 5
-- SELECT * FROM employees e JOIN departments d
-- ON d.department_id = e.department_id WHERE d.budget > value2 AND e.salary < value2;
drop index if exists department_id_budget;
drop index if exists salary_department_id;
create index department_id_budget on departments(department_id, budget);
create index salary_department_id on employees(salary, department_id);