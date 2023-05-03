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

