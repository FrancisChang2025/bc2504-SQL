CREATE DATABASE TestingForStudy;

use TestingForStudy;

CREATE TABLE students (
	id BIGINT PRIMARY KEY,
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

DROP TABLE students;

INSERT INTO students VALUES (1, 'Lucas');
INSERT INTO students VALUES (1, 'Leo');
INSERT INTO students VALUES (3, 'Vincent');

INSERT INTO subjects VALUES (1, 'Maths');
INSERT INTO subjects VALUES (2, 'History');
INSERT INTO subjects VALUES (3, 'English');

-- Data Integrity 數據完整性
INSERT INTO subject_enrollments VALUES (1, 2, 2);
INSERT INTO subject_enrollments VALUES (2, 2, 3);
INSERT INTO subject_enrollments VALUES (3, 3, 1);

SELECT * FROM subject_enrollments;

SELECT sb.*, st.*, se.*
FROM subject_enrollments se
    INNER JOIN students st ON st.id = se.student_id
    INNER JOIN subjects sb ON sb.id = se.subject_id;
    
SELECT st.name AS student_name, sb.name AS subject_name
FROM subject_enrollments se
    INNER JOIN subjects sb ON sb.id = se.subject_id
	RIGHT JOIN students st ON st.id = se.student_id;
    
select st.name as student_name, temp_result.subject_name
from
(select sb.id, sb.name as subject_name, se.student_id, se.subject_id
from subjects sb inner join subject_enrollments se on sb.id = se.student_id) temp_result 
	right join students st on st.id = temp_result.student_id;

