create database bootcamp_2504;

use bootcamp_2504;
-- MYSQL -> case insensitive
-- Database SQL -> case insensitive

create table Person (
	name varchar(50),
    age integer,
    salary NUMERIC(10, 2)
);
-- insert data in harddisk
insert into Person (name, age, salary) values ('John', 13, 25000.5);
insert into Person (name, age, salary) values ('Peter', 18, 35000);

-- Delete Original Records: Clear the original table
DELETE FROM Person;

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

-- drop table cat;
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

select * from cat;
    
-- update 2 cat by condition
update cat set name = concat('super', name) where age > 9;
select * from cat;

-- delete 1 cat by condition
delete from cat where age is null;
select * from cat;

-- drop table
-- drop table cat;
DELETE FROM cat;

-- WHERE 條件 -> filter rows
-- AND OR
select * from cat where name = 'lucas' or age > 10;
select * from cat where name = 'lucas' or (age > 10 and name = 'Steven');
SELECT * FROM cat WHERE age >= 10 AND instr(name, 'Peter');
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
update cat set email = 'john@gmail.com' where name = 'John';
select * from cat;
DELETE FROM cat;

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

insert into cat values (6, 'vincent', 10, 'vincent@gmail.com');

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

-- DBMS (Database Managment System)
-- Java Object = row (not a cell)
-- an attribute of an object = a column of a row (field)
-- List<Object> = table

DELETE FROM circles;
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

INSERT INTO customer_order_requests VALUES (2, STR_TO_DATE('2025-1-31 14:30:35', '%Y-%m-%d %H:%i:%s'), 20, 150);

INSERT INTO customer_order_requests VALUES (3, NOW(), 10, 400);

SELECT * FROM customer_order_requests;

DELETE FROM customer_order_requests;

DELETE FROM customers;
DROP TABLE customers;

CREATE TABLE customers (
	id BIGINT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    dob DATE,
    gender VARCHAR(1)
);

INSERT INTO customers VALUES (1, 'Lucas', 'Chan', STR_TO_DATE('2008-01-31 14:30:35', '%Y-%m-%d %H:%i:%s'), 'M');
INSERT INTO customers VALUES (2, 'Peter', 'Lau', STR_TO_DATE('2005-02-20 16:30:35', '%Y-%m-%d %H:%i:%s'), 'M');
INSERT INTO customers VALUES (3, 'Sally', 'Lau', STR_TO_DATE('1998-12-20 14:30:35', '%Y-%m-%d %H:%i:%s'), 'F');

SELECT * FROM customers;
-- find the customer, whose last_name = lau and dob > 2000-01-01
SELECT * FROM customers where last_name = 'Lau' and dob > STR_TO_DATE('2000-01-01 14:30:35', '%Y-%m-%d');

SELECT date_add(c.dob, INTERVAL 3 MONTH), c.* FROM customers c;
SELECT date_sub(c.dob, INTERVAL 3 MONTH), c.* FROM customers c;
SELECT datediff(now(), c.dob), c.* FROM customers c;
SELECT datediff(c.dob, '2000-1-1'), c.* FROM customers c;

-- Aggregation Functions
-- count, max, min, avg, sum
SELECT count(*) FROM customers where dob > STR_TO_DATE('2000-01-01 14:30:35', '%Y-%m-%d');
SELECT max(dob) FROM customers;
SELECT min(dob) FROM customers;


-- AVG() and SUM() -> summary of rows, but we cannot show all ages of cats in a single row.
-- SELECT AVG(age), SUM(age), age FROM cat; -- ALL error (Not common sense)
SELECT SUM(age), max(id) FROM cat;
SELECT AVG(age) FROM cat;
SELECT * FROM cat;

-- GROUP BY
DROP TABLE books;

CREATE TABLE books (
	title VARCHAR(50),
    genre VARCHAR(50),
    price DECIMAL(4, 2)
);

DELETE FROM books;  -- 清空書架 (內容)
INSERT INTO books VALUE('book 1', 'adventure', 11.9);
INSERT INTO books VALUE('book 2', 'fantasy', 8.49);
INSERT INTO books VALUE('book 3', 'romance', 9.99);
INSERT INTO books VALUE('book 4', 'adventure', 9.99);
INSERT INTO books VALUE('book 5', 'fantasy', 7.99);
INSERT INTO books VALUE('book 6', 'romance', 5.88);

-- 1. group by genre
-- 2. average price per group
-- 3. those group with average price > 10 -> result

SELECT * FROM books;
-- where -> filter record
-- having -> filter group

SELECT b.genre, count(*), AVG(b.price)
FROM books b
GROUP BY b.genre;

SELECT b.genre, count(*), max(b.price) -- step 3
FROM books b
WHERE b.genre <> 'adventure' -- step 1
GROUP BY b.genre HAVING max(b.price) > 9; -- step 2


