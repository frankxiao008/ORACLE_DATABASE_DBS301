-- ***********************
-- Name: Saihong(Frank) Xiao
-- ID: 140777178
-- Date: 2019/3/28
-- Purpose: Lab 10 DBS301
-- ***********************

--1.	Create table L10Cities from table LOCATIONS, but only for location 
--numbers less than 2000 (do NOT create this table from scratch, i.e. 
--create and insert in one statement).

    CREATE TABLE L10Cities AS(
        SELECT * FROM locations
            WHERE location_id < 2000
    );
    
    DESCRIBE L10Cities;

--2.	Create table L10Towns from table LOCATIONS, but only for 
--location numbers less than 1500 (do NOT create this table from scratch). 
--This table will have same structure as table L10Cities. 
CREATE TABLE L10Towns AS (
    SELECT * FROM locations
        WHERE location_id < 1500
);

--3. Now you will empty your RECYCLE BIN with one powerful command. 
--Then remove your table L10Towns, so that will remain in the recycle bin. 
--Check that it is really there and what time was removed.  
--Hint: Show RecycleBin,   Purge,  Flashback
PURGE RecycleBin;
DROP TABLE L10Towns;
Show RecycleBin;

--4. Restore your table L10Towns from recycle bin and describe it. 
--Check what is in your recycle bin now.
FLASHBACK TABLE L10Towns TO BEFORE DROP;
DESCRIBE L10Towns;


--5. Now remove table L10Towns so that does NOT remain in the recycle bin. 
--Check that is really NOT there and then try to restore it. Explain what happened?
DROP TABLE L10Towns;
PURGE RecycleBin;

FLASHBACK TABLE L10Towns TO BEFORE  DROP;
-- The recyclebin has already been purged, which means the talbe L10Towns is 
-- no longer in the recycle bin. so you cannot flashback it anymore.

--6. Create simple view called CAN_CITY_VU, based on table L10Cities 
--so that will contain only columns Street_Address, Postal_Code, 
--City and State_Province for locations only in CANADA. 
--Then display all data from this view.
CREATE VIEW CAN_CITY_VU AS (
    SELECT Street_Address, Postal_Code, City, State_Province 
        FROM L10Cities 
        WHERE country_id = 'CA'
);
SELECT * FROM CAN_CITY_VU;

--7. Modify your simple view so that will have following aliases instead of 
--original column names: Str_Adr, P_Code, City and Prov and also will 
--include cities from ITALY as well. Then display all data from this view. 
DROP VIEW CAN_CITY_VU;
CREATE VIEW CAN_CITY_VU AS (
        SELECT Street_Address Str_Adr, 
                Postal_Code P_Code, 
                City City, 
                State_Province Prov
        FROM L10Cities 
        WHERE country_id IN ( 'CA', 'IT' )
);
SELECT * FROM CAN_CITY_VU;

--8. Create complex view called vwCity_DName_VU, based on tables LOCATIONS 
--and DEPARTMENTS, so that will contain only columns Department_Name, 
--City and State_Province for locations in ITALY or CANADA. Include 
--situations even when city does NOT have department established yet. 
--Then display all data from this view.
CREATE VIEW vwCity_DName_VU AS (
    SELECT Department_Name, City, State_Province
        FROM departments RIGHT OUTER JOIN locations
        ON departments.location_id = locations.location_id
        WHERE country_id IN ( 'CA', 'IT' )
);
SELECT * FROM vwCity_DName_VU;

--9. Modify your complex view so that will have following aliases instead of 
--original column names: DName, City and Prov and also will include all 
--cities outside United States 

CREATE OR REPLACE VIEW vwCity_DName_VU AS
     (
         SELECT Department_Name DName, City City, State_Province Prov
            FROM departments RIGHT OUTER JOIN locations
            ON departments.location_id = locations.location_id
            WHERE country_id  NOT IN ( 'US' )
     );
SELECT * FROM vwCity_DName_VU;

--10.	Check in the Data Dictionary what Views (their names and definitions) 
--    are created so far in your account. Then drop your vwCity_DName_VU and 
--    check Data Dictionary again. What is different?


SELECT * FROM ALL_OBJECTS 
    WHERE upper(Object_Type) = 'VIEW' AND upper(owner) = 'DBS301_191B30';

DROP VIEW vwCity_DName_VU;   
SELECT * FROM ALL_OBJECTS 
    WHERE upper(Object_Type) = 'VIEW' AND upper(owner) = 'DBS301_191B30';
-- It is no longer in the data dictionary now.
-- Data dictionary is the objects you have already created already in the database.