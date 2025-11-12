-- ============================================================================
-- SQL Database Operations - Customer and Employee Tables
-- This script demonstrates all SQL operations: DDL, DML, DCL, TCL, JOINs, and Set Operations
-- ============================================================================

-- ============================================================================
-- DDL COMMANDS (Data Definition Language)
-- ============================================================================

-- ==================== CREATE ====================
-- Create Customer table
CREATE TABLE Customer (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    city VARCHAR(50),
    country VARCHAR(50) DEFAULT 'USA',
    registration_date DATE,
    status VARCHAR(20) DEFAULT 'Active'
);

-- Create Employee table
CREATE TABLE Employee (
    employee_id INT PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    phone VARCHAR(20),
    department VARCHAR(50),
    position VARCHAR(50),
    salary DECIMAL(10, 2),
    hire_date DATE,
    manager_id INT,
    status VARCHAR(20) DEFAULT 'Active'
);

-- Create a relationship table to demonstrate joins
-- Employee can be assigned to customers
CREATE TABLE Customer_Employee (
    customer_id INT,
    employee_id INT,
    assignment_date DATE,
    PRIMARY KEY (customer_id, employee_id),
    FOREIGN KEY (customer_id) REFERENCES Customer(customer_id),
    FOREIGN KEY (employee_id) REFERENCES Employee(employee_id)
);

-- ==================== ALTER ====================
-- Add a new column to Customer table
ALTER TABLE Customer ADD COLUMN age INT;

-- Modify existing column in Customer table
ALTER TABLE Customer MODIFY COLUMN customer_name VARCHAR(150);

-- Add a new column to Employee table
ALTER TABLE Employee ADD COLUMN bonus DECIMAL(10, 2) DEFAULT 0;

-- Add a constraint to Employee table
ALTER TABLE Employee ADD CONSTRAINT chk_salary CHECK (salary > 0);

-- Add foreign key constraint (self-referencing for manager)
ALTER TABLE Employee ADD CONSTRAINT fk_manager 
    FOREIGN KEY (manager_id) REFERENCES Employee(employee_id);

-- Rename a column (MySQL syntax)
-- ALTER TABLE Customer CHANGE COLUMN age customer_age INT;

-- Rename a column (PostgreSQL syntax)
-- ALTER TABLE Customer RENAME COLUMN age TO customer_age;

-- Drop a column
-- ALTER TABLE Customer DROP COLUMN age;

-- ==================== TRUNCATE ====================
-- Truncate table (removes all data but keeps structure)
-- TRUNCATE TABLE Customer_Employee;
-- Note: Truncate cannot be used if table has foreign key constraints in some databases

-- ==================== DROP ====================
-- Drop a table (commented out to prevent accidental deletion)
-- DROP TABLE Customer_Employee;
-- DROP TABLE Customer;
-- DROP TABLE Employee;

-- ============================================================================
-- DML COMMANDS (Data Manipulation Language)
-- ============================================================================

-- ==================== INSERT ====================
-- Insert data into Customer table
INSERT INTO Customer (customer_id, customer_name, email, phone, city, country, registration_date, status, age) VALUES
(1, 'John Smith', 'john.smith@email.com', '555-0101', 'New York', 'USA', '2023-01-15', 'Active', 35),
(2, 'Jane Doe', 'jane.doe@email.com', '555-0102', 'Los Angeles', 'USA', '2023-02-20', 'Active', 28),
(3, 'Bob Johnson', 'bob.johnson@email.com', '555-0103', 'Chicago', 'USA', '2023-03-10', 'Active', 42),
(4, 'Alice Williams', 'alice.williams@email.com', '555-0104', 'Houston', 'USA', '2023-04-05', 'Active', 31),
(5, 'Charlie Brown', 'charlie.brown@email.com', '555-0105', 'Phoenix', 'USA', '2023-05-12', 'Inactive', 29),
(6, 'Diana Prince', 'diana.prince@email.com', '555-0106', 'Philadelphia', 'USA', '2023-06-18', 'Active', 26),
(7, 'Edward Norton', 'edward.norton@email.com', '555-0107', 'San Antonio', 'USA', '2023-07-22', 'Active', 38);

