-- ***********************
-- Name: Saihong(Frank) Xiao
-- ID: 140777178
-- Date: 2019/03/14
-- Purpose: Lab 8 DBS301
-- ***********************

-- 1)	Display the names of the employees whose salary is the same as the lowest 
--  salaried employee in any department.

SELECT first_name || ' ' || last_name AS "Name"
    FROM employees
    WHERE salary = ANY(
        SELECT min(salary) AS "min_salary"
        FROM employees
        GROUP BY department_id
    );

-- 2) Display the names of the employee(s) whose salary is the lowest in each department.  

SELECT  first_name || ' ' || last_name AS "Name"
    FROM employees
    WHERE (department_id, salary) IN (
        SELECT department_id, min(salary)
            FROM employees
            GROUP BY department_id)
            ORDER BY last_name;

-- 3)	Give each of the employees in question 2 a $120 bonus.

SELECT  first_name || ' ' || last_name AS "Name", salary+120 AS "Salary with bonus"
    FROM employees
    WHERE (department_id, salary) IN (
        SELECT department_id, min(salary)
            FROM employees
            GROUP BY department_id)
            ORDER BY last_name;

--4)	Create a view named vwAllEmps that consists of all employees 
--  includes employee_id, last_name, salary, department_id, department_name, 
--  city and country (if applicable)

CREATE VIEW vwAllEmps AS(
    SELECT employee_id, last_name, salary, department_id, department_name, 
            city, country_id
            FROM employees LEFT OUTER JOIN departments USING (department_id)
                LEFT OUTER JOIN locations USING (location_id)
    ); 
        
SELECT * FROM vwAllEmps;

--5)	Use the vwAllEmps view to:
--a.	Display the employee_id, last_name, salary and city for all employees
--b.	Display the total salary of all employees by city
--c.	Increase the salary of the lowest paid employee(s) in each department by 120
--d.	What happens if you try to insert an employee by providing values for all columns in this view?
--e.	Delete the employee named Vargas. Did it work? Show proof.
SELECT employee_id, last_name, to_char(salary, '$999,999.99' ) AS "Salary", city FROM vwAllEmps;

SELECT to_char(sum(salary), '$999,999,00') AS "Total Salary", city 
    FROM vwAllEmps
    GROUP BY city;

UPDATE employees
SET salary = salary + 120
    WHERE (department_id, salary) IN ( 
        SELECT department_id, min(salary) 
            FROM vwAllEmps
            GROUP BY department_id   );
-- It said that the colum not allowed here, which is because
-- the view is not a table, you cannot insert data into it.
-- view is just a sql script.

--Delete from a view would work. it would actually delete data from the underlying table.


--6)	Create a view named vwAllDepts that consists of all 
--  departments and includes department_id, department_name, 
--  city and country (if applicable).
CREATE VIEW vwAllDepts AS 
    SELECT department_id, department_name, city, country_name
        FROM departments LEFT OUTER JOIN locations USING (location_id)
            LEFT OUTER JOIN countries USING (country_id);

--7)	Use the vwAllDepts view to:
--a.	For all departments display the department_id, name and city
--b.	For each city that has departments located in it display the number of departments by city
SELECT department_id, department_name, city
    FROM vwAllDepts;

SELECT city, count(department_id) AS "Number of departments"
    FROM vwAllDepts
    GROUP BY city
    ORDER BY "Number of departments" DESC;

-- 8)	Create a view called vwAllDeptSumm that consists of all departments 
--  and includes for each department: department_id, department_name, 
--  number of employees, number of salaried employees, total salary of all employees. 
--  Number of Salaried must be different from number of employees. 
--  The difference is some get commission.
DROP VIEW vwAllDeptSumm;
CREATE VIEW vwAllDeptSumm AS
    SELECT  e.department_id, d.department_name, 
            count(employee_id) AS "total_employees", 
            count(salary)-count(commission_pct) AS "total_salaried_employees",
            sum(salary) AS "Total salary"
       FROM departments d LEFT OUTER JOIN  employees e ON d.department_id  = e.department_id
       GROUP BY e.department_id, d.department_name;


--  9)	Use the vwAllDeptSumm view to display department name and number of employees 
--  for departments that have more than the average number of employees 
SELECT department_name, "total_employees"
    FROM vwAllDeptSumm
    WHERE "total_employees" > (
                                SELECT avg("total_employees")
                                    FROM vwAllDeptSumm
                             );


-- 10)	A) Use the GRANT statement to allow another student (Neptune account) to 
--  retrieve data for your employees table and to allow them to retrieve, 
--  insert and update data in your departments table. Show proof
--  B) Use the REVOKE statement to remove permission for that student to 
--  insert and update data in your departments table
GRANT SELECT ON employees TO dbs301_191a38;
GRANT SELECT, INSERT, UPDATE ON departments TO dbs301_191a38;

REVOKE INSERT UPDATE ON departments FROM dbs301_191a38;





