-- ***********************
-- Name: Saihong(Frank) Xiao
-- ID: 140777178
-- Date: 2019/02/07
-- Purpose: Lab 5 DBS301
-- ***********************

--1.	Display the department name, city, street address and postal code for departments 
--      sorted by city and department name.

SELECT department_name, city, street_address, postal_code
    FROM departments, locations
    WHERE departments.location_id = locations.location_id
    ORDER BY city, department_name;
    
--2.	Display full name their hire date, salary, department name and city, but only for 
--      departments with names starting with an A or S sorted by department name and employee
--      name. 

SELECT last_name || ', ' || first_name AS "Full Name", hire_date, to_char(salary, '$999,999.99'), department_name, city
    FROM employees e, departments d, locations l
    WHERE (department_name LIKE 'A%' OR department_name LIKE 'S%')
        AND e.department_id = d.department_id
            AND d.location_id = l.location_id
    ORDER BY department_name, "Full Name";

--3.	Display the full name of the manager of each department in states/provinces of Ontario, 
--      New Jersey and Washington along with the department name, city, postal code and province name.
--      Sort the output by city and then by department name.
SELECT e.last_name ||', ' || e.first_name AS "Full Name",department_name,  city, postal_code, state_province
    FROM departments d, employees e, locations l
    WHERE d.manager_id = e.employee_id AND d.location_id = l.location_id
        AND (state_province IN ('New Jersey', 'Ontario', 'Washington') )  
    ORDER BY city, department_name;
    
 
--4.	Display employee last name and employee number along with their manager last name 
--      and manager number. Label the columns Employee, Emp#, Manager, and Mgr# respectively.
SELECT a.last_name AS "Employee", a.employee_id AS "Emp#", b.last_name AS "Manager", b.employee_id AS "Mgr#"
    FROM employees a, employees b
    WHERE a.manager_id = b.employee_id ; 
    
    
--5.	Display the department name, city, street address, postal code and country name for all 
--      Departments. Use the JOIN and USING form of syntax.  Sort the output by department name descending.
SELECT department_name, city, street_address, postal_code, country_name
    FROM departments LEFT OUTER JOIN locations
        USING(location_id)
        LEFT OUTER JOIN countries
        USING(country_id)
    ORDER BY department_name DESC;
 
-- 6.	Display full name of the employees, their hire date and salary together with their 
--      department name, but only for departments which names start with A or S.
--      a.	Full name should be formatted:  First / Last. 
--      b.	Use the JOIN and ON form of syntax.
--      c.	Sort the output by department name and then by last name.
SELECT e.first_name ||'/' ||  e.last_name AS "Full Name", hire_date, salary, department_name
    FROM employees e JOIN departments d
        ON e.department_id = d.department_id
    WHERE department_name LIKE 'A%' OR department_name LIKE 'S%'
    ORDER BY department_name, e.last_name;
 
    
--7.	Display full name of the manager of EACH DEPARTMENT in provinces Ontario, 
--      New Jersey and Washington plus department name, city, postal code and province name. 
--      a.	Full name should be formatted: Last, First.  
--      b.	Use the JOIN and ON form of syntax.
--      c.	Sort the output by city and then by department name. 
SELECT e.last_name ||', ' || e.first_name AS "Full Name",department_name,  city, postal_code, state_province
    FROM departments d LEFT OUTER JOIN employees e 
            ON d.manager_id = e.employee_id
        LEFT OUTER JOIN locations l
            ON d.location_id = l.location_id
    WHERE (state_province IN ('New Jersey', 'Ontario', 'Washington') )
    ORDER BY city, department_name;  
  
-- 8.	Display the department name and Highest, Lowest and Average pay per each department. 
--      Name these results High, Low and Avg.
--      a.	Use JOIN and ON form of the syntax.
--      b.	Sort the output so that department with highest average salary are shown first.
SELECT department_name, to_char(max(salary), '$999,999.99') AS "High", 
    to_char(min(salary), '$999,999.99') AS "Low", to_char(avg(salary),'$999,999.99') AS "Avg"
    FROM employees e RIGHT OUTER JOIN  departments d
        ON  e.department_id = d.department_id
    GROUP BY department_name
    ORDER BY 
    (CASE
        WHEN avg(salary) IS NULL THEN 0
        ELSE avg(salary)
    END) DESC;
        
--      9.	Display the employee last name and employee number along with their manager¡¯s 
--      last name and manager number. Label the columns Employee, 
--      a.	Emp#, Manager, and Mgr#, respectively. 
--      b.	Include also employees who do NOT have a manager and also employees who 
--          do NOT supervise anyone (or you could say managers without employees to supervise).
  
SELECT a.last_name AS "Employee", a.employee_id AS "Emp#", b.last_name AS "Manager", b.employee_id AS "Mgr#"
    FROM employees  a FULL JOIN employees b
    ON a.manager_id = b.employee_id;