-- Insert data into Employee table
INSERT INTO Employee (employee_id, employee_name, email, phone, department, position, salary, hire_date, manager_id, status, bonus) VALUES
(101, 'Sarah Connor', 'sarah.connor@company.com', '555-1001', 'Sales', 'Sales Manager', 75000.00, '2022-01-10', NULL, 'Active', 5000.00),
(102, 'Mike Tyson', 'mike.tyson@company.com', '555-1002', 'Sales', 'Sales Representative', 50000.00, '2022-03-15', 101, 'Active', 3000.00),
(103, 'Lisa Anderson', 'lisa.anderson@company.com', '555-1003', 'Support', 'Support Manager', 70000.00, '2022-02-01', NULL, 'Active', 4000.00),
(104, 'Tom Hanks', 'tom.hanks@company.com', '555-1004', 'Support', 'Support Specialist', 45000.00, '2022-04-20', 103, 'Active', 2000.00),
(105, 'Emma Watson', 'emma.watson@company.com', '555-1005', 'Marketing', 'Marketing Manager', 72000.00, '2022-01-25', NULL, 'Active', 4500.00),
(106, 'Chris Evans', 'chris.evans@company.com', '555-1006', 'Sales', 'Sales Representative', 52000.00, '2022-05-10', 101, 'Active', 3200.00),
(107, 'Natalie Portman', 'natalie.portman@company.com', '555-1007', 'HR', 'HR Manager', 68000.00, '2022-02-15', NULL, 'Active', 3500.00);

-- Insert data into Customer_Employee relationship table
INSERT INTO Customer_Employee (customer_id, employee_id, assignment_date) VALUES
(1, 102, '2023-01-16'),
(2, 102, '2023-02-21'),
(3, 106, '2023-03-11'),
(4, 102, '2023-04-06'),
(5, 106, '2023-05-13'),
(6, 104, '2023-06-19'),
(7, 104, '2023-07-23'),
(1, 104, '2023-08-01');

-- ==================== SELECT ====================
-- Select all columns from Customer table
SELECT * FROM Customer;

-- Select specific columns
SELECT customer_id, customer_name, email, city FROM Customer;

-- Select with WHERE clause
SELECT * FROM Customer WHERE status = 'Active';
SELECT * FROM Customer WHERE age > 30;
SELECT * FROM Customer WHERE city IN ('New York', 'Los Angeles', 'Chicago');

-- Select with ORDER BY
SELECT * FROM Customer ORDER BY registration_date DESC;
SELECT * FROM Customer ORDER BY customer_name ASC;

-- Select with GROUP BY and aggregate functions
SELECT city, COUNT(*) AS customer_count FROM Customer GROUP BY city;
SELECT status, COUNT(*) AS count FROM Customer GROUP BY status;

-- Select with HAVING clause
SELECT city, COUNT(*) AS customer_count 
FROM Customer 
GROUP BY city 
HAVING COUNT(*) > 1;

-- Select with LIMIT (MySQL/PostgreSQL)
SELECT * FROM Customer LIMIT 5;
SELECT * FROM Customer ORDER BY customer_id LIMIT 3 OFFSET 2;

-- Select all columns from Employee table
SELECT * FROM Employee;

-- Select employees with their managers (self-join)
SELECT e.employee_name AS employee, m.employee_name AS manager
FROM Employee e
LEFT JOIN Employee m ON e.manager_id = m.employee_id;

-- ==================== UPDATE ====================
-- Update a single record
UPDATE Customer SET city = 'San Francisco' WHERE customer_id = 1;

-- Update multiple records
UPDATE Customer SET status = 'Active' WHERE status = 'Inactive';

-- Update with calculation
UPDATE Employee SET bonus = bonus + 1000 WHERE department = 'Sales';

-- Update salary for specific employee
UPDATE Employee SET salary = 55000.00 WHERE employee_id = 102;

-- ==================== DELETE ====================
-- Delete a specific record
-- DELETE FROM Customer WHERE customer_id = 5;

-- Delete records based on condition
-- DELETE FROM Customer WHERE status = 'Inactive';

-- Delete all records (use with caution!)
-- DELETE FROM Customer;

-- ============================================================================
-- DCL COMMANDS (Data Control Language)
-- ============================================================================

-- ==================== GRANT ====================
-- Grant SELECT permission on Customer table to a user
-- GRANT SELECT ON Customer TO 'username'@'localhost';

-- Grant multiple permissions
-- GRANT SELECT, INSERT, UPDATE ON Customer TO 'username'@'localhost';

-- Grant all permissions
-- GRANT ALL PRIVILEGES ON Customer TO 'username'@'localhost';

