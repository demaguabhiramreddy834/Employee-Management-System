-- Step 1: Create Database
CREATE DATABASE EmployeeManagementDB;

-- Step 2: Select Database
USE EmployeeManagementDB;

-- table 1 jobdepartment
CREATE TABLE JobDepartment (
    Job_ID INT PRIMARY KEY,
    jobdept VARCHAR(50) NOT NULL,
    name VARCHAR(100) NOT NULL,
    description TEXT,
    salaryrange VARCHAR(50)
);
select * from jobdepartment;


-- table 2 salarybonus
CREATE TABLE SalaryBonus (
    salary_ID INT PRIMARY KEY,
    Job_ID INT,
    amount DECIMAL(10,2) NOT NULL,
    annual DECIMAL(10,2) NOT NULL,
    bonus DECIMAL(10,2) DEFAULT 0.00,
    CONSTRAINT fk_salary_job FOREIGN KEY (Job_ID) 
        REFERENCES JobDepartment(Job_ID)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
select * from salarybonus;


-- table 3 employee
CREATE TABLE Employee (
    emp_ID INT PRIMARY KEY,
    firstname VARCHAR(50) NOT NULL,
    lastname VARCHAR(50) NOT NULL,
    gender VARCHAR(10),
    age INT,
    contact_add VARCHAR(100),
    emp_email VARCHAR(100) UNIQUE NOT NULL,
    emp_pass VARCHAR(50) NOT NULL,
    Job_ID INT,
    CONSTRAINT fk_employee_job FOREIGN KEY (Job_ID)
        REFERENCES JobDepartment(Job_ID)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);
SELECT * FROM employee;


-- table 4 qualification
CREATE TABLE Qualification (
    QualID INT PRIMARY KEY,
    Emp_ID INT,
    Position VARCHAR(50),
    Requirements VARCHAR(255),
    Date_In DATE,
    CONSTRAINT fk_qualification_emp FOREIGN KEY (Emp_ID)
        REFERENCES Employee(emp_ID)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);
select * from qualification;


-- table 5 leaves
CREATE TABLE Leaves (
    leave_ID INT PRIMARY KEY,
    emp_ID INT,
    date DATE,
    reason TEXT,
    CONSTRAINT fk_leave_emp FOREIGN KEY (emp_ID) 
        REFERENCES Employee(emp_ID)
        ON DELETE CASCADE 
        ON UPDATE CASCADE
);
select *from leaves;

-- table 6 payroll
CREATE TABLE Payroll (
    payroll_ID INT PRIMARY KEY,
    emp_ID INT,
    job_ID INT,
    salary_ID INT,
    leave_ID INT,
    date DATE,
    report TEXT,
    total_amount DECIMAL(10,2),
    CONSTRAINT fk_payroll_emp FOREIGN KEY (emp_ID) 
        REFERENCES Employee(emp_ID)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_job FOREIGN KEY (job_ID) 
        REFERENCES JobDepartment(Job_ID)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_salary FOREIGN KEY (salary_ID) 
        REFERENCES SalaryBonus(salary_ID)
        ON DELETE CASCADE 
        ON UPDATE CASCADE,
    CONSTRAINT fk_payroll_leave FOREIGN KEY (leave_ID) 
        REFERENCES Leaves(leave_ID)
        ON DELETE SET NULL 
        ON UPDATE CASCADE
);
select * from payroll;


-- Analysis Questions
-- 1.EMPLOYEE INSIGHTS

-- How many unique employees are currently in the system?
select * from employee;

select count(DISTINCT emp_ID) as unique_employee_count
from Employee;

-- Which departments have the highest number of employees?
select 
    jobdept AS department_name, 
    COUNT(emp_ID) AS employee_count
from Employee
join JobDepartment ON Jobdept=Jobdept
group by jobdept
order by employee_count DESC;

-- What is the average salary per department?
select
    jobdept AS department_name, 
    count(emp_ID) AS employee_count,
    round(AVG(amount), 2) AS avg_monthly_salary,
    round(AVG(annual), 2) AS avg_annual_salary
from Employee
join JobDepartment ON Jobdept = Jobdept
join SalaryBonus ON Jobdept = Jobdept
group by jobdept
order by avg_monthly_salary DESC;


-- Who are the top 5 highest-paid employees?
 select
    emp_ID, 
    firstname, 
    lastname, 
    jobdept AS department, 
    name AS job_title,
    amount AS monthly_salary,
    annual AS annual_salary
from Employee e
join JobDepartment ON Jobdept = Jobdept
join SalaryBonus ON Jobdept= Jobdept
order by amount desc
limit 5;

-- What is the total salary expenditure across the company?
select 
    sum(amount) as monthly_expenditure,
    sum(annual) as annual_expenditure
from  Employee 
join SalaryBonus ON emp_id = emp_id;


-- 2. JOB ROLE AND DEPARTMENT ANALYSIS
-- How many different job roles exist in each department?
select 
    jobdept AS department_name, 
    count(DISTINCT name) AS different_job_roles
from JobDepartment
group by jobdept
order by different_job_roles DESC;

-- What is the average salary range per department?
select 
    jobdept AS department_name, 
    salaryrange
from JobDepartment
group by jobdept, salaryrange;

-- Which job roles offer the highest salary?
select
    jobdept AS department, 
    name AS job_role, 
    amount AS monthly_salary,
    annual AS annual_salary,
    bonus
from jobdepartment 
join salarybonus ON jobdept = jobdept
order by amount DESC;


-- Which departments have the highest total salary allocation?
select
    jobdept AS department_name, 
    count(emp_ID) AS employee_count,
    sum(amount) AS monthly_allocation,
    sum(annual) AS annual_allocation
from Employee 
join JobDepartment ON jobdept = jobdept
join SalaryBonus ON jobdept = jobdept
group by jobdept
order by monthly_allocation DESC;


-- 3. QUALIFICATION AND SKILLS ANALYSIS
-- How many employees have at least one qualification listed?
select count(DISTINCT Emp_ID) AS employees_with_qualification
from Qualification;

-- Which positions require the most qualifications?
select
    Position, 
    count(qualid) AS qualification_count
from Qualification
group by Position
order by qualification_count DESC;

-- Which employees have the highest number of qualifications?
select
    emp_id, 
    firstname, 
    lastname, 
    count(qualid) AS qualification_count
from Employee
join qualification ON emp_id = emp_id
group by emp_id, firstname, lastname
order by qualification_count DESC;


-- 4. LEAVE AND ABSENCE PATTERNS
-- Which year had the most employees taking leaves?
select
    extract(YEAR FROM date) AS leave_year, 
    count(leave_ID) AS total_leaves
from Leaves
group by EXTRACT(YEAR FROM date)
order by total_leaves DESC
limit 1;


-- What is the average number of leave days taken by its employees per department?
select 
    j.jobdept AS department_name, 
    count(distinct e.emp_ID) AS total_employees,
    count(l.leave_ID) AS total_leaves,
    round(count(l.leave_ID) * 1.0 / count(distinct e.emp_ID), 2) AS avg_leaves_per_employee
from Employee e
join JobDepartment j ON e.Job_ID = j.Job_ID
left join leaves l ON e.emp_ID = l.emp_ID
group by j.jobdept;


-- Which employees have taken the most leaves?
select 
    e.emp_ID, 
    e.firstname, 
    e.lastname, 
    count(l.leave_ID) AS leave_count
from Employee e
join Leaves l ON e.emp_ID = l.emp_ID
group by e.emp_ID, e.firstname, e.lastname
order by leave_count DESC;


-- What is the total number of leave days taken company-wide?
select count(leave_ID) AS total_leave_days_company_wide
from Leaves;


-- How do leave days correlate with payroll amounts?
select
    p.emp_ID,
    e.firstname,
    e.lastname,
    count(p.leave_ID) AS total_leaves_taken,
    s.amount AS base_monthly_salary,
    p.total_amount AS net_payroll_received,
    (s.amount - p.total_amount) AS leave_deduction
from Payroll p
join Employee e ON p.emp_ID = e.emp_ID
join SalaryBonus s ON p.salary_ID = s.salary_ID
group by p.emp_ID, e.firstname, e.lastname, s.amount, p.total_amount
order by total_leaves_taken DESC;

-- 5. PAYROLL AND COMPENSATION ANALYSIS
-- What is the total monthly payroll processed?
select sum(total_amount) AS total_monthly_payroll
from Payroll;


-- What is the average bonus given per department?
select
    j.jobdept AS department_name, 
    round(avg(s.bonus)) AS avg_bonus
from JobDepartment j
join SalaryBonus s ON j.Job_ID = s.Job_ID
group by j.jobdept
order by avg_bonus DESC;


-- Which department receives the highest total bonuses?
select
    j.jobdept AS department_name, 
    SUM(s.bonus) AS total_bonus_amount
from Employee e
join JobDepartment j ON e.Job_ID = j.Job_ID
join SalaryBonus s ON e.Job_ID = s.Job_ID
group by j.jobdept
order by total_bonus_amount DESC
limit 1;


-- What is the average value of total_amount after considering leave deductions?
select round(avg(total_amount), 2) AS avg_net_payroll
from Payroll;
