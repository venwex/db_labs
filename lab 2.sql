create database lab2;

create table countries (
    country_id serial primary key,
    country_name varchar(100),
    region_id integer,
    population integer
);

insert into countries (country_name, region_id, population)
values ('Kazakhstan', 1, 19000000);

insert into countries (country_id, country_name)
values (2, 'England');

insert into countries (country_name, region_id, population)
values ('Japan', NULL, 100000000);

insert into countries (country_name, region_id, population)
values
    ('Kyrgyzstan', NULL, 14000000),
    ('Russia', 2, 146000000),
    ('Uzbekistan', 3, 34000000);

alter table countries
alter column country_name set default 'Kazakhstan';

insert into countries (region_id, population)
values (1, 16000000);

insert into countries default values;

create table country_new (like countries including all);

insert into country_new (country_name, region_id, population)
select country_name, region_id, population
from countries;

update country_new
set region_id = 1
where region_id is null;

update country_new
set population = population * 1.1
returning country_name,population as "New Population";

delete from countries
where population < 100000;

delete from country_new
where country_id in (select country_id from countries)
returning *;

delete from countries
returning *;
