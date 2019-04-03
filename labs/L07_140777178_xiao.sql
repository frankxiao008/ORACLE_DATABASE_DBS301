-- ***********************
-- Name: Saihong(Frank) Xiao
-- ID:   140777178
-- Date: 2019/03/07
-- Purpose: Lab 7 DBS301
-- ***********************


--1.	The HR department needs a list of Department IDs for departments that do not conbtain 
--      the job ID of ST_CLERK> Use a set operator to create this report.
SELECT department_id
    FROM departments
MINUS    
SELECT DISTINCT department_id
    FROM employees
    WHERE job_id = 'ST_CLERK';

--2.	Same department requests a list of countries that have no departments located 
--  in them. Display country ID and the country name. Use SET operators.

SELECT country_id, country_name
    FROM countries
MINUS
SELECT country_id, country_name
    FROM departments d JOIN locations USING(location_id)
        JOIN countries USING(country_id);
    


--3.	The Vice President needs very quickly a list of departments 10, 50, 20 
--  in that order. job and department ID are to be displayed.

SELECT DISTINCT job_id, department_id 
    FROM employees
    WHERE department_id =10
UNION ALL
SELECT DISTINCT job_id, department_id 
    FROM employees
    WHERE department_id =50
UNION ALL
SELECT DISTINCT job_id, department_id 
    FROM employees
    WHERE department_id =20;
    

--4.	Create a statement that lists the employeeIDs and JobIDs of those employees
--  who currently have a job title that is the same as their job title when they were 
--  initially hired by the company (that is, they changed jobs but have now gone back 
--  to doing their original job).

SELECT employee_id, job_id
    FROM (
        SELECT employee_id, job_id, hire_date
            FROM employees
        INTERSECT    
        SELECT employee_id, job_id, start_date
            FROM job_history
    );
    
--  5.	The HR department needs a SINGLE report with the following specifications:
--  a.	Last name and department ID of all employees regardless of whether they belong to a department or not.
--  b.	Department ID and department name of all departments regardless of whether they have employees in them or not.


SELECT last_name, department_id, null AS department_name
    FROM employees 
UNION ALL
SELECT  null,  department_id, department_name
    FROM departments;

















