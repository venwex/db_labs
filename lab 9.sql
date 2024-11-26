-- 1. Write a stored procedure named increase_value that takes one
-- integer parameter and returns the parameter value increased by 10.
create or replace function increase_value (inout n integer)
as $$
begin
        n := n + 10;
end; $$
language plpgsql;
select * from increase_value(10);

-- 2. Create a stored procedure compare_numbers that takes two
-- integers and returns 'Greater', 'Equal', or ‘Lesser' as an out
-- parameter, depending on the comparison result of these two numbers
create or replace function compare_numbers (a integer, b integer)
    returns varchar
    as $$
begin
    if a > b then return 'greater';
    elseif a < b then return 'lesser';
    else return 'equal';
end if;
end; $$
        language plpgsql;
select * from compare_numbers(10, 20);
select * from compare_numbers(100, 20);

-- 3. Write a stored procedure number_series that takes an integer n
-- and returns a series from 1 to n. Use a looping construct within the procedure
create or replace function number_series(n integer)
    returns setof integer
as $$
    declare
        i integer := 1;
begin
    while (i <= n) loop
        return next i;
        i := i + 1;
    end loop;
    return;
end;
    $$
language plpgsql;
select * from number_series(6);

-- 4.
create or replace function find_employee(employee_name varchar)
returns employees
language plpgsql
as $$
begin
    return query
    select * from employees
    where name = employee_name
    limit 1;
end;
$$;

-- 5.
create or replace function list_products(category_name integer)
returns table(pr_id integer, pr_name varchar, pr_category integer) as
$$
    begin
    return query select id, name, category from products
        where category = category_name;
    end;
$$
language plpgsql;

create table products(
    id integer,
    name varchar,
    category integer
);

insert into products values (5001, 'water', 1);
insert into products values (5002, 'cola', 1);

select * from list_products(1);


-- 6.
create or replace function calculate_bonus(employee_id integer)
returns integer as
$$
    declare bonus integer;
begin
        select salary*0.1 into bonus from employees
        where employee_id = employee_id;
        return bonus;
end;
$$
language plpgsql;

create or replace function update_salary(employee_id integer)
returns table(id integer, nname varchar, nsalary integer) as
$$
    declare bonus integer;
    begin
        bonus := calculate_bonus(employee_id);
        return query update employees set salary = salary + bonus
        where employee_id = employee_id returning *;
    end;
$$
language plpgsql;

select * from update_salary(7001);

-- 7.
create or replace function complex_calculation(n integer, str varchar)
returns varchar as
$$
    declare res varchar;
    begin
    <<inner_block1>>
    begin
        n = n * n;
    end inner_block1;
    <<inner_block2>>
    begin
        str = '!' || str || '!';
    end inner_block2;
    res = str || n;
    return res;
    end;
$$
language plpgsql;

select * from complex_calculation(5, 'sentence');

