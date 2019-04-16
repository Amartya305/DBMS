/*Consider, the following relations:
RESULT(ROLL, SCODE, MARKS) BACKPAPER(ROLL, SCODE)
Write a trigger to do the following:
Whenever a row is inserted or updated in RESULT, if the marks is 50 or more, delete the
corresponding row, if any, from BACKPAPER. Otherwise insert a row in BACKPAPER if not
already present there.*/
CREATE TABLE RESULT26(
	ROLL int,
	SCODE char(5),
	MARKS int,
	PRIMARY KEY(ROLL,SCODE)
	);
CREATE TABLE BACKPAPER26(
	ROLL int,
	SCODE char(5)
	);
CREATE OR REPLACE TRIGGER bkppr_update
BEFORE INSERT OR UPDATE ON RESULT26 
FOR EACH ROW 
BEGIN 
	DELETE FROM BACKPAPER26 WHERE ROLL = :NEW.ROLL
							AND SCODE = :NEW.SCODE;
	IF  :NEW.MARKS<50  THEN
		INSERT INTO BACKPAPER26
		VALUES(:NEW.ROLL,:NEW.SCODE);
		RAISE_APPLICATION_ERROR(-20000,'failed');
	END IF;
END;
/