/* employee table*/
CREATE TABLE EMP26(
	EMP_CODE char(5) ,
	EMP_NAME char(20) ,
	DEPT_CODE char(5) ,
	DESIG_CODE char(5) ,
	SEX char(1) ,
	ADDRESS char(25) ,
	CITY char(20) ,
	STATE char(20) ,
	PIN char(6) ,
	BASIC Number ,
	JN_DT Date ,
	PRIMARY KEY(EMP_CODE)
);

/*designation table*/
CREATE TABLE DESIGNATION26(
	DESIG_CODE char(5),
	DESIG_DESC char(20),
	PRIMARY KEY(DESIG_CODE)
);

/*department table*/
CREATE TABLE DEPARTMENT26(
	DEPT_CODE char(5) ,
	DEPT_NAME char(15),
	PRIMARY KEY(DEPT_CODE)
);

/*table descriptions*/
DESCRIBE EMP26;
DESCRIBE DESIGNATION26;
DESCRIBE DEPARTMENT26;

/*designation table*/
INSERT INTO DESIGNATION26 
VALUES('MNGR','Manager') ;
INSERT INTO DESIGNATION26 
VALUES('EXEC','Executive') ;
INSERT INTO DESIGNATION26 
VALUES('OFFCR','Officer') ;
INSERT INTO DESIGNATION26 
VALUES('CLRK','Clrk') ;
INSERT INTO DESIGNATION26 
VALUES('HLPR','Helper') ;

/*department table*/
INSERT INTO DEPARTMENT26
VALUES('PERS','Personnel');
INSERT INTO DEPARTMENT26
VALUES('PROD','Production');
INSERT INTO DEPARTMENT26
VALUES('PURCH','Purchase');
INSERT INTO DEPARTMENT26
VALUES('FIN','Finance');
INSERT INTO DEPARTMENT26
VALUES('RES','Research');

/*employee table*/
INSERT INTO EMP26
VALUES ('#1001','Olivia','PURCH','EXEC','M','Jadavpur','Kolkata','West Bengal','700019',30000,'21-FEB-1985');

INSERT INTO EMP26
VALUES ('#1002','Jack','PERS','CLRK','M','Yelahanka','Bengaluru','Karnataka','562157',70000,'22-MAR-1986');

INSERT INTO EMP26
VALUES ('#1003','Thomas','FIN','MNGR','M','Garia','Kolkata','West Bengal','700029',20000,'23-APR-1988');

INSERT INTO EMP26
VALUES ('#1004','Nicole','RES','OFFCR','F','Pallakar','Thirunalveli','Kerala','400036',60000,'22-JAN-1990');

INSERT INTO EMP26 
VALUES ('#1005','Sofia','RES','HLPR','F','Dhakuria','Kolkata','West Bengal','700039',50000,'23-JAN-1990');

INSERT INTO EMP26 
VALUES ('#1006','Daniel','PROD','CLRK','M','Marine Drive','Mumbai','Maharashtra','800019',80000,'24-FEB-1991');

INSERT INTO EMP26 
VALUES ('#1007','Erin','PURCH','CLRK','F','BB lane','Pune','Maharashtra','800934',40000,'25-JAN-1992');

INSERT INTO EMP26 
VALUES ('#1008','Thomas','PURCH','MNGR','M','Haveli','Mumbai','Maharashtra','800023',100000,'19-FEB-1993');

INSERT INTO EMP26 
VALUES ('#1009','Molly','PROD','OFFCR','F','Haidar Bag','Mysore','Telengana','300039',40000,'21-FEB-1995');

INSERT INTO EMP26 
VALUES ('#1010','Maisie','FIN','EXEC','F','Halli','Bengaluru','Karnataka','563160',20000,'1-JAN-1996');

INSERT INTO EMP26 
VALUES ('#1011','Henry','RES','EXEC','M','Behala','Kolkata','West Bengal','700060',70000,'2-FEB-1996');

INSERT INTO EMP26 
VALUES ('#1012','Tyler','PERS','HLPR','M','Ali Square','New Delhi','Delhi','200001',50000,'6-JUN-1996');

INSERT INTO EMP26 
VALUES ('#1013','Jake','PERS','MNGR','M','Presidential Palace','New Delhi','Delhi','200002',20000,'12-JULY-1997');

INSERT INTO EMP26 
VALUES ('#1014','Matthew','PROD','MNGR','M','By the Ganges','Varanasi','Uttar Pradesh','900039',NULL,'17-SEP-1997');

INSERT INTO EMP26 
VALUES ('#1015','Oscar',NULL,'HLPR','M','Hazra','Kolkata','West Bengal','700069',50000,'13-NOV-1998');

INSERT INTO EMP26 
VALUES ('#1016','Hollie','RES','EXEC','F','Axis Mall','Durgapur','West Bengal','700134',0,'9-AUG-1999');

INSERT INTO EMP26 
VALUES ('#1017','Lydia',NULL,'OFCR','F','KCDS sq','Chennai','Tamil Nadu','100029',20000,'7-OCT-2000');

INSERT INTO EMP26 
VALUES ('#1018','Evelyn','PERS','CLRK','F','Bell Road','Chennai','Tamil Nadu','100019',0,'8-DEC-2000');

INSERT INTO EMP26 
VALUES ('#1019','Molly',NULL,'EXEC','F','VTU','Vellore','Tamil Nadu','100312',NULL,'11-JAN-2001');

INSERT INTO EMP26 
VALUES ('#1020','Daniella','FIN','MNGR','F','Ambedkar Road','Pune','Maharashtra','804123',140000,'28-MAY-2001');


/*Rows with unassigned dept code*/
SELECT * FROM EMP26 
WHERE DEPT_CODE IS NULL;

/*Rows with 0 basic*/
SELECT * FROM EMP26 
WHERE BASIC=0;

/*Rows with uassigned basic*/
SELECT * FROM EMP26 
WHERE BASIC IS NULL;

/*Average Basic of employees*/
SELECT AVG(BASIC) FROM EMP26;

/*Replace basic with 0 for unassigned basic*/
UPDATE EMP26 
SET BASIC=0 
WHERE BASIC IS NULL ;
SELECT * FROM EMP26 WHERE BASIC=0;

/*Average basic now*/
SELECT AVG(BASIC) FROM EMP26;

/*Delete rows with unassigned dept code*/
DELETE FROM EMP26
WHERE DEPT_CODE IS NULL;

/*Net Pay*/
SELECT EMP_NAME,1.9* BASIC AS NET_PAY FROM EMP26;

/*Employees in ascending order of dept*/
SELECT UPPER(EMP_NAME) 
AS EMP_NAME_UPPERCASE , BASIC,DEPT_CODE 
FROM EMP26 
ORDER BY DEPT_CODE ASC;

/*Employees joining after 1st Jan 1990*/
SELECT *  FROM EMP26 WHERE JN_DT > '1-JAN-1990';

/*Employees joining in January*/
SELECT COUNT(EMP_CODE) FROM EMP26 
WHERE EXTRACT(MONTH FROM JN_DT)=1;

/*Maximum  Basic*/
SELECT MAX(BASIC) FROM EMP26;

/*Minimum basic*/
SELECT MIN(BASIC) FROM EMP26;

/*Female employees*/
SELECT COUNT(EMP_CODE) FROM EMP26 
WHERE SEX='F';

/*convert city names to uppercase*/
UPDATE EMP26 
SET CITY = UPPER(CITY) ;

/* number of cities*/
SELECT COUNT (DISTINCT CITY) FROM EMP26;

/* employee information in the ascending order of DEPT_CODE and with in a Department, it
should be in the descending order of BASIC*/
SELECT EMP_CODE,EMP_NAME,DEPT_CODE,BASIC 
FROM EMP26
ORDER BY DEPT_CODE ASC,BASIC DESC ;
