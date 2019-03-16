
-- ***********************
-- Name: Saihong(Frank) Xiao
-- ID: 140777178
-- Date: 2019/1/17
-- Purpose: Lab 2 DBS301
-- ***********************



--1. 1.	Display the employee_id, last name and salary in the range of $8,000 to $12,000

SELECT employee_id,last_name, to_char(salary, '$999,999.99') AS "SALARY"
    FROM employees
    WHERE salary BETWEEN 8000 AND 12000
    ORDER BY SALARY DESC, last_name;
    
--2.	Modify previous query (#1)to display only programmers and salespersons.

SELECT employee_id,last_name, to_char(salary, '$999,999.99') AS "SALARY"
    FROM employees
    WHERE (job_id = 'IT_PROG'  OR job_id = 'SA_REP') AND (salary BETWEEN 8000 AND 12000)
    ORDER BY SALARY DESC, last_name;
    


--3. earn outside the given salary range from question 1

SELECT employee_id,last_name, to_char(salary, '$999,999.99') AS "SALARY"
    FROM employees
    WHERE (job_id = 'IT_PROG'  OR job_id = 'SA_REP') AND (salary < 8000 OR salary > 12000)
    ORDER BY SALARY DESC, last_name;


--4. Display the last name, job_id and salary of employees hired before 2018, recently first

SELECT last_name,job_id,to_char(salary, '$999,999.99') AS "SALARY"
    FROM employees
    WHERE hire_date < to_date('2018-01-01', 'yyyy-mm-dd')
    ORDER BY hire_date DESC, last_name;

--5 displays only employees earning more than $12,000. 
SELECT last_name,job_id,to_char(salary, '$999,999.99') AS "SALARY"
    FROM employees
    WHERE hire_date < to_date('2018-01-01', 'yyyy-mm-dd') AND salary > 12000
    ORDER BY job_id, salary DESC;
    
--6.	Display the job titles and full names of employees whose first
--    name contains an ‘e’ or ‘E’   
SELECT job_id AS "Job Title", first_name || ' ' || last_name AS "Full name"
    FROM employees
    WHERE upper(first_name) LIKE '%E%';
    
--7.	Create a report to display last name, salary, and commission
--      percent for all employees that earn a commission. 

SELECT last_name, to_char(salary, '$999,999.99') AS "SALARY", commission_pct
    FROM employees
    WHERE job_id = 'SA_REP' OR job_id = 'SA_MAN';
    
-- 8.	Do the same as question 7, but put the report in order of descending salaries.
  SELECT last_name, to_char(salary, '$999,999.99') AS "SALARY", commission_pct
    FROM employees
    WHERE job_id = 'SA_REP' OR job_id = 'SA_MAN'
    ORDER BY salary DESC;
    
--9.  use a numeric value instead of a column name to do the sorting.

  SELECT last_name, to_char(salary, '$999,999.99') AS "SALARY", commission_pct
    FROM employees
    WHERE job_id = 'SA_REP' OR job_id = 'SA_MAN'
    ORDER BY 2 DESC;

