-- ***********************
-- Name: Saihong(Frank) Xiao
-- ID:   140777178
-- Date: 2019/02/14
-- Purpose: Lab 6 DBS301
-- ***********************


SET AUTOCOMMIT ON;

--2.	Create an INSERT statement to do this.  Add yourself as an
--  employee with a NULL salary, 0.21 commission_pct, in department
--  90, and Manager 100.  You started TODAY.  
INSERT INTO employees (employee_id, first_name, last_name, email, phone_number, 
            hire_date, job_id, salary, commission_pct, manager_id, department_id )
VALUES (188 , 'Saihong', 'Xiao', 'sxiao15@myseneca.ca', '6479165888', sysdate, 'SAL_REP',  NULL, 0.21, 100 ,90);

--3.	Create an Update statement to: Change the salary of 
--  the employees with a last name of Matos and Whalen to be 2500.
UPDATE employees SET salary = 2500
    WHERE last_name IN ('Matos' , 'Whalen');

--4.	Display the last names of all employees who are in 
--  the same department as the employee named Abel.
SELECT last_name FROM employees
    WHERE department_id =(
        SELECT department_id FROM employees
        WHERE last_name ='Abel'
    );


--5.	Display the last name of the lowest paid employee(s)
SELECT last_name
    FROM employees
    WHERE salary =(
        SELECT min(salary)
            FROM employees
    );


--6.	Display the city that the lowest paid employee(s) are located in.
SELECT city 
    FROM locations
    WHERE location_id IN (
        SELECT location_id 
            FROM departmentS
            WHERE department_id IN (
                SELECT DISTINCT department_id
                    FROM employees
                    WHERE salary =(
                        SELECT min(salary)
                            FROM employees
                    )
            )
    );
--7.	Display the last name, department_id, and salary of the lowest
--      paid employee(s) in each department.  Sort by Department_ID. 
--      (HINT: careful with department 60)
   
SELECT last_name , salary, department_id 
    FROM employees
    WHERE (department_id, salary) IN 
                        (SELECT  department_id, min(salary) AS "minsalary"
                        FROM employees 
                        GROUP BY department_id
                        )
                        ORDER BY department_id;

--8.	Display the last name of the lowest paid employee(s) in each city
 SELECT DISTINCT city FROM locations;    
 SELECT salary FROM employees
 SELECT location_id, de FROM departments ;
 
 
 SELECT last_name AS "Last Name", city AS "City"     
        FROM employees 
        JOIN  departments USING (department_id)
        JOIN locations USING(location_id)
        WHERE (salary, city) IN (
             SELECT min(salary), city 
                    FROM employees LEFT OUTER JOIN departments USING  (department_id)
                        LEFT OUTER JOIN locations USING (location_id)
                    GROUP BY city
        )ORDER BY city;
      
--9.	Display last name and salary for all employees who earn less than
--      the lowest salary in ANY department.  Sort the output by top 
--      salaries first and then by last name.
SELECT last_name, salary 
    FROM employees
    WHERE salary < ANY (
                            SELECT min(salary) 
                                FROM employees
                                GROUP BY department_id
                        )
    ORDER BY salary, last_name;
--10.	Display last name, job title and salary for all employees whose
--      salary matches any of the salaries from the IT Department. Do NOT 
--      use Join method.  Sort the output by salary ascending first and then by last_name

SELECT last_name, job_id, salary
    FROM employees
    WHERE salary IN (
                        SELECT DISTINCT salary
                            FROM employees
                            WHERE department_id= 60 
                    )
    ORDER BY salary, last_name;




