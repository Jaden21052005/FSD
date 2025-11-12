# SQL Quick Reference Guide

## DDL Commands

### CREATE
```sql
CREATE TABLE table_name (
    column1 datatype constraints,
    column2 datatype constraints,
    ...
);
```

### ALTER
```sql
-- Add column
ALTER TABLE table_name ADD COLUMN column_name datatype;

-- Modify column
ALTER TABLE table_name MODIFY COLUMN column_name new_datatype;

-- Add constraint
ALTER TABLE table_name ADD CONSTRAINT constraint_name CHECK (condition);

-- Drop column
ALTER TABLE table_name DROP COLUMN column_name;
```

### DROP
```sql
DROP TABLE table_name;
```

### TRUNCATE
```sql
TRUNCATE TABLE table_name;
```

## DML Commands

### SELECT
```sql
SELECT column1, column2 FROM table_name WHERE condition;
SELECT * FROM table_name ORDER BY column_name;
SELECT column, COUNT(*) FROM table_name GROUP BY column;
```

### INSERT
```sql
INSERT INTO table_name (column1, column2) VALUES (value1, value2);
INSERT INTO table_name VALUES (value1, value2, ...);
```

### UPDATE
```sql
UPDATE table_name SET column1 = value1 WHERE condition;
```

### DELETE
```sql
DELETE FROM table_name WHERE condition;
```

## DCL Commands

### GRANT
```sql
GRANT privilege ON table_name TO user;
GRANT SELECT, INSERT ON table_name TO user;
GRANT ALL PRIVILEGES ON database_name.* TO user;
```

### REVOKE
```sql
REVOKE privilege ON table_name FROM user;
REVOKE ALL PRIVILEGES ON table_name FROM user;
```

## TCL Commands

### COMMIT
```sql
START TRANSACTION;
-- SQL statements
COMMIT;
```

### ROLLBACK
```sql
START TRANSACTION;
-- SQL statements
ROLLBACK;
```

### SAVEPOINT
```sql
START TRANSACTION;
-- SQL statements
SAVEPOINT savepoint_name;
-- More SQL statements
ROLLBACK TO SAVEPOINT savepoint_name;
COMMIT;
```

## JOIN Operations

### INNER JOIN
```sql
SELECT * FROM table1
INNER JOIN table2 ON table1.id = table2.id;
```

### LEFT JOIN
```sql
SELECT * FROM table1
LEFT JOIN table2 ON table1.id = table2.id;
```

### RIGHT JOIN
```sql
SELECT * FROM table1
RIGHT JOIN table2 ON table1.id = table2.id;
```

### FULL OUTER JOIN
```sql
-- PostgreSQL/Oracle
SELECT * FROM table1
FULL OUTER JOIN table2 ON table1.id = table2.id;

-- MySQL (using UNION)
SELECT * FROM table1 LEFT JOIN table2 ON table1.id = table2.id
UNION
SELECT * FROM table1 RIGHT JOIN table2 ON table1.id = table2.id;
```

### CROSS JOIN
```sql
SELECT * FROM table1 CROSS JOIN table2;
```

## Set Operations

### UNION
```sql
SELECT column FROM table1
UNION
SELECT column FROM table2;
```

### UNION ALL
```sql
SELECT column FROM table1
UNION ALL
SELECT column FROM table2;
```

### INTERSECT
```sql
-- PostgreSQL/Oracle
SELECT column FROM table1
INTERSECT
SELECT column FROM table2;

-- MySQL (alternative)
SELECT DISTINCT t1.column FROM table1 t1
WHERE EXISTS (SELECT 1 FROM table2 t2 WHERE t2.column = t1.column);
```

### MINUS/EXCEPT
```sql
-- Oracle
SELECT column FROM table1
MINUS
SELECT column FROM table2;

-- PostgreSQL/MySQL 8.0+
SELECT column FROM table1
EXCEPT
SELECT column FROM table2;

-- MySQL (alternative)
SELECT column FROM table1
WHERE column NOT IN (SELECT column FROM table2);
```

## Common SQL Clauses

### WHERE
```sql
SELECT * FROM table_name WHERE condition;
```

### ORDER BY
```sql
SELECT * FROM table_name ORDER BY column_name ASC;
SELECT * FROM table_name ORDER BY column_name DESC;
```

### GROUP BY
```sql
SELECT column, COUNT(*) FROM table_name GROUP BY column;
```

### HAVING
```sql
SELECT column, COUNT(*) FROM table_name 
GROUP BY column 
HAVING COUNT(*) > 1;
```

### LIMIT
```sql
-- MySQL/PostgreSQL
SELECT * FROM table_name LIMIT 10;
SELECT * FROM table_name LIMIT 10 OFFSET 5;
```

## Aggregate Functions

- `COUNT()` - Count rows
- `SUM()` - Sum of values
- `AVG()` - Average of values
- `MAX()` - Maximum value
- `MIN()` - Minimum value

## Constraints

- `PRIMARY KEY` - Unique identifier
- `FOREIGN KEY` - Reference to another table
- `UNIQUE` - Unique values
- `NOT NULL` - Cannot be NULL
- `CHECK` - Condition check
- `DEFAULT` - Default value

