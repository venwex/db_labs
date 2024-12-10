create database lab10;

create table books (
    book_id integer primary key,
    title varchar,
    author varchar,
    price decimal,
    quantity integer
);

create table orders (
    order_id integer primary key,
    book_id integer references books(book_id),
    customer_id integer,
    order_date date,
    quantity integer
);

create table customers (
    customer_id integer primary key,
    name varchar,
    email varchar
);

insert into books values
(1, 'Database 101', 'A. Smith', 40.00, 10),
(2, 'Learn SQL', 'B. Johnson', 35.00, 15),
(3, 'Advanced DB', 'C. Lee', 50.00, 5);

insert into customers values
(101, 'John Doe', 'johndoe@example.com'),
(102, 'Jane Doe', ' janedoe@example.com');

-- 1
begin;
insert into orders values (1, 1, 101, '10-12-2024', '2');
update books set quantity = quantity - 2 where book_id = 1;
commit;

-- 2
begin;
do $$
begin;
    if (select quantity from books where book_id = 3) >= 10 then
        insert into orders values (3, 3, 102, '10-12-2024', 10);
        update books set quantity = quantity - 10 where book_id = 3;
    else
        rollback;
        raise notice 'not enough quantities';
    end if;
end;
$$;

-- 3
begin transaction isolation level read committed;
update books set price = 15 where book_id = 2;
select price from books where book_id = 2;
commit;

-- 4
begin;
update customers set email = 'example@gmail.com' where customer_id = 101;
select email from customers where customer_id = 101;
commit;

