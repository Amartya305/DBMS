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