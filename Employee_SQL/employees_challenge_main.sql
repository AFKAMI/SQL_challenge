

DROP TABLE titles
DROP TABLE employees
DROP TABLE dept_emp
DROP TABLE departments
DROP TABLE dept_manager
DROP TABLE salaries
-- 
CREATE TABLE titles(
	title_id VARCHAR PRIMARY KEY,
	title VARCHAR(30)
);

SELECT * FROM titles
-- 

CREATE TABLE employees(
	emp_no SERIAL PRIMARY KEY,
	emp_title_id VARCHAR,
	birth_date DATE,
	first_name VARCHAR(30) NOT NULL,
	last_name VARCHAR(30) NOT NULL,
	sex VARCHAR(30),
	hire_date DATE,
	FOREIGN KEY (emp_title_id) REFERENCES titles(title_id)
);

SELECT * FROM employees
-- 
CREATE TABLE departments(
	dept_no VARCHAR  PRIMARY	KEY,
	dept_name VARCHAR(30)
);
SELECT * FROM departments
-- 
CREATE TABLE dept_emp(
	emp_no INT,
	dept_no VARCHAR(30),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no),
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no)
);

SELECT * FROM dept_emp
-- 
CREATE TABLE dept_manager(
	dept_no VARCHAR(30),
	emp_no INT,
	FOREIGN KEY (dept_no) REFERENCES departments(dept_no),
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM dept_manager
-- 
CREATE TABLE salaries(
	emp_no INT,
	salary INT,
	FOREIGN KEY (emp_no) REFERENCES employees(emp_no)
);

SELECT * FROM salaries

-- 

-- 1.List the employee number, last name, first name, sex, and salary of each employee.
SELECT e.emp_no, last_name, first_name, sex, salary
FROM employees AS e
LEFT JOIN salaries AS s
ON e.emp_no = s.emp_no


-- 2.List the first name, last name, and hire date for the employees who were hired in 1986.

SELECT first_name, last_name, hire_date
FROM employees
WHERE EXTRACT(YEAR FROM hire_date) = 1986;

-- 3.List the manager of each department along with their department number, department name, employee number, last name, and first name.
CREATE VIEW manager_of_departments AS
SELECT e.emp_no, first_name, last_name,d.dept_name, d.dept_no 
FROM dept_manager AS dm
LEFT JOIN departments AS d
ON dm.dept_no = d.dept_no
LEFT JOIN employees AS e
ON dm.emp_no = e.emp_no;

SELECT * FROM manager_of_departments

-- 4.List the department number for each employee along with that employee’s employee number, last name, first name, and department name.

SELECT e.emp_no, de.dept_no, d.dept_name, e.first_name, e.last_name
FROM dept_emp AS de
JOIN departments AS d
ON de.dept_no = d.dept_no
JOIN employees AS e
ON de.emp_no = e.emp_no;

-- 5.List first name, last name, and sex of each employee whose first name is Hercules and whose last name begins with the letter B.

SELECT first_name,last_name, sex
FROM employees
WHERE first_name = 'Hercules'
AND last_name LIKE 'B%'


-- 6.List each employee in the Sales department, including their employee number, last name, and first name.

SELECT e.emp_no, first_name, last_name
FROM dept_emp AS de
JOIN departments AS d
ON de.dept_no = d.dept_no
JOIN employees AS e
ON de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales';



-- 7.List each employee in the Sales and Development departments, including their employee number, last name, first name, and department name.

SELECT e.emp_no, first_name, last_name, d.dept_name
FROM dept_emp AS de
JOIN departments AS d
ON de.dept_no = d.dept_no
JOIN employees AS e
ON de.emp_no = e.emp_no
WHERE d.dept_name = 'Sales'
OR d.dept_name = 'Development';

-- 8.List the frequency counts, in descending order, of all the employee last names (that is, how many employees share each last name).

SELECT last_name, COUNT(last_name) AS "Same_Last_Name_Count"
FROM employees
GROUP BY last_name
ORDER BY "Same_Last_Name_Count" DESC
LIMIT 100;




