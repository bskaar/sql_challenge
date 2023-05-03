# sql_challenge
UCB - Module 9 challenge

Acknowledgements: Prof Ahmad Sweed for 2+ hour Saturday, April 29th SQL review that I attended.

All files are located in Repository sql_challenge:

Created database named "Departments" for this challenge.

1. Created ERD (Entity-Realationship Diagram) for "Departments" db.

(see png file in repository) QuickDBD-Departments_Sql challenge.png

2. Created SQL query for each table and created each table in order to ensure foreign key constraints:

    a. Departments table
    b. Titles table
    c. Employees table
    d. Salaries table
    e. dept_emp table
    f. dept_manager table

3. Next ran queries to create each tables as follows (see DBeaver_sql_challenge_Scripte-2.sql in repository): 

CREATE TABLE "departments" (
    "dept_no" varchar(4)   NOT NULL,
    "dept_name" varchar(40)   NOT NULL,
    CONSTRAINT "pk_departments" PRIMARY KEY (
        "dept_no"
     )
);

CREATE TABLE "titles" (
    "title_id" varchar(10)   NOT NULL,
    "title" varchar(50)   NOT NULL,
    CONSTRAINT "pk_titles" PRIMARY KEY (
        "title_id"
     )
);

create type s as enum ('M','F');

CREATE TABLE "employees" (
    "emp_no" int   NOT NULL,
    "emp_title_id" varchar(10)   NOT NULL,
    "birth_date" date   NOT NULL,
    "first_name" varchar(14)   NOT NULL,
    "last_name" varchar(16)   NOT NULL,
    "sex" s default ('M') not NULL,
    "hire_date" date   NOT NULL,
    CONSTRAINT "pk_employees" PRIMARY KEY (
        "emp_no"
     )
);

CREATE TABLE "salaries" (
    "emp_no" int   NOT NULL,
    "salary" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL,
    CONSTRAINT "pk_salaries" PRIMARY KEY (
        "from_date","to_date"
     )
);

CREATE TABLE "dept_emp" (
    "emp_no" int   NOT NULL,
    "dept_no" varchar(4)   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

CREATE TABLE "dept_manager" (
    "dept_no" varchar(4)   NOT NULL,
    "emp_no" int   NOT NULL,
    "from_date" date   NOT NULL,
    "to_date" date   NOT NULL
);

ALTER TABLE "employees" ADD CONSTRAINT "fk_employees_emp_title_id" FOREIGN KEY("emp_title_id")
REFERENCES "titles" ("title_id");

ALTER TABLE "salaries" ADD CONSTRAINT "fk_salaries_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

ALTER TABLE "dept_emp" ADD CONSTRAINT "fk_dept_emp_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_dept_no" FOREIGN KEY("dept_no")
REFERENCES "departments" ("dept_no");

ALTER TABLE "dept_manager" ADD CONSTRAINT "fk_dept_manager_emp_no" FOREIGN KEY("emp_no")
REFERENCES "employees" ("emp_no");

4. Next verified that each table was created and empty.

select * from departments

select * from dept_emp

select * from dept_manager

select * from employees

select * from salaries

select * from titles

5. Imported csv. files into each table

6. Preformed analysis based on questions in challenge. (see sql_challenge_data analysis.sql file in repository)

--1.List the employee number, last name, first name, sex, and salary of each employee.

SELECT emp.emp_no, emp.last_name, emp.first_name, emp.sex, sal.salary
FROM raw.employees AS emp
JOIN raw.salaries AS sal
ON emp.emp_no = sal.emp_no;

--2.List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM raw.employees
WHERE EXTRACT(year FROM hire_date) = 1986;

--3.List the manager of each department along with their department number, department name, employee number, last name, and first name.

SELECT dm.dept_no, d.dept_name, dm.emp_no, emp.last_name, emp.first_name
FROM raw.dept_manager AS dm
JOIN raw.departments AS d
ON dm.dept_no = d.dept_no
JOIN raw.employees AS emp
on dm.emp_no = emp.emp_no;

--4.List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT emp.emp_no, emp.last_name, emp.first_name, d.dept_name
FROM raw.employees AS emp
JOIN raw.dept_emp AS de
ON emp.emp_no = de.emp_no
JOIN raw.departments as d
ON de.dept_no = d.dept_no;

--5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT first_name, last_name, sex
FROM raw.employees
WHERE first_name = 'Hercules' and last_name LIKE 'B%';

--6.List each employee in the Sales department, including their employee number, last name, and first name.

SELECT emp.emp_no, emp.last_name, emp.first_name
FROM raw.employees AS emp
JOIN raw.dept_emp AS de
ON emp.emp_no = de.emp_no
JOIN raw.departments as d
ON de.dept_no = d.dept_no
WHERE d.dept_name = 'Sales';

--7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT emp.emp_no, emp.last_name, emp.first_name, d.dept_name
FROM raw.employees AS emp
JOIN raw.dept_emp AS de
ON emp.emp_no = de.emp_no
JOIN raw.departments AS d
ON de.dept_no = d.dept_no
WHERE d.dept_name IN ('Sales', 'Development');

--8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(*) AS count
FROM raw.employees
GROUP BY last_name
ORDER BY count DESC;


