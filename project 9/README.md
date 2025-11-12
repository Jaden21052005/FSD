# SQL Database Operations Project

This project demonstrates comprehensive SQL operations on two tables: **Customer** and **Employee**. It covers all major SQL command categories and advanced operations.

## Tables Structure

### Customer Table
- `customer_id` (INT, PRIMARY KEY)
- `customer_name` (VARCHAR)
- `email` (VARCHAR, UNIQUE)
- `phone` (VARCHAR)
- `city` (VARCHAR)
- `country` (VARCHAR)
- `registration_date` (DATE)
- `status` (VARCHAR)
- `age` (INT)

### Employee Table
- `employee_id` (INT, PRIMARY KEY)
- `employee_name` (VARCHAR)
- `email` (VARCHAR, UNIQUE)
- `phone` (VARCHAR)
- `department` (VARCHAR)
- `position` (VARCHAR)
- `salary` (DECIMAL)
- `hire_date` (DATE)
- `manager_id` (INT, FOREIGN KEY)
- `status` (VARCHAR)
- `bonus` (DECIMAL)

### Customer_Employee Table (Relationship Table)
- `customer_id` (INT, FOREIGN KEY)
- `employee_id` (INT, FOREIGN KEY)
- `assignment_date` (DATE)
- PRIMARY KEY (customer_id, employee_id)

## SQL Operations Covered

### 1. DDL Commands (Data Definition Language)
- **CREATE**: Create tables with constraints
- **ALTER**: Modify table structure (add column, modify column, add constraints)
- **DROP**: Remove tables
- **TRUNCATE**: Remove all data from tables

### 2. DML Commands (Data Manipulation Language)
- **SELECT**: Query data with various clauses (WHERE, ORDER BY, GROUP BY, HAVING)
- **INSERT**: Add new records
- **UPDATE**: Modify existing records
- **DELETE**: Remove records

### 3. DCL Commands (Data Control Language)
- **GRANT**: Give permissions to users
- **REVOKE**: Remove permissions from users

### 4. TCL Commands (Transaction Control Language)
- **COMMIT**: Save transaction changes
- **ROLLBACK**: Undo transaction changes
- **SAVEPOINT**: Create checkpoints within transactions

### 5. JOIN Operations
- **INNER JOIN**: Returns matching records from both tables
- **LEFT JOIN**: Returns all records from left table and matching from right
- **RIGHT JOIN**: Returns all records from right table and matching from left
- **FULL OUTER JOIN**: Returns all records from both tables (with UNION workaround for MySQL)
- **CROSS JOIN**: Returns Cartesian product of both tables
- **SELF JOIN**: Join a table with itself

### 6. Set Operations
- **UNION**: Combine results and remove duplicates
- **UNION ALL**: Combine results including duplicates
- **INTERSECT**: Return common records (with alternatives for MySQL)
- **MINUS/EXCEPT**: Return records in first query but not in second

## How to Use

### Prerequisites
- MySQL, PostgreSQL, Oracle, or any SQL database system
- Database management tool (MySQL Workbench, pgAdmin, SQL Developer, etc.)

### Steps to Execute

1. **Create a Database**:
   ```sql
   CREATE DATABASE company_db;
   USE company_db;  -- MySQL
   -- or
   -- \c company_db  -- PostgreSQL
   ```

2. **Run the SQL Script**:
   - Open `sql_database_operations.sql` in your database management tool
   - Execute the script section by section or all at once
   - Note: Some DCL commands require appropriate user privileges

3. **Test the Operations**:
   - Execute queries section by section to understand each operation
   - Modify the queries to experiment with different scenarios

## Database-Specific Notes

### MySQL
- Uses `LIMIT` for result limiting
- Doesn't support `FULL OUTER JOIN` directly (use UNION)
- Doesn't support `INTERSECT` directly (use alternatives provided)
- Uses `EXCEPT` (MySQL 8.0+) instead of `MINUS`

### PostgreSQL
- Uses `LIMIT` and `OFFSET` for result limiting
- Supports `FULL OUTER JOIN`
- Supports `INTERSECT`
- Uses `EXCEPT` instead of `MINUS`

### Oracle
- Uses `ROWNUM` or `FETCH FIRST` for result limiting
- Supports `FULL OUTER JOIN`
- Supports `INTERSECT`
- Uses `MINUS` instead of `EXCEPT`

## Sample Queries

### Basic SELECT with JOIN
```sql
SELECT 
    c.customer_name,
    e.employee_name,
    e.department
FROM Customer c
INNER JOIN Customer_Employee ce ON c.customer_id = ce.customer_id
INNER JOIN Employee e ON ce.employee_id = e.employee_id;
```

### Transaction with Savepoint
```sql
START TRANSACTION;
INSERT INTO Customer VALUES (...);
SAVEPOINT sp1;
UPDATE Customer SET ...;
ROLLBACK TO SAVEPOINT sp1;
COMMIT;
```

### Set Operations
```sql
-- UNION
SELECT customer_name AS name FROM Customer
UNION
SELECT employee_name AS name FROM Employee;
```

## Important Notes

1. **DCL Commands**: GRANT and REVOKE commands are commented out as they require database administrator privileges and specific user accounts.

2. **DROP/TRUNCATE**: These commands are commented out to prevent accidental data loss. Uncomment only when needed.

3. **Transactions**: Always test transactions in a safe environment. Use ROLLBACK to undo changes during testing.

4. **Foreign Keys**: The script includes foreign key constraints. Make sure to delete child records before deleting parent records.

5. **Database Compatibility**: Some syntax may vary between database systems. Check the database-specific notes section.

## Additional Resources

- [SQL Tutorial](https://www.w3schools.com/sql/)
- [MySQL Documentation](https://dev.mysql.com/doc/)
- [PostgreSQL Documentation](https://www.postgresql.org/docs/)
- [Oracle Documentation](https://docs.oracle.com/en/database/)

## Author

Created as part of FSD (Full Stack Development) Projects

## License

This project is for educational purposes.

