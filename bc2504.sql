create database bootcamp_2504;

use bootcamp_2504;
-- MYSQL -> case insensitive
-- Database SQL -> case insensitive

create table Person (
	name varchar(50),
    age integer,
    salary NUMERIC(10, 2)
);

insert into Person (name, age, salary) values ('John', 13, 25000.5);
insert into Person (name, age, salary) values ('Peter', 18, 35000);

-- * means all columns
select * from person;
select name from person;
select name, salary from person;
select name, salary, salary * 2 from person;

-- update the data in harddisk
update person set age = 19 where name = 'John';

select * from person;

delete from person where salary > 30000;

select * from person;
drop table cat;
-- create Cat table
create table cat (
	id bigint,
	name varchar(50),
	age integer
);
-- insert 3 cat
insert into cat (id, name) values (1, 'John');  -- OK
insert into cat values (2, 'Peter', 10); -- OK
insert into cat (id, name, age) values (3, 'Sally', 20); -- OK
insert into cat values 
	(4, 'Lucas', 2), 
    (5, 'Steven', 8);
-- update 2 cat by condition
update cat set name = concat('super', name) where age > 9;
select * from cat;

-- delete 1 cat by condition
delete from cat where age is null;
select * from cat;