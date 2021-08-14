--Dynamic SQL is a programming technique that enables you to build SQL statements dynamically at runtime. You can create more general purpose, 
--flexible applications by using dynamic SQL because the full text of a SQL statement may be unknown at compilation
--Dynamic SQL is the SQL statement that is constructed and executed at runtime based on input parameters passed.

DECLARE @CLIENT VARCHAR(6)
SET @CLIENT = 'C00003'
SELECT * FROM SALES_ORDER WHERE CLIENT_NO = @CLIENT


--USE IT A STORED PROCEDURE

CREATE PROC DYNAMIC_SQL_PROC (@CLIENT VARCHAR(6))
AS
BEGIN
      SELECT * FROM SALES_ORDER WHERE CLIENT_NO = @CLIENT
END

EXEC DYNAMIC_SQL_PROC 'C00002'

SELECT * FROM SALES_ORDER


---------


DECLARE @COL_LIST VARCHAR (MAX)
DECLARE @CITY VARCHAR (20)
DECLARE @SQL_STMT VARCHAR (MAX)

SET @COL_LIST = 'CLIENT_NO,NAME,STATE'
SET @CITY = '''BOMBAY'''
SET @SQL_STMT = 'SELECT ' + @COL_LIST + ' FROM CLIENT_MASTER WHERE CITY=' + @CITY

EXEC (@SQL_STMT)

SELECT * FROM CLIENT_MASTER
