# Employee Data Management PL/SQL Script

## Overview

This repository contains PL/SQL scripts designed to manage employee data by automating tasks like adding new cities, departments, and jobs, as well as inserting new employees into the database. The scripts also manage primary keys by generating sequences and triggers dynamically.

## Features

### 1. Employee Data Migration
- **Cursor Operation:** The script reads from the `employees_temp` table and processes records to insert into the main `employees` table.
- **Data Validation:** Email addresses are validated to ensure they contain an `@` symbol.
- **Job, Department, and City Management:** The script checks if the job, department, or city already exists before adding a new entry.

### 2. Primary Key Management
- **Dynamic Sequence and Trigger Creation:** Sequences and triggers are created for primary key columns in tables where the primary key is numeric and not composite.
- **Sequence Dropping:** Existing sequences are dropped before creating new ones to ensure data consistency.

### 3. Stored Procedures
- **`HR.addNewCity(NewCity IN VARCHAR2)`**
  - Adds a new city to the `locations` table if it doesn't already exist.
  
- **`HR.addNewDep(cityName IN VARCHAR2, departmentName IN VARCHAR2)`**
  - Adds a new department to the `departments` table, associating it with a specific city.
  
- **`HR.addNewJob(jobTile IN VARCHAR2)`**
  - Adds a new job to the `jobs` table if it doesn't already exist.
  
- **`HR.NewEmp(firstname IN VARCHAR2, lastname IN VARCHAR2, email IN VARCHAR2, hireDate IN VARCHAR2, jobID IN VARCHAR2, salary IN NUMBER, dept_id IN NUMBER)`**
  - Inserts a new employee into the `employees` table.

## Script Structure

1. **Employee Data Migration Script:**
   - A cursor `curEmpTemp` is used to loop through all records in the `employees_temp` table.
   - For each record, the script constructs an email address and validates it.
   - New cities, departments, and jobs are added as necessary using the `HR.addNewCity`, `HR.addNewDep`, and `HR.addNewJob` procedures.
   - Finally, the employee data is inserted into the `employees` table using the `HR.NewEmp` procedure.

2. **Primary Key Management Script:**
   - A cursor `filterCur` is used to identify primary key columns that are not of type `VARCHAR2` or `CHAR`.
   - For each identified column, a sequence is created, and a trigger is added to auto-generate values on insert.
   - Existing sequences are dropped before creating new ones.

3. **Stored Procedures:**
   - Procedures are defined for adding new cities, departments, and jobs, as well as inserting new employees.

## How to Use

1. **Set Up Database Environment:**
   - Ensure the Oracle database environment is set up and connected.
   - Run the scripts in the order provided to create necessary tables, sequences, triggers, and procedures.

2. **Run the Scripts:**
   - Execute the scripts using an Oracle database client like SQL*Plus or Oracle SQL Developer.

3. **Review Outputs:**
   - The scripts include DBMS_OUTPUT statements to log actions, such as adding new cities or jobs. Review these outputs for successful execution.

## Error Handling

- The scripts include basic error handling using the `DBMS_OUTPUT.PUT_LINE` function to log errors.
- If a city, department, or job already exists, an error message is displayed, and the insertion is skipped.

## Contributions

Contributions are welcome! If you find any issues or have suggestions for improvements, feel free to open an issue or submit a pull request.

