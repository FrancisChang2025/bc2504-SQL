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

-- drop table
-- drop table cat;

-- WHERE 條件 -> filter rows
-- AND OR
select * from cat where name = 'lucas' or age > 10;
select * from cat where name = 'lucas' or (age > 10 and name = 'Steven');
-- Database does not have index cocept, instead, we have position
select instr(name, 'Peter'), name from cat where age >= 10 and instr(name, 'Peter') > 0;

-- select
-- alias
select instr(name, 'Peter'), c.*, 'hello', 1 from cat c;
select c.name, c.id, c.age from cat c;

-- update
update cat set age = 40, id = 20 where name = 'Steven';
select * from cat;

-- add column
alter table cat add column email varchar(50);
select * from cat;

update cat set email = 'lucas@gmail.com' where name = 'lucas';
update cat set email = 'peter@yahoo.com.hk' where name = 'peter';
update cat set email = 'steven@gmail.com' where name = 'steven';
select * from cat;

-- modify column
alter table cat modify email varchar(70);

-- ordering
-- by default ascending order
-- asc -> ascending order
-- desc -> descending order
select *
from cat
where name = 'lucas' or name = 'steven'
order by age desc;

insert into cat values (5, 'vincent', 10, 'vincent@gmail.com');

select c.* -- last step
from cat c
where length(c.name) > 5 -- first step
order by c.age desc, c.name desc; -- second step

-- String functions
-- substring
select substring(c.name,1,3) -- 1 -> starting from which position
from cat c;

select upper(c.name), lower(c.name), c.name
from cat c;

select replace(c.name, 's', 'x'), c.name
from cat c;

-- add back 'John'
insert into Person (name, age, salary) values ('John', 13, 25000.5);

-- case insensitive
select c.* from cat c where c.name = 'lucas';

-- DBMS (Database Manageent System)
-- Java Object = row (not a cell)
-- an attribute of an object = a column of a row (field)
-- List<Object> = table

-- Math 
CREATE TABLE circles (
	id BIGINT,
    radius DECIMAL(3, 2), -- same as numeric
    color VARCHAR(20)
);

-- Java String -> serialization (conversion) -> Database VARCHAR

INSERT INTO circles VALUES (1, 3.5, 'RED');
INSERT INTO circles VALUES (2, 4.1, 'YELLOW');

select * from circles;

SELECT round(c.radius * c.radius * 3.14, 3), 
	c.radius * c. radius * 3.14,
    pow(c.radius, 2) * PI(),
    ceil(c.radius * c. radius * 3.14),
    floor(c.radius * c. radius * 3.14),
    c.radius
    FROM circles c;

-- arr.length, dogs.size() in Java, But Database no this

INSERT INTO circles VALUES (3, 4.2, 'BLUE');
INSERT INTO circles VALUES (4, 8, 'RED');

SELECT c.* -- 3rd step 
FROM circles c
WHERE c.radius > 4 -- 1st step
ORDER BY c.color;  -- 2nd step

-- Table Design/ Date
-- 1. User request (datetime)
-- 2. Result of processing (Datetime)

CREATE TABLE customer_order_requests (
	id BIGINT,
    order_datetime DATETIME,
    customer_id BIGINT,
    order_id BIGINT
);

INSERT INTO customer_order_requests VALUES (1, '2024-10-31 14:30:35', 23, 90);

INSERT INTO customer_order_requests VALUES (2, STR_TO_DATE('2025-1-31 14:30:35',  23, 90,'%Y-%m-%d %H: %i:%s'), 20,150);

INSERT INTO customer_order_requests VALUES (3, NOW(), 10, 400);

SELECT * FROM customer_order_requests;



