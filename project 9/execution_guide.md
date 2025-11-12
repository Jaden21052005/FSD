# SQL Database Operations - Execution Guide

This guide provides step-by-step instructions for executing the SQL operations.

## Step 1: Database Setup

### For MySQL:
```sql
CREATE DATABASE company_db;
USE company_db;
```

### For PostgreSQL:
```sql
CREATE DATABASE company_db;
\c company_db
```

### For Oracle:
```sql
CREATE DATABASE company_db;
-- Connect to the database
```

## Step 2: Create Tables (DDL - CREATE)

Execute the CREATE TABLE statements from the main SQL file:
1. Create Customer table
2. Create Employee table
3. Create Customer_Employee relationship table

**Expected Output**: Tables created successfully

## Step 3: Insert Sample Data (DML - INSERT)

Execute the INSERT statements:
1. Insert 7 customers
2. Insert 7 employees
3. Insert customer-employee relationships

**Expected Output**: 
- 7 rows inserted into Customer
- 7 rows inserted into Employee
- 8 rows inserted into Customer_Employee

## Step 4: Query Data (DML - SELECT)

### Basic SELECT
```sql
SELECT * FROM Customer;
```
**Expected**: 7 customer records

### SELECT with WHERE
```sql
SELECT * FROM Customer WHERE status = 'Active';
```
**Expected**: 6 active customers (assuming one is inactive)

### SELECT with JOIN
```sql
SELECT c.customer_name, e.employee_name 
FROM Customer c
INNER JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
INNER JOIN Employee e ON ce.employee_id = e.employee_id;
```
**Expected**: Customer-employee pairs

## Step 5: Modify Tables (DDL - ALTER)

### Add Column
```sql
ALTER TABLE Customer ADD COLUMN age INT;
```
**Expected**: Column added successfully

### Modify Column
```sql
ALTER TABLE Customer MODIFY COLUMN customer_name VARCHAR(150);
```
**Expected**: Column modified successfully

## Step 6: Update Data (DML - UPDATE)

```sql
UPDATE Customer SET city = 'San Francisco' WHERE customer_id = 1;
```
**Expected**: 1 row updated

```sql
SELECT city FROM Customer WHERE customer_id = 1;
```
**Expected**: San Francisco

## Step 7: Test Transactions (TCL)

### Test COMMIT
```sql
START TRANSACTION;
INSERT INTO Customer (customer_id, customer_name, email, phone, city, country, registration_date, status, age) 
VALUES (8, 'Frank Miller', 'frank.miller@email.com', '555-0108', 'San Diego', 'USA', '2023-08-15', 'Active', 33);
COMMIT;
```
**Expected**: New customer added and committed

### Test ROLLBACK
```sql
START TRANSACTION;
UPDATE Customer SET city = 'Boston' WHERE customer_id = 2;
SELECT city FROM Customer WHERE customer_id = 2;  -- Should show Boston
ROLLBACK;
SELECT city FROM Customer WHERE customer_id = 2;  -- Should show original city
```
**Expected**: Changes rolled back

### Test SAVEPOINT
```sql
START TRANSACTION;
INSERT INTO Customer (customer_id, customer_name, email, phone, city, country, registration_date, status, age) 
VALUES (9, 'Grace Kelly', 'grace.kelly@email.com', '555-0109', 'Miami', 'USA', '2023-09-01', 'Active', 27);
SAVEPOINT sp1;
UPDATE Customer SET city = 'Seattle' WHERE customer_id = 3;
ROLLBACK TO SAVEPOINT sp1;
COMMIT;
```
**Expected**: INSERT committed, UPDATE rolled back

## Step 8: Test JOIN Operations

### INNER JOIN
```sql
SELECT c.customer_name, e.employee_name, e.department
FROM Customer c
INNER JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
INNER JOIN Employee e ON ce.employee_id = e.employee_id;
```
**Expected**: Only customers with assigned employees

### LEFT JOIN
```sql
SELECT c.customer_name, e.employee_name
FROM Customer c
LEFT JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
LEFT JOIN Employee e ON ce.employee_id = e.employee_id;
```
**Expected**: All customers, with NULL for employees if not assigned

### RIGHT JOIN
```sql
SELECT e.employee_name, c.customer_name
FROM Customer c
RIGHT JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
RIGHT JOIN Employee e ON ce.employee_id = e.employee_id;
```
**Expected**: All employees, with NULL for customers if not assigned

### FULL OUTER JOIN (MySQL workaround)
```sql
SELECT c.customer_name, e.employee_name
FROM Customer c
LEFT JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
LEFT JOIN Employee e ON ce.employee_id = e.employee_id
UNION
SELECT c.customer_name, e.employee_name
FROM Customer c
RIGHT JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
RIGHT JOIN Employee e ON ce.employee_id = e.employee_id
WHERE c.customer_id IS NULL;
```
**Expected**: All customers and employees

## Step 9: Test Set Operations

### UNION
```sql
SELECT customer_name AS name FROM Customer
UNION
SELECT employee_name AS name FROM Employee;
```
**Expected**: Unique names from both tables

### UNION ALL
```sql
SELECT customer_name AS name FROM Customer
UNION ALL
SELECT employee_name AS name FROM Employee;
```
**Expected**: All names from both tables (may include duplicates if any)

### INTERSECT (MySQL alternative)
```sql
SELECT DISTINCT c.customer_name AS name
FROM Customer c
WHERE EXISTS (
    SELECT 1 FROM Employee e 
    WHERE e.employee_name = c.customer_name
);
```
**Expected**: Names that exist in both tables (if any)

### MINUS/EXCEPT (MySQL alternative)
```sql
SELECT c.customer_name AS name
FROM Customer c
WHERE NOT EXISTS (
    SELECT 1 FROM Employee e 
    WHERE e.employee_name = c.customer_name
);
```
**Expected**: Names in Customer but not in Employee

## Step 10: Test DELETE (DML)

**⚠️ Warning**: Be careful with DELETE statements

```sql
-- Delete specific record
DELETE FROM Customer WHERE customer_id = 5;
```
**Expected**: 1 row deleted

## Step 11: Test TRUNCATE (DDL)

**⚠️ Warning**: TRUNCATE removes all data

```sql
-- Only if you want to clear the relationship table
-- TRUNCATE TABLE Customer_Employee;
```

## Step 12: Test DROP (DDL)

**⚠️ Warning**: DROP removes the entire table

```sql
-- Only if you want to remove tables
-- DROP TABLE Customer_Employee;
-- DROP TABLE Customer;
-- DROP TABLE Employee;
```

## Step 13: Test DCL Commands (Optional)

**Note**: DCL commands require appropriate privileges

### GRANT (requires admin privileges)
```sql
-- Create a test user first (MySQL)
-- CREATE USER 'testuser'@'localhost' IDENTIFIED BY 'password';

-- Grant privileges
-- GRANT SELECT ON Customer TO 'testuser'@'localhost';
```

### REVOKE (requires admin privileges)
```sql
-- Revoke privileges
-- REVOKE SELECT ON Customer FROM 'testuser'@'localhost';
```

## Verification Queries

### Check table structures
```sql
DESCRIBE Customer;
DESCRIBE Employee;
DESCRIBE Customer_Employee;
```

### Check record counts
```sql
SELECT COUNT(*) AS customer_count FROM Customer;
SELECT COUNT(*) AS employee_count FROM Employee;
SELECT COUNT(*) AS relationship_count FROM Customer_Employee;
```

### Check data integrity
```sql
-- Customers with assigned employees
SELECT c.customer_name, COUNT(ce.employee_id) AS employee_count
FROM Customer c
LEFT JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
GROUP BY c.customer_id, c.customer_name;
```

## Troubleshooting

### Common Issues

1. **Foreign Key Constraint Errors**
   - Solution: Delete child records before parent records
   - Or: Drop foreign key constraints before deleting

2. **Duplicate Key Errors**
   - Solution: Check for existing records before inserting
   - Or: Use INSERT IGNORE or ON DUPLICATE KEY UPDATE

3. **Transaction Errors**
   - Solution: Ensure you COMMIT or ROLLBACK transactions
   - Check autocommit settings: `SELECT @@autocommit;`

4. **Permission Errors (DCL)**
   - Solution: Ensure you have appropriate privileges
   - Contact database administrator for GRANT/REVOKE operations

## Next Steps

1. Experiment with different WHERE conditions
2. Try complex JOINs with multiple tables
3. Practice with aggregate functions and GROUP BY
4. Create views for frequently used queries
5. Add indexes for better performance
6. Create stored procedures for complex operations

## Additional Practice

### Exercise 1: Find employees without customers
```sql
SELECT e.employee_name, e.department
FROM Employee e
LEFT JOIN Customer_Employee ce ON e.employee_id = ce.employee_id
WHERE ce.employee_id IS NULL;
```

### Exercise 2: Find customers without employees
```sql
SELECT c.customer_name, c.city
FROM Customer c
LEFT JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
WHERE ce.customer_id IS NULL;
```

### Exercise 3: Department salary statistics
```sql
SELECT 
    department,
    COUNT(*) AS employee_count,
    AVG(salary) AS avg_salary,
    MAX(salary) AS max_salary,
    MIN(salary) AS min_salary
FROM Employee
GROUP BY department;
```

### Exercise 4: Customer assignment summary
```sql
SELECT 
    e.employee_name,
    e.department,
    COUNT(ce.customer_id) AS customer_count
FROM Employee e
LEFT JOIN Customer_Employee ce ON e.employee_id = ce.employee_id
GROUP BY e.employee_id, e.employee_name, e.department
ORDER BY customer_count DESC;
```

