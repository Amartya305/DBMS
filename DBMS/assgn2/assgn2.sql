/*From the EMP table show the 
minimum, maximum and average basic for each
department (show dept. Code).*/
SELECT DEPT_CODE,MIN(BASIC),MAX(BASIC),AVG(BASIC)
FROM EMP26
GROUP BY DEPT_CODE;

/*Find the number of female employees
 in each department (show dept. Code).*/
 SELECT DEPT_CODE,COUNT(*) AS females
 FROM EMP26
 WHERE SEX ='F'
 GROUP BY DEPT_CODE;

/*Find the city wise no. of 
employees for each department (show dept. Code).*/
SELECT DEPT_CODE,CITY,COUNT(*) AS employees
FROM EMP26
GROUP BY DEPT_CODE,CITY
ORDER BY DEPT_CODE ASC;

/* designation wise no of employees 
who have joined in the year 2000 in each
department.*/
SELECT DEPT_CODE,DESIG_CODE,COUNT(*) AS employees
FROM EMP26
WHERE EXTRACT(YEAR FROM JN_DT) = 2000
GROUP BY DEPT_CODE,DESIG_CODE
ORDER BY employees ASC;

/*department code wise total basic of 
male employees only for the departments
for which such total is more than 200,000*/
SELECT DEPT_CODE,SUM(BASIC) AS total
FROM EMP26
WHERE SEX='M'
GROUP BY DEPT_CODE
HAVING SUM(BASIC) >50000
ORDER BY SUM(BASIC) DESC;

/*employee name,
 Designation description
 and basic for all employees.*/
SELECT EMP26.EMP_NAME,DESIGNATION26.DESIG_DESC,EMP26.BASIC
FROM EMP26 LEFT JOIN DESIGNATION26 
ON EMP26.DESIG_CODE = DESIGNATION26.DESIG_CODE;

/*employee name,
 Designation description,department name 
 and basic for all employees.*/
SELECT EMP26.EMP_NAME,DESIGNATION26.DESIG_DESC,
	  DEPARTMENT26.DEPT_NAME,EMP26.BASIC
FROM EMP26 LEFT JOIN DESIGNATION26 
	ON EMP26.DESIG_CODE = DESIGNATION26.DESIG_CODE
		LEFT JOIN DEPARTMENT26
			ON EMP26.DEPT_CODE = DEPARTMENT26.DEPT_CODE;

/*dept codes in which no employee work*/
SELECT DEPT_CODE FROM DEPARTMENT26 
WHERE NOT EXISTS(
	SELECT * FROM EMP26 
	WHERE EMP26.DEPT_CODE = DEPARTMENT26.DEPT_CODE
);

/*dept names in which at least one employee work*/
SELECT DEPT_NAME FROM DEPARTMENT26 
WHERE EXISTS(
	SELECT * FROM EMP26 
	WHERE EMP26.DEPT_CODE = DEPARTMENT26.DEPT_CODE
);

/*dept names in which at least 4 employees work*/
SELECT DEPT_NAME FROM DEPARTMENT26 
WHERE 4 < =(
	SELECT COUNT(*) FROM EMP26 
	WHERE EMP26.DEPT_CODE = DEPARTMENT26.DEPT_CODE
);

/*department code in which employee with highest Basic works*/
SELECT DEPT_CODE FROM EMP26
WHERE BASIC > = ALL(
		SELECT BASIC FROM EMP26
	);

/*Designation description of the employee with highest basic.*/
SELECT DESIG_DESC FROM DESIGNATION26 
WHERE DESIG_CODE = ( 
			SELECT DISTINCT DESIG_CODE FROM EMP26
			WHERE BASIC > = ALL(
				SELECT BASIC FROM EMP26
			)
		);
/*no of managers in each dept*/
SELECT DEPT_CODE,COUNT(*) AS managers
FROM EMP26
WHERE DESIG_CODE='MNGR'
GROUP BY DEPT_CODE ;

/*maximum basic from EMP table without using MAX().*/
SELECT DISTINCT BASIC FROM EMP26 
WHERE BASIC NOT IN (
	SELECT SMALLER.BASIC FROM 
	EMP26 SMALLER , EMP26 LARGER
	WHERE SMALLER.BASIC < LARGER.BASIC 
	);
/*minimum basic from EMP table without using MIN().*/
SELECT DISTINCT BASIC FROM EMP26 
WHERE BASIC NOT IN (
	SELECT LARGER.BASIC FROM 
	EMP26 SMALLER ,EMP26 LARGER
	WHERE SMALLER.BASIC < LARGER.BASIC 
	);

/*Department with highest total basic*/
WITH DEPT_TOTAL AS(
SELECT DEPT_CODE,SUM(BASIC) AS TOTAL
FROM EMP26
GROUP BY DEPT_CODE
)

SELECT DEPT_NAME FROM DEPARTMENT26
WHERE DEPT_CODE IN (
		SELECT  DEPT_CODE FROM DEPT_TOTAL
		WHERE TOTAL = ( SELECT MAX(TOTAL) FROM DEPT_TOTAL)
);

/*Departmemnt with highest average basic*/
WITH DEPT_AVG AS(
SELECT DEPT_CODE,AVG(BASIC) AS AVG
FROM EMP26
GROUP BY DEPT_CODE
)

SELECT DEPT_NAME FROM DEPARTMENT26
WHERE DEPT_CODE IN (
		SELECT  DEPT_CODE FROM DEPT_AVG
		WHERE AVG = ( SELECT MAX(AVG) FROM DEPT_AVG)
);

/*Departmemnt with highest employees*/
WITH DEPT_COUNT AS(
SELECT DEPT_CODE,COUNT(*) AS employees
FROM EMP26
GROUP BY DEPT_CODE
)

SELECT DEPT_NAME FROM DEPARTMENT26
WHERE DEPT_CODE IN (
		SELECT  DEPT_CODE FROM DEPT_COUNT
		WHERE employees = ( SELECT MAX(employees) FROM DEPT_COUNT)
);

/*row with invalid designation code insertion*/
INSERT INTO EMP26 
VALUES ('#1021','Lynn','PERS','XXX','M','Eden Gardens','Kolkata','West Bengal','763160',80000,'1-JAN-2003');
INSERT INTO EMP26 
VALUES ('#1022','Chris','RES','YYY','M','Eden Gardens','Kolkata','West Bengal','763160',20000,'2-JAN-2003');
INSERT INTO EMP26 
VALUES ('#1023','Russel','FIN','ZZZ','M','Eden Gardens','Kolkata','West Bengal','763160',60000,'3-JAN-2003');

/*row with invalid designation code deletion*/
DELETE FROM EMP26
WHERE DESIG_CODE NOT IN (
	SELECT EMP26.DESIG_CODE 
	FROM EMP26 JOIN DESIGNATION26 
	ON EMP26.DESIG_CODE = DESIGNATION26.DESIG_CODE
);

/*the name of the female employees 
with basic greater than the average basic of
their respective department.*/
WITH DEPT_AVG AS(
SELECT DEPT_CODE,AVG(BASIC) AS AVG
FROM EMP26
GROUP BY DEPT_CODE
)
SELECT COUNT(*) AS femaleCount FROM 
EMP26 JOIN DEPT_AVG
ON EMP26.DEPT_CODE = DEPT_AVG.DEPT_CODE
   AND EMP26.BASIC > DEPT_AVG.AVG
WHERE SEX = 'F';

/*number of female managers*/
SELECT COUNT(*) AS femalCount FROM EMP26
WHERE SEX='F' AND DESIG_CODE='MNGR';