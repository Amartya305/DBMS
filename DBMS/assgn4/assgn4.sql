SET SERVEROUTPUT ON ;
/*Accept an employee code from user.
 Find the name of the employee from EMP table. If the employee is
not existing then indicate it through a suitable message.*/
DECLARE
e_code EMP26.EMP_CODE%TYPE :=&EmployeeCode;
e_name EMP26.EMP_NAME%TYPE ;
BEGIN 
	SELECT EMP_NAME INTO e_name 
	FROM EMP26 
	WHERE EMP_CODE=e_code;
	dbms_output.put_line('Employee Name: ' || e_name);
EXCEPTION
	WHEN no_data_found THEN
	dbms_output.put_line('No employee found');
END;
/

/*Write a PL / SQL block to add row in EMP table .
 If employee code is duplicate/dept. code is not present
in DEPT table then message is to be shown &amp; row can not be added.
*/
DECLARE
e_code EMP26.EMP_CODE%TYPE :=&EmployeeCode;
e_name EMP26.EMP_NAME%TYPE :=&EmployeeName;
dept EMP26.DEPT_CODE%TYPE := &Dept;
CURSOR dept_cursor is 
	SELECT DEPT_CODE INTO dept
	FROM DEPARTMENT26 WHERE DEPT_CODE=dept;
BEGIN
	OPEN dept_cursor;
	FETCH dept_cursor INTO dept;
	IF dept_cursor%notfound THEN
		dbms_output.put_line('Invalid department');
	ELSE
		INSERT INTO EMP26(EMP_CODE,EMP_NAME,DEPT_CODE)
		VALUES(e_code,e_name,dept);
	END IF;	
EXCEPTION
	WHEN DUP_VAL_ON_INDEX THEN
	dbms_output.put_line('Duplicate primary index');
END;
/		

/*From the EMP table find the name 
of top 5 (according to basic salary) employees.*/
DECLARE
e_name EMP26.EMP_NAME%type ;
salary EMP26.BASIC%type;
count number(1);
CURSOR emp IS
	SELECT EMP_NAME,BASIC FROM EMP26 
	ORDER BY BASIC DESC;
BEGIN
	OPEN emp ;
	FOR COUNT IN 1..5 LOOP
	FETCH emp INTO e_name,salary;
	dbms_output.put_line(e_name||' '||salary);
	END LOOP;
END;
/

/*Accept a department code from the user. 
Delete all the employee rows with that department code. Show
how many rows have been deleted.*/
DECLARE
d_code DEPARTMENT26.DEPT_CODE%type := &dCODE;
BEGIN
	DELETE FROM EMP26
	WHERE DEPT_CODE=d_code;
	IF SQL%notfound THEN
	dbms_output.put_line('No employees in this department');
	ELSE 
	dbms_output.put_line('Rows deleted -' || sql%rowcount);
	END IF;
END;
/


/*Assume a LEAVE table with emp_no,month,no._of_days.
For each employee find the effective basic for the 
current month as per the formula given below:
BASIC - (BASIC * no. of leave days in the month)/no. 
of days in that month
*/

/*leave  table*/
CREATE TABLE LEAVE26(
	EMP_CODE char(5),
	MONTH char(3),
	DAYS int
	);


INSERT INTO LEAVE26 VALUES('#1001','APR',5);
INSERT INTO LEAVE26 VALUES('#1002','APR',25);
INSERT INTO LEAVE26 VALUES('#1003','APR',10);

DECLARE
e_code EMP26.EMP_CODE%TYPE ;
e_name EMP26.EMP_NAME%TYPE ;
basic EMP26.BASIC%type;
leaves LEAVE26.DAYS%type;
effective_basic real;
CURSOR c IS
	SELECT EMP26.EMP_CODE,EMP26.EMP_NAME,EMP26.BASIC,LEAVE26.DAYS
	FROM EMP26 LEFT JOIN LEAVE26
	ON EMP26.EMP_CODE=LEAVE26.EMP_CODE AND LEAVE26.MONTH='APR';
BEGIN
	OPEN c;
	LOOP
		FETCH c into e_code,e_name,basic,leaves;
		EXIT WHEN c%notfound;
		IF leaves IS NULL THEN
			effective_basic := basic;
		ELSE
			effective_basic := ( basic - (basic*leaves)/30 );
		END IF;		
	dbms_output.put_line(e_code || e_name || effective_basic );
	END LOOP;	
END;
/
