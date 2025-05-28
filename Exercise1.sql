CREATE DATABASE bootcamp_Exercise1;

USE bootcamp_Exercise1;

-- PK PK
-- PK FK

DROP TABLE job_history;
DROP TABLE employees;
DROP TABLE jobs;
DROP TABLE departments;
DROP TABLE locations;
DROP TABLE countries;
DROP TABLE regions;

DELETE FROM job_history;
DELETE FROM employees;
DELETE FROM jobs;
DELETE FROM departments;
DELETE FROM locations;
DELETE FROM countries;
DELETE FROM regions;

-- AUTO_INCREMENT -> FIND MAX ID in table, + 1

DELETE FROM regions;
CREATE TABLE regions (
	regions_id INT AUTO_INCREMENT,
    regions_name VARCHAR(25) NOT NULL,
    CONSTRAINT pk_regions PRIMARY KEY (region_id)
);

-- READ / WRITE
INSERT INTO regions (region_name) VALUES ('JAPAN'); -- 1
INSERT INTO regions (region_name) VALUES ('CHINA'); -- 2
SELECT * FROM regions;
DELETE FROM regions;
DELETE FROM regions WHERE region_id = 1;  -- delete japan
INSERT INTO regions (region_name) VALUES ('US');  -- 3


INSERT INTO regions VALUES (1, 'North America'); -- United State
INSERT INTO regions VALUES (2, 'South America');  -- Italy
INSERT INTO regions VALUES (3, 'Europe'); -- Germany
INSERT INTO regions VALUES (4, 'Asia');  -- Japan

SELECT * FROM regions;

CREATE TABLE countries (
	country_id CHAR(2) PRIMARY KEY,
    country_name VARCHAR(40) NOT NULL,
    region_id BIGINT NOT NULL,
    FOREIGN KEY (region_id) REFERENCES regions (region_id)
);
DELETE FROM countries;
INSERT INTO countries VALUES ('DE', 'Germany', 3);
INSERT INTO countries VALUES ('IT', 'Italy', 2);
INSERT INTO countries VALUES ('JP', 'Japan', 4);
INSERT INTO countries VALUES ('US', 'United State', 1);

SELECT * FROM countries;

CREATE TABLE locations (
	location_id BIGINT PRIMARY KEY,
    street_address VARCHAR(25)NOT NULL,
    postal_code VARCHAR(12),
    city VARCHAR(30) NOT NULL,
    state_province VARCHAR(12),
    country_id CHAR(2),
    FOREIGN KEY (country_id) REFERENCES countries(country_id)
);

DELETE FROM locations;
INSERT INTO locations VALUES (1000, '1297 Via Cola di Rie', '989', 'Roma', '', 'IT');
INSERT INTO locations VALUES (1100, '93091 Calle della Te', '10934', 'Venice', '', 'IT');
INSERT INTO locations VALUES (1200, '2017 Shinjuku-ku', '1689', 'Tokyo', 'Tokyo JP', 'JP');
INSERT INTO locations VALUES (1400, '2914 Jabberwocky Rd', '26192', 'Southlake', 'Texas', 'US');

SELECT * FROM locations;

CREATE TABLE departments (
	department_id BIGINT PRIMARY KEY,
    department_name VARCHAR(30) NOT NULL,
    manager_id BIGINT,
    location_id BIGINT,
    FOREIGN KEY (location_id) REFERENCES locations(location_id)
);

INSERT INTO departments VALUES (10, 'Administration', 200, 1100);
INSERT INTO departments VALUES (20, 'Marketing', 201, 1400);
INSERT INTO departments VALUES (30, 'Purchasing', 202, 1200);

SELECT * FROM departments;

-- One job for many employee
CREATE TABLE jobs (
	job_id VARCHAR(10) PRIMARY KEY,
    job_title VARCHAR(35) NOT NULL,
    min_salary NUMERIC(10, 2),
    max_salary NUMERIC(10, 2)
);

INSERT INTO jobs VALUES ('IT_PROG', 'senior', 22000, 50000);
INSERT INTO jobs VALUES ('MK_REP', 'supervisor', 25500, 70000);
INSERT INTO jobs VALUES ('ST_CLERK', 'Junior', 17800, 25000);

SELECT * FROM jobs;