-- Grant permissions on all tables in database
-- GRANT SELECT ON database_name.* TO 'username'@'localhost';

-- Grant with option to grant to others
-- GRANT SELECT ON Customer TO 'username'@'localhost' WITH GRANT OPTION;

-- ==================== REVOKE ====================
-- Revoke SELECT permission
-- REVOKE SELECT ON Customer FROM 'username'@'localhost';

-- Revoke multiple permissions
-- REVOKE SELECT, INSERT, UPDATE ON Customer FROM 'username'@'localhost';

-- Revoke all permissions
-- REVOKE ALL PRIVILEGES ON Customer FROM 'username'@'localhost';

-- ============================================================================
-- TCL COMMANDS (Transaction Control Language)
-- ============================================================================

-- ==================== COMMIT ====================
-- Start a transaction and commit
START TRANSACTION;
INSERT INTO Customer (customer_id, customer_name, email, phone, city, country, registration_date, status, age) 
VALUES (8, 'Frank Miller', 'frank.miller@email.com', '555-0108', 'San Diego', 'USA', '2023-08-15', 'Active', 33);
COMMIT;

-- ==================== ROLLBACK ====================
-- Start a transaction and rollback
START TRANSACTION;
UPDATE Customer SET city = 'Boston' WHERE customer_id = 2;
-- If we want to undo the changes:
ROLLBACK;

-- ==================== SAVEPOINT ====================
-- Create savepoints and rollback to specific savepoint
START TRANSACTION;

INSERT INTO Customer (customer_id, customer_name, email, phone, city, country, registration_date, status, age) 
VALUES (9, 'Grace Kelly', 'grace.kelly@email.com', '555-0109', 'Miami', 'USA', '2023-09-01', 'Active', 27);

SAVEPOINT sp1;

UPDATE Customer SET city = 'Seattle' WHERE customer_id = 3;
UPDATE Customer SET city = 'Portland' WHERE customer_id = 4;

SAVEPOINT sp2;

DELETE FROM Customer WHERE customer_id = 5;

-- Rollback to savepoint sp2 (undoes the DELETE)
ROLLBACK TO SAVEPOINT sp2;

-- Rollback to savepoint sp1 (undoes the UPDATEs and DELETE)
-- ROLLBACK TO SAVEPOINT sp1;

-- Commit the transaction (keeps the INSERT)
COMMIT;

-- ============================================================================
-- JOIN OPERATIONS
-- ============================================================================

-- ==================== INNER JOIN ====================
-- Get customers with their assigned employees
SELECT 
    c.customer_id,
    c.customer_name,
    e.employee_id,
    e.employee_name,
    e.department,
    ce.assignment_date
FROM Customer c
INNER JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
INNER JOIN Employee e ON ce.employee_id = e.employee_id;

-- ==================== LEFT JOIN (LEFT OUTER JOIN) ====================
-- Get all customers and their assigned employees (if any)
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    e.employee_id,
    e.employee_name,
    e.department
FROM Customer c
LEFT JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
LEFT JOIN Employee e ON ce.employee_id = e.employee_id;

-- ==================== RIGHT JOIN (RIGHT OUTER JOIN) ====================
-- Get all employees and their assigned customers (if any)
SELECT 
    e.employee_id,
    e.employee_name,
    e.department,
    c.customer_id,
    c.customer_name,
    c.city
FROM Customer c
RIGHT JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
RIGHT JOIN Employee e ON ce.employee_id = e.employee_id;

-- ==================== FULL OUTER JOIN ====================
-- Note: MySQL doesn't support FULL OUTER JOIN directly, so we use UNION
-- Get all customers and employees with their relationships
SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    e.employee_id,
    e.employee_name,
    e.department
FROM Customer c
LEFT JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
LEFT JOIN Employee e ON ce.employee_id = e.employee_id

UNION

SELECT 
    c.customer_id,
    c.customer_name,
    c.city,
    e.employee_id,
    e.employee_name,
    e.department
FROM Customer c
RIGHT JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
RIGHT JOIN Employee e ON ce.employee_id = e.employee_id
WHERE c.customer_id IS NULL;

-- For PostgreSQL/Oracle (which support FULL OUTER JOIN):
-- SELECT 
--     c.customer_id,
--     c.customer_name,
--     c.city,
--     e.employee_id,
--     e.employee_name,
--     e.department
-- FROM Customer c
-- FULL OUTER JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
-- FULL OUTER JOIN Employee e ON ce.employee_id = e.employee_id;

