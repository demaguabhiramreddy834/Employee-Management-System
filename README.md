# Employee-Management-System
Employee Management System is a MySQL project for managing employee, department, salary, qualification, leave, and payroll data. It uses SQL queries, joins, constraints, aggregate functions, and subqueries to analyze employee information and generate useful insights for organizational decision-making

## Project Overview
The **Employee Management System** is a MySQL-based database project designed to efficiently manage and analyze employee information. It stores employee details, departments, job roles, salaries, bonuses, qualifications, leaves, and payroll information in a structured relational database.
The project demonstrates practical SQL and database management concepts through table creation, relationships, constraints, joins, aggregate functions, grouping, sorting, and analytical queries.

## Objectives
* Manage employee information efficiently
* Store department and job-role details
* Track employee salaries and bonuses
* Maintain employee qualification records
* Monitor employee leave information
* Manage payroll details
* Generate useful employee and salary insights

## Database Structure
The project uses the following tables:
1. **Employee** – Stores employee personal and job information.
2. **JobDepartment** – Contains department, job-role, description, and salary-range details.
3. **SalaryBonus** – Stores monthly salary, annual salary, and bonus information.
4. **Qualification** – Maintains employee qualification and requirement details.
5. **Leaves** – Records employee leave dates and reasons.
6. **Payroll** – Stores payroll, salary, leave, and payment information.
The tables are connected using **Primary Keys and Foreign Keys** with cascading rules to maintain data integrity.

## Analysis Performed
The project includes SQL analysis to identify:
* Total number of employees
* Departments with the highest number of employees
* Average salary by department
* Top 5 highest-paid employees
* Total company salary expenditure
* Job roles with the highest salaries
* Number of qualifications by position
* Employees with the most qualifications
* Departments with the highest leave activity
* Employees taking the most leaves
* Total company-wide leaves
* Total monthly payroll
* Average bonus by department
* Department receiving the highest total bonus
* Average net payroll after leave deductions

These queries provide useful insights into workforce distribution, compensation, qualifications, attendance, and payroll.

## Technologies Used
* **MySQL**
* **SQL**
* Relational Database Management System (RDBMS)

## SQL Concepts Used
* CREATE DATABASE
* CREATE TABLE
* INSERT
* SELECT
* WHERE
* GROUP BY
* ORDER BY
* HAVING
* JOIN
* Aggregate Functions
* Subqueries
* Primary Keys
* Foreign Keys
* Constraints
* CASCADE Operations

## How to Run
1. Install **MySQL** or MySQL Workbench.
2. Open the `employeeproject.sql` file.
3. Execute the complete SQL script.
4. The `EmployeeManagementDB` database will be created.
5. Run the analytical queries to generate employee and payroll insights.

## Project Files
Employee-Management-System/
│
├── employeeproject.sql
└── README.md

## Key Learning
This project provides practical experience in **SQL, relational database design, data management, table relationships, business analysis, and database querying**. It demonstrates how employee data can be transformed into meaningful insights for organizational decision-making.

## Author
**Abhiramreddy Demagu**

### ⭐ If you find this project useful, consider giving the repository a star!