-- Table relationships (One to Many)
CREATE TABLE orders (
	id BIGINT,
    order_date DATE,
    amount DECIMAL(6, 2),
    customer_id BIGINT
);
INSERT INTO orders VALUES (1, '2025-05-01', 999.9, 2);
INSERT INTO orders VALUES (2, '2025-05-09', 1500, 3);
INSERT INTO orders VALUES (3, '2025-05-18', 80, 2);

SELECT * FROM orders;
SELECT * FROM customers
-- Find customer who did not order anything.
-- exists
SELECT *
FROM customers c
WHERE EXISTS (SELECT * FROM orders o WHERE o.customer_id = c.id);

-- not exists
SELECT *
FROM customers c
WHERE NOT EXISTS (SELECT * FROM orders o WHERE o.customer_id = c.id);

-- Find customer who order something between 2025-05-09 and 2025-05-15
SELECT *
FROM customers c
WHERE EXISTS (SELECT * FROM orders o WHERE o.customer_id = c.id AND o.order_date BETWEEN '2025-05-09' and '2025-05-15');

-- for (Customer c : customers) {
-- 	for (Order o : orders {
-- 		if (o.getCustomerId == c.id) {
-- 			break;
--        }
--  	}
-- }

-- JOIN tables (Customers + orders)
-- inner join

-- select c.*, o.amount

SELECT c.gender, c.first_name, o.id, o.amount
FROM customers c INNER JOIN orders o ON c.id = o.customer_id  -- step 1
WHERE o.order_date BETWEEN '2025-05-09' AND '2025-05-15'; -- step 2

-- left join (Two tables)
SELECT c.*, o.*
FROM customers c LEFT JOIN orders o ON c.id = o.customer_id;

SELECT c.*, o.*
FROM orders o LEFT JOIN customers c ON c.id = o.customer_id;

-- right join (Un-usually use)
SELECT c.*, o.*
FROM customers c RIGHT JOIN orders o ON c.id = o.customer_id;

SELECT c.*, o.*
FROM orders o RIGHT JOIN customers c ON c.id = o.customer_id;

-- hard delete
DELETE FROM orders;

-- soft delete
SELECT * FROM orders;
ALTER TABLE orders ADD delete_ind VARCHAR(1);
ALTER TABLE orders ADD delete_detetime DATETIME;
UPDATE orders SET delete_ind = 'Y', delete_datetime = now() WHERE id = 2;

SELECT o.id, o.order_date, o.amount, o.customer_id FROM orders o WHERE o.delete_ind IS NULL;


-- Many to Many
CREATE TABLE students (
	id BIGINT,
    name VARCHAR(20)
);

CREATE TABLE subjects (
	id BIGINT,
    name VARCHAR(20)
);

CREATE TABLE subject_enrollments (
		id BIGINT,
		student_id BIGINT,
		subject_id BIGINT
);

DELETE FROM students;
DELETE FROM subjects;
DELETE FROM subject_enrollments;

INSERT INTO students VALUES (1, 'Lucas');
INSERT INTO students VALUES (2, 'Leo');
INSERT INTO students VALUES (3, 'Vincent');

INSERT INTO subjects VALUES (1, 'Maths');
INSERT INTO subjects VALUES (2, 'History');
INSERT INTO subjects VALUES (3, 'English');

INSERT INTO subject_enrollments VALUES (1, 2, 2);
INSERT INTO subject_enrollments VALUES (2, 2, 3);
INSERT INTO subject_enrollments VALUES (3, 3, 1);

SELECT * FROM students;

-- 1. Find any students who did not enroll any subject
-- show student id and student name
-- not exists
SELECT s.id, s.name
FROM students s
WHERE NOT EXISTS (SELECT 1 FROM subject_enrollments se WHERE se.student_id = s.id);

-- 2. Find enrolled subjects and its student name
-- show the student name and subject name only. (Join 3 tables)
SELECT stu.name, s.name
FROM 


-- 3. Find all students, who enrolled History and Maths
-- show the student id and name (Join 2 tables, without subject table)
SELECT st.id, st.name
FROM students st INNER JOIN subject_enrollments se ON st.id = se.student_id
WHERE se.subject_id IN (1, 2);

-- 4. Find subjects, which did not enrolled by any student,
-- show the subject id and name
SELECT sb.id, sb.name
FROM subjects sb
WHERE NOT EXISTS (SELECT 1 FROM subject_enrollments se WHERE se.subject_id = sb.id);

-- 5. Find all students, and his enrollemnt subject if any. No matter the student as enrolled subject.
-- show student name, and enrolled subject name if any.  (LEFT JOIN)

SELECT temp_result.student_name, sb.name
FROM
(SELECT st.id, st.name AS student_name, se.student_id, se.subject_id
FROM students st LEFT JOIN subject_enrollments se ON st.id = se.student_id) temp_result
	INNER JOIN subjects sb ON sb.id = temp_result.subject_id;

SELECT st.name AS student_name, sb.name AS subject_name
FROM subject_enrollments se
	RIGHT JOIN students st ON st.id = se.student_id
    INNER JOIN subjects sb ON sb.id = se.subject_id;



-- One to One