-- ==================== CROSS JOIN (Cartesian Product) ====================
-- Get all possible combinations of customers and employees
SELECT 
    c.customer_name,
    e.employee_name,
    e.department
FROM Customer c
CROSS JOIN Employee e;

-- ==================== SELF JOIN ====================
-- Get employees with their managers
SELECT 
    e.employee_id,
    e.employee_name AS employee,
    e.department,
    m.employee_id AS manager_id,
    m.employee_name AS manager_name,
    m.department AS manager_department
FROM Employee e
LEFT JOIN Employee m ON e.manager_id = m.employee_id;

-- ============================================================================
-- SET OPERATIONS
-- ============================================================================

-- For set operations, we need compatible columns
-- Let's create views or use compatible column selections

-- ==================== UNION ====================
-- Get unique names from both Customer and Employee tables
SELECT customer_name AS name, 'Customer' AS type FROM Customer
UNION
SELECT employee_name AS name, 'Employee' AS type FROM Employee
ORDER BY name;

-- ==================== UNION ALL ====================
-- Get all names from both Customer and Employee tables (including duplicates)
SELECT customer_name AS name, 'Customer' AS type FROM Customer
UNION ALL
SELECT employee_name AS name, 'Employee' AS type FROM Employee
ORDER BY name;

-- ==================== INTERSECT ====================
-- Note: MySQL doesn't support INTERSECT directly
-- Get names that exist in both Customer and Employee tables
-- For MySQL, we use INNER JOIN or EXISTS:
SELECT DISTINCT c.customer_name AS name
FROM Customer c
WHERE EXISTS (
    SELECT 1 FROM Employee e 
    WHERE e.employee_name = c.customer_name
);

-- For PostgreSQL/Oracle (which support INTERSECT):
-- SELECT customer_name AS name FROM Customer
-- INTERSECT
-- SELECT employee_name AS name FROM Employee;

-- Alternative using INNER JOIN:
SELECT DISTINCT c.customer_name AS name
FROM Customer c
INNER JOIN Employee e ON c.customer_name = e.employee_name;

-- ==================== MINUS / EXCEPT ====================
-- Note: MySQL uses EXCEPT, Oracle uses MINUS
-- Get names that exist in Customer but not in Employee
-- For MySQL (using NOT EXISTS):
SELECT customer_name AS name
FROM Customer c
WHERE NOT EXISTS (
    SELECT 1 FROM Employee e 
    WHERE e.employee_name = c.customer_name
);

-- For MySQL 8.0+ (using EXCEPT):
-- SELECT customer_name AS name FROM Customer
-- EXCEPT
-- SELECT employee_name AS name FROM Employee;

-- For Oracle (using MINUS):
-- SELECT customer_name AS name FROM Customer
-- MINUS
-- SELECT employee_name AS name FROM Employee;

-- For PostgreSQL (using EXCEPT):
-- SELECT customer_name AS name FROM Customer
-- EXCEPT
-- SELECT employee_name AS name FROM Employee;

-- Alternative using LEFT JOIN:
SELECT c.customer_name AS name
FROM Customer c
LEFT JOIN Employee e ON c.customer_name = e.employee_name
WHERE e.employee_name IS NULL;

-- ============================================================================
-- ADDITIONAL USEFUL QUERIES
-- ============================================================================

-- Get customer count by employee
SELECT 
    e.employee_name,
    e.department,
    COUNT(ce.customer_id) AS customer_count
FROM Employee e
LEFT JOIN Customer_Employee ce ON e.employee_id = ce.employee_id
GROUP BY e.employee_id, e.employee_name, e.department
ORDER BY customer_count DESC;

-- Get employees who have no customers assigned
SELECT 
    e.employee_id,
    e.employee_name,
    e.department
FROM Employee e
LEFT JOIN Customer_Employee ce ON e.employee_id = ce.employee_id
WHERE ce.employee_id IS NULL;

-- Get customers who have no employees assigned
SELECT 
    c.customer_id,
    c.customer_name,
    c.city
FROM Customer c
LEFT JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
WHERE ce.customer_id IS NULL;

-- Get total salary by department
SELECT 
    department,
    COUNT(*) AS employee_count,
    SUM(salary) AS total_salary,
    AVG(salary) AS avg_salary,
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary
FROM Employee
GROUP BY department
ORDER BY total_salary DESC;

-- ============================================================================
-- END OF SCRIPT
-- ============================================================================

