create database lab4;

create table Warehouses (
    code serial primary key,
    local varchar(255),
    capacity integer
);

create table Boxes (
    code char(4),
    contents varchar(255),
    value real,
    warehouse integer
);

insert into Warehouses (local, capacity) values
('Chicago', 3),
('Chicago', 4),
('New York', 7),
('Los Angeles', 2),
('San Francisco', 8);


insert into Boxes (code, contents, value, warehouse) values
('0MN7', 'Rocks', 180, 3),
('4H8P', 'Rocks', 250, 1),
('4RT3', 'Scissors', 190, 4),
('7G3H', 'Rocks', 200, 1),
('8JN6', 'Papers', 75, 1),
('8Y6U', 'Papers', 50, 3),
('9J6F', 'Papers', 175, 2),
('LL08', 'Rocks', 140, 4),
('P0H6', 'Scissors', 125, 1),
('P2T6', 'Scissors', 150, 2),
('TU55', 'Papers', 90, 5);

select * from Warehouses;

select *
from boxes
where value > 150;

select distinct on(contents) *
from boxes;

select warehouse, count(*)
from boxes
group by warehouse;

select warehouse, count(warehouse)
from boxes
where warehouse > 2
group by warehouse;

insert into warehouses (local, capacity) values
('New York', 3);

insert into boxes (code, contents, value, warehouse) values
('H5RT', 'Papers', 200, 2);

update boxes
set value = value * 0.85
where value = (
    select distinct value
    from boxes
    order by value desc
    limit 1 offset 2
);

delete
from boxes
where value < 150;

delete
from boxes
where warehouse = (
   select code from warehouses where local = 'New York' limit 1
)
returning *;