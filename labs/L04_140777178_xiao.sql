-- ***********************
-- Name: Saihong(Frank) Xiao
-- ID: 140777178
-- Date: 2019/1/31
-- Purpose: Lab 4 DBS301
-- ***********************


--1.	Display the difference between the Average pay and Lowest pay in the company

SELECT (avg(salary)- min(salary)) AS "Difference" 
    FROM employees;
    
--2.	Display the department number and Highest, Lowest and Average pay 

SELECT department_id, to_char(max(salary),'$999,999.00') AS "Highest salary", to_char(min(salary), '$999,999.00') AS "Lowest salary",to_char(avg(salary),'$999,999.00') AS "Average salary"
    FROM employees
    GROUP BY department_id
    ORDER BY avg(salary) DESC;

--3.	Display how many people work the same job in the same department

SELECT department_id AS "Dept#", job_id AS "Job", count(employee_id) AS "How Many"
    FROM employees
    GROUP BY department_id, job_id
    HAVING  count(employee_id) >1
    ORDER BY count(department_id) DESC;

--4.	For each job title display the job title and total amount paid each month for this type of the job.

SELECT job_id, sum(salary) AS "TOTAL SALARY PER MONTH"
    FROM employees
    WHERE job_id NOT IN ('AD_PRES', 'AD_VP')
    GROUP BY job_id

--5.	For each manager number display how many persons he / she supervises. Exclude managers with 
--      numbers 100, 101 and 102 and also include only those managers that supervise more than 2 persons.
--      Sort the output so that manager numbers with the most supervised persons are shown first.


 SELECT manager_id AS "Manager", count(manager_id) AS "How many"
    FROM employees
    WHERE manager_id NOT IN (100, 101, 102)
    GROUP BY manager_id
    HAVING count(manager_id)>2
    ORDER BY count(department_id) DESC;


--6.	For each department show the latest and earliest hire date, BUT
--      exclude departments 10 and 20 
--      exclude those departments where the last person was hired in this decade. (it is okay to hard code dates in this question only)
--      Sort the output so that the most recent, meaning latest hire dates, are shown first.

SELECT min(hire_date) AS "earliest", max(hire_date) AS "Latest"
    FROM employees
    WHERE department_id NOT IN (10, 20)
    GROUP BY department_id
    HAVING max(hire_date) < to_date('01012011', 'ddmmyyyy')
    ORDER BY "Latest" DESC ;























   