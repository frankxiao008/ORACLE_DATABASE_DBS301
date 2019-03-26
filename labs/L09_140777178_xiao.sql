-- ***********************
-- Name: Saihong(Frank) Xiao
-- ID: 140777178
-- Date: 2019/3/21
-- Purpose: Lab 9 DBS301
-- ***********************

--1.	Create table L09SalesRep and load it with data from table EMPLOYEES table. 
-- Use only the equivalent columns from EMPLOYEE as shown below and only for people in department 80.
--Column          		Type    	    
--RepId			NUMBER	(6)	
--FName			VARCHAR2(20)    
--LName			VARCHAR2(25)   
--Phone#			VARCHAR2(20)         ALL these columns¡¯ data types match 
--Salary			NUMBER(8,2)                            one¡¯s in table EMPLOYEES
--Commission		NUMBER(2,2

CREATE TABLE L09SalesRep
    AS (SELECT  employee_id AS RepId, 
                first_name AS FName, 
                last_name AS LName, 
                phone_number AS Phone#, 
                salary AS Salary, 
                commission_pct AS Commission
        FROM employees
        WHERE department_id =80);
    
--2.	Create L09Cust table.
CREATE TABLE L09Cust (
   CUST#	  	NUMBER(6),
   CUSTNAME 	VARCHAR2(30),
   CITY 		VARCHAR2(20),
   RATING		CHAR(1),
   COMMENTS	    VARCHAR2(200),
   SALESREP#	NUMBER(7) );
    
    INSERT ALL
        INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP# )
        VALUES (501,'ABC LTD.', 'Montreal','C',201 )
        INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP# )
        VALUES (501, 'ABC LTD.', 'Montreal', 'C', 201)
        INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP# )
        VALUES(502, 'Black Giant', 'Ottawa', 'B', 202)
        INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP# )
        VALUES(503, 'Mother Goose', 'London', 'B', 202)
        INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP# )
        VALUES(701, 'BLUE SKY LTD', 'Vancouver', 'B', 102)
        INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP# )
        VALUES(702, 'MIKE and SAM Inc.', 'Kingston', 'A', 107)
        INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP# )
        VALUES(703, 'RED PLANET', 'Mississauga', 	'C', 107)
        INTO L09Cust (CUST#, CUSTNAME, CITY, RATING, SALESREP# )
        VALUES(717, 'BLUE SKY LTD', 'Regina', 'D', 102)
        SELECT * FROM dual;

--3.	Create table L09GoodCust by using following columns but only if their rating is A or B. 

CREATE TABLE L09GoodCust
    AS  (
        SELECT  cust# AS CustId,
                custname AS Name,
                city AS location,
                salesrep# AS RepId
            FROM L09CUST
            WHERE rating IN ('A', 'B')
        );

--4. Now add new column to table L09SalesRep called JobCode that will be
-- of variable character type with max length of 12. Do a DESCRIBE L09SalesRep to ensure it executed
ALTER TABLE L09SalesRep
ADD JobCode VARCHAR2(12);
DESCRIBE L09SalesRep;

--5.	Declare column Salary in table L09SalesRep as mandatory one and Column Location 
--      in table L09GoodCust as optional one. You can see location is already optional.
	
ALTER TABLE L09SalesRep MODIFY ( Salary NOT NULL);

ALTER TABLE L09GoodCust MODIFY (Location VARCHAR2(20) NULL);

--5 Lengthen FNAME in L09SalesRep to 37. The result of a DESCRIBE should show it happening
ALTER TABLE L09SalesRep MODIFY (fname VARCHAR2(37));
DESCRIBE L09SalesRep;


SELECT MAX(length(name)) INTO   namelength FROM   L09GoodCust;
BEGIN     
    ALTER TABLE L09SalesRep MODIFY ( name VARCHAR2(namelength));  
END;
 



     

     


   




--6.	Now get rid of the column JobCode in table L09SalesRep in a way
--     that will not affect daily performance. 
ALTER TABLE L09SalesRep SET UNUSED (JobCode);

--7.	Declare PK constraints in both new tables ? RepId and CustId

ALTER TABLE L09SalesRep
    ADD PRIMARY KEY (RepId);

ALTER TABLE L09GoodCust
    ADD PRIMARY KEY (CustId);
    
--8.	Declare UK constraints in both new tables ? Phone# and Name
ALTER TABLE L09SalesRep
ADD CONSTRAINT UC_Person UNIQUE (Phone#);

ALTER TABLE L09GoodCust
ADD CONSTRAINT UC_CUST UNIQUE (Name);

--9.	Restrict amount of Salary column to be in the range [6000, 12000] 
--      and Commission to be not more than 50%.

ALTER TABLE  L09SalesRep
ADD CONSTRAINT ck_salary_comm CHECK (salary > 6000 AND salary < 12000 AND Commission <0.5 );

--10.	Ensure that only valid RepId numbers from table L09SalesRep may be 
--  entered in the table L09GoodCust. Why this statement has failed?

ALTER TABLE L09GoodCust
    ADD FOREIGN KEY (RepId)
    REFERENCES L09SalesRep(RepId);
-- This is because L09GoodCust already contain RepId values which cannot be
-- found in the L09SalesRep table.

--11.	Firstly write down the values for RepId column in table L09GoodCust 
--and then make all these values blank. Now redo the question 10. Was it successful? 
UPDATE L09GoodCust
SET repid = null;
-- Yes, it is successful. after set all values to blank, it do not have the problem when 
-- trying to match the value in L09GoodCust RepId column with the value in L09SalesRep.

--12.	Disable this FK constraint now and enter old values for RepId in table 
--L09GoodCust and save them. Then try to enable your FK constraint. What happened? 
ALTER TABLE L09GoodCust
DISABLE CONSTRAINT SYS_C00488027;

UPDATE L09GoodCust 
SET repid = 202 WHERE custid = 502; 
UPDATE L09GoodCust 
SET repid = 202 WHERE custid = 503; 
UPDATE L09GoodCust 
SET repid = 102 WHERE custid = 701; 
UPDATE L09GoodCust 
SET repid = 107 WHERE custid = 702; 
ALTER TABLE L09GoodCust
DISABLE CONSTRAINT SYS_C00488027;

ALTER TABLE L09GoodCust
ENABLE CONSTRAINT SYS_C00488027;
-- It still complain, the error is the same, because the table has
-- child records, 

--13.	Get rid of this FK constraint. Then modify your CK constraint from 
--question 9 to allow Salary amounts from 5000 to 15000.

ALTER TABLE L09GoodCust
DROP CONSTRAINT SYS_C00488027;

ALTER TABLE L09SalesRep
DROP CONSTRAINT ck_salary_comm;
ALTER TABLE L09SalesRep
ADD CONSTRAINT ck_salary_comm
CHECK (salary > 5000 AND salary < 15000 AND Commission <0.5 );

--14.	Describe both new tables L09SalesRep and L09GoodCust and then show 
--all constraints for these two tables by running the following query:
SELECT  constraint_name, constraint_type, search_condition, table_name
FROM     user_constraints
WHERE table_name IN (' L09SalesRep',' L09GoodCust')
ORDER  BY  4 , 2;