DELETE FROM employees;
CREATE TABLE employees (
	employee_id BIGINT PRIMARY KEY,
    first_name VARCHAR(20),
    last_name VARCHAR(25),
    email VARCHAR(25) UNIQUE,
    phone_number VARCHAR(20),
    hire_date DATE,
    salary NUMERIC(10, 2),
    commission_pct NUMERIC(5, 2),
    manager_id BIGINT,
    job_id VARCHAR(10),
	FOREIGN KEY (job_id) REFERENCES jobs(job_id),
    department_id BIGINT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO employees VALUES (100, 'Steven', 'King', 'sking@gmail.com', '515-1234567', '1987-06-17', 20000, 0, 202, 'IT_PROG', 10);
INSERT INTO employees VALUES (101, 'Neena', 'Kochhar', 'nkochhar@gmail.com', '515-1234568', '1987-06-18', 18500, 0, 200, 'ST_CLERK', 20);
INSERT INTO employees VALUES (102, 'Lex', 'De Haan', 'ldehaan@gmail.com', '515-1234569', '1987-06-19', 26000, 0, 201, 'MK_REP', 30);
INSERT INTO employees VALUES (103, 'Alexander', 'Hunold', 'ahunold@gmail.com', '590-4234567', '1987-06-20', 23500, 0, 200, 'MK_REP', 30);

SELECT * FROM employees;

CREATE TABLE job_history (
	start_date DATE PRIMARY KEY,
    end_date DATE,
    employee_id BIGINT,
    FOREIGN KEY (employee_id) REFERENCES employees(employee_id),
    job_id VARCHAR(10),
    FOREIGN KEY (job_id) REFERENCES jobs(job_id),
	department_id BIGINT,
    FOREIGN KEY (department_id) REFERENCES departments(department_id)
);

INSERT INTO job_history (start_date, end_date, employee_id, job_id, department_id) VALUES
('2023-01-15', '2023-05-15', 101, 'salesman', 10),
('2023-02-20', '2023-06-20', 102, 'HR-REP', 20),
('2023-03-25', NULL, 103, 'IT_PROG', 30);

SELECT * FROM job_history;

-- 3 Write a query to find the location_id, street_address, city, state-province, country_name of locations.
SELECT location_id, street_address, city, state_province, country_name, 'locations'
FROM locations
LEFT JOIN countries ON countries.country_id = locations.country_id;

-- 4 Write a query to find the first_name, last name, department ID of all the employees.
SELECT e.first_name, e.last_name, e.department_id
FROM employees e;


/* 5 Write a query to find the first_name, last_name, job_id and department ID 
	 of the employees who works in Japan. */
SELECT e.first_name, e.last_name, e.job_id, e.department_id, c.country_id
FROM employees e
INNER JOIN departments d ON d.department_id = e.department_id
INNER JOIN locations l ON l.location_id = d.location_id
INNER JOIN countries c ON c.country_id = l.country_id
WHERE c.country_id = 'JP';

-- 6 Write a query to find the employee_id, last_name along with their manager_id and last_name.
SELECT e.employee_id, e.last_name, e.manager_id, e.manager_last_name
FROM employees e
INNER JOIN employees e ON e.manager_id = e.employee_id; 

/*7 Write a query to find the first_name, last_name and hire date of the employees 
	who was hired after employee 'Lex De Hann'.*/
SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE e.first_name = 'Lex';

-- 8 Write a query to get the department name and number of employees of each the department.
SELECT 
	d.department_name AS department, 
    COUNT(e.employee_id) AS number_of_employee
FROM departments d
LEFT JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

-- 9 Write a query to find the employee ID, job title, number of days between ending date and
	-- starting date for all jobs in department ID 30.
SELECT 
    e.employee_id,
    j.job_title,
    DATEDIFF(now(), e.hire_date)
FROM employees e
INNER JOIN jobs j ON e.job_id = j.job_id
WHERE e.department_id = 30;
    
-- 10 Write a query to display all department name, manager name, city and country name.
SELECT
	d.department_name,
    e.ifnull(manager_id, 'N/A') AS manager_name,
    l.city,
    c.country_name
FROM departments d
INNER JOIN employees e ON d.department_id = e.department_id
INNER JOIN locations l ON l.location_id = d.location_id
INNER JOIN countries c ON c.country_id = l.country_id;

-- Approach 1:
SELECT m.last_name, m.first_name, d.department_name; l.city, c.country_name
FROM employees e
	INNER JOIN employees m ON e.manger_id = m.employee_id
    INNER JOIN departments d ON d.department_id = e.department_id
	INNER JOIN locations l ON l.location_id = d.location_id
	INNER JOIN countries c ON c.country_id = l.country_id
WHERE e.manager_id is null;

-- Approach 2: CTE (sub-query) 👉 view (Book W7 Ch.9)

WITH managers AS (
	SELECT DISTINCT e.employee_id, m.last_name, m.first_name
    FROM
);
SELECT * 
FROM managers mg
	INNER JOIN
    INNER JOIN
    INNER JOIN


-- 11 Write a query to display the average salary of each department.
SELECT 
	d.department_name AS department,
    AVG(e.salary) AS average_salary
FROM departments d
JOIN employees e ON d.department_id = e.department_id
GROUP BY d.department_name;

/* 12 Now, we try to perform normalization on table 'jobs'.
a. How do you re-design the table 'jobs'? adn adding table 'job_grades'?  */



    