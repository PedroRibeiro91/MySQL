-- lets create a database for a fictional company

-- in this table all the information on our employees will be stored
CREATE TABLE employee (
emp_id INT PRIMARY KEY,
first_name VARCHAR(40),
last_name VARCHAR(40),
birth_date DATE,
sex VARCHAR(1),
salary INT,
supervisor_id INT,
branch_id INT
);

-- in this table we will have all the information on our branches
CREATE TABLE branch(
branch_id INT PRIMARY KEY,
branch_name VARCHAR(40),
manager_id INT,
manager_start_date DATE,
FOREIGN KEY (manager_id) REFERENCES employee(emp_id) ON DELETE SET NULL
);

-- we need more referencing because we want to know in what branch each employee works 
ALTER TABLE employee ADD FOREIGN KEY(branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL;

-- we also need to know who are the supervisors for each employee
ALTER TABLE employee ADD FOREIGN KEY(supervisor_id) REFERENCES employee(emp_id) ON DELETE SET NULL;

-- in this table we have all the information on our clients
CREATE TABLE clients(
client_id INT PRIMARY KEY,
client_name VARCHAR(40),
branch_id INT,
FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE SET NULL -- we need to know what branch is supplying each client

-- in this table we have information on what employee is working with what client and how much was sold
CREATE TABLE works_with(
emp_id INT,
client_id INT,
total_sales Int,
PRIMARY KEY (emp_id, client_id), 
FOREIGN KEY (emp_id) REFERENCES employee(emp_id) ON DELETE CASCADE,
FOREIGN KEY (client_id) REFERENCES clients(client_id) ON DELETE CASCADE 
);

-- in this table we have information on our branch supplier
CREATE TABLE branch_supplier(
branch_id INT,
supplier_name VARCHAR(40),
supply_type VARCHAR(40),
PRIMARY KEY (branch_id, supplier_name),
FOREIGN KEY (branch_id) REFERENCES branch(branch_id) ON DELETE CASCADE
);

-- lets fill out tables
-- to avoid problems with primary and secondary keys lets start by branch

-- Corporate
INSERT INTO employee VALUES (100, 'David', 'Wallace', '1967-11-17', 'M', 250000, NULL, NULL); 
INSERT INTO branch VALUES(1, 'Corporate', 100, '2006-02-09');
UPDATE employee SET branch_id = 1 WHERE emp_id = 100;
INSERT INTO employee VALUES(101, 'Jenny', 'Jensen', '1961-05-11', 'F', 100000, 100, 1);

-- Stranton
INSERT INTO employee VALUES(102, 'Michael', 'Collins', '1964-01-25', 'M', 75000, 100, NULL);
INSERT INTO branch VALUES(2, 'Scranton', 102, '1992-04-04');
UPDATE employee SET branch_id = 2 WHERE emp_id = 102;
INSERT INTO employee VALUES(103, 'Angela', 'Wallace', '1967-11-17', 'F', 63000, 102, 2);
INSERT INTO employee VALUES(104, 'Kelly', 'Wallace', '1967-11-17', 'F', 50000, 102, 2);
INSERT INTO employee VALUES(105, 'Stan', 'Wallace', '1967-11-17', 'M', 69000, 102, 2);

-- Stamford
INSERT INTO employee VALUES(106, 'Josh', 'Wallace', '1967-11-17', 'M', 55000, 100, NULL);
INSERT INTO branch VALUES(3, 'Stamford', 106,'1998-02-08');
UPDATE employee SET branch_id = 3 WHERE emp_id = 106;
INSERT INTO employee VALUES(107, 'Andy', 'Wallace', '1967-11-17', 'M', 58000, 106, 3);
INSERT INTO employee VALUES(109, 'Hayley', 'Smith', '1980-12-17', 'M', 60000, 106, 3);

-- branch supplier
INSERT INTO branch_supplier VALUES(2, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'Uni-ball', 'Writhing utensils');
INSERT INTO branch_supplier VALUES(3, 'Patriot Paper', 'Paper');
INSERT INTO branch_supplier VALUES(2, 'J. T Forms and Labels', 'Custom Forms');
INSERT INTO branch_supplier VALUES(3, 'Uni-ball', 'Writing utensils');
INSERT INTO branch_supplier VALUES(3, 'Hammer Mill', 'Paper');
INSERT INTO branch_supplier VALUES(3, 'Stamford Labels', 'Custom Forms');

-- clients
INSERT INTO clients VALUES(400, 'Dunmore Highschool', 2);
INSERT INTO clients VALUES(401, 'Lackawana County', 2);
INSERT INTO clients VALUES(402, 'FedEx', 3);
INSERT INTO clients VALUES(403, 'John Daly Law', 3);
INSERT INTO clients VALUES(404, 'Scranton Whitepages', 2);
INSERT INTO clients VALUES(405, 'News Newspapers', 3);
INSERT INTO clients VALUES(406, 'FedEx', 2);


-- works_with
INSERT INTO works_with VALUES(105, 400, 55000);
INSERT INTO works_with VALUES(102, 401, 20000);
INSERT INTO works_with VALUES(109, 402, 70000);
INSERT INTO works_with VALUES(107, 403, 5000);
INSERT INTO works_with VALUES(105, 403, 15000);
INSERT INTO works_with VALUES(109, 405, 80000);
INSERT INTO works_with VALUES(107, 406, 40000);
INSERT INTO works_with VALUES(102, 406, 2000);
INSERT INTO works_with VALUES(105, 404, 58000);

-- simple queries
-- find all employees
SELECT * FROM employee;

-- find all clients
SELECT * FROM clients;

-- find all employees ordered by salary (descending order)
SELECT * FROM employee ORDER BY salary DESC;

-- find all employees ordered by sex than name
SELECT * FROM employee ORDER BY sex, first_name, last_name;

-- find the first 5 employees in the table
SELECT * FROM employee LIMIT 5;

-- find first and last name from all employees
SELECT first_name, last_name FROM employee;

-- maybe we dont like the fields first_name, last_name
SELECT first_name AS forename , last_name AS surname FROM employee;

-- find all the different genders
SELECT DISTINCT sex FROM employee;

-- find how many employees do we have
SELECT COUNT(emp_id) FROM employee;

-- find how many employees have a supervisor
SELECT COUNT(supervisor_id) FROM employee;

-- find the number of female employees born after 1960
SELECT COUNT(emp_id) FROM employee WHERE sex ='F' AND birth_date > '1960-01-01';

-- find the average of the salaries of our employees
SELECT AVG(salary) FROM employee;

-- find the average of the salaries of our employees who are male
SELECT AVG(salary) FROM employee WHERE sex = 'M';

-- find the sum of the salaries of our employees
SELECT SUM(salary) FROM employee;

-- find how many male and female we have in our company
SELECT COUNT(sex), sex FROM employee GROUP BY sex;

-- find the total sales of each salesman
SELECT SUM(total_sales), emp_id FROM works_with GROUP BY emp_id;

-- find how much each client spent
SELECT SUM(total_sales), client_id FROM works_with GROUP BY client_id;


-- WILDCARDS
-- find all the clients that work with the Law
-- % means we dont care about prefix or sufix size
-- _ means prefix size = 1
SELECT * FROM clients WHERE client_name LIKE '%Law';

-- find the branch suppliers that work in the label business
SELECT * FROM branch_supplier WHERE supplier_name LIKE '% label%';

-- find the employees that were born in May
SELECT * FROM employee WHERE birth_date LIKE '____-05%';

-- find clients that are schools
SELECT * FROM clients WHERE client_name LIKE '%chool%'; 

-- UNION (can only be used when the same number of columns is selected and must be the same data type
-- find the list of the name of the employee and the branches
SELECT first_name FROM employee UNION SELECT branch_name FROM branch;

-- find the list of clients and suppliers with the respective branch_id
SELECT client_name, clients.branch_id FROM clients UNION SELECT supplier_name, branch_supplier.branch_id FROM branch_supplier; 

-- find the list of the money spent or earned by the company
SELECT salary FROM employee UNION SELECT total_sales FROM works_with;

-- Joins
-- first lets add another entry to our branch table
INSERT INTO branch VALUES(4, 'Buffalo', NULL, NULL);

-- find all branches and the name of their managers
SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name 
FROM employee
JOIN branch
ON employee.emp_id = branch.manager_id;
-- we joined the table employee and the table brand on the entries with matching emp_id and manager_id

-- this will show all the employees no matter if they are manager or not
SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name 
FROM employee
LEFT JOIN branch
ON employee.emp_id = branch.manager_id;  

-- this will show all the branches no matter if they have a manager or not
SELECT employee.emp_id, employee.first_name, employee.last_name, branch.branch_name 
FROM employee
RIGHT JOIN branch
ON employee.emp_id = branch.manager_id;


-- lets make it more complicated
-- find the name of the employees who sold over 30000 to a single client
-- first lets select those who sold over 30000 from the table works_with
-- SELECT works_with.emp_id FROM works_with WHERE works_with.total_sales > 30000;
SELECT employee.first_name, employee.last_name FROM employee WHERE emp_id IN (
	SELECT works_with.emp_id 
	FROM works_with 
	WHERE works_with.total_sales > 30000
);
-- find all clients who were handled by the branch that Michael Collins manages 
-- we know Michael Collins id is 102
SELECT clients.client_name FROM clients WHERE clients.branch_id = (
	SELECT branch.branch_id 
    FROM branch 
    WHERE branch.manager_id = 102);

-- if we dont know michaels id then this is the query
SELECT clients.client_name FROM clients WHERE clients.branch_id IN(
	SELECT branch.branch_id FROM branch WHERE branch.manager_id IN (
		SELECT employee.emp_id 
		FROM employee 
		WHERE employee.first_name = 'Michael' AND employee.last_name = 'Collins'
));




