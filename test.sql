-- create table
CREATE TABLE student (
	student_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(20),
    major VARCHAR(20) DEFAULT = 'Undecided'
);
-- look at the table
DESCRIBE student;

-- delete a table
DROP TABLE name_of_the_table;

-- modify a table by adding a column or removig a column
ALTER TABLE student ADD gpa DECIMAL(3,2); -- 3 digits, 2 decimals
ALTER TABLE student DROP COLUMN gpa;

-- insert data into the table id, name, major in our case
INSERT INTO student VALUES ('Jack', 'Biology');

-- suppose you dont have information for the columns
INSERT INTO student(name) VALUES('Jake');

-- check whats in our table
SELECT * FROM student;

-- let update an entry, in our table in the column major every biology entry will be changed to bio

UPDATE student SET major = 'Bio' WHERE major = 'Biology';

-- maybe our student changed major from biology to mathematics

UPDATE student SET major = 'Mathematics' WHERE student_id = 1;

-- you can get a double major if you want

UPDATE student SET major = 'Biomathematics' WHERE major = 'Biology' or major = 'Mathematics';

-- for some reason our student wanted to change his name and is still deciding on what major to take

UPDATE student SET name = 'Tom', major = 'Undecided' WHERE student_id = 1;

-- for some reason student with student_id = 2 decided to change university

DELETE FROM student WHERE student_id = 2;

-- lets see what our students are studying

SELECT name, major FROM student;

-- do we need these in a specific order?

SELECT name, major FROM student ORDER BY name; -- by defaul they appear by alphabetical order. passing in DESC (ASC) we get this order reversed

-- maybe we to keep it simple we just order them by their id

SELECT name, major FROM student ORDER BY student_id;

-- lets see the names of the students who enrolled in mathematics and computer science majors

SELECT name FROM student WHERE major IN ('Mathematics', 'Computer Science');

 





