CREATE TABLE CLIENT_MASTER(
CLIENT_NO VARCHAR(6) NOT NULL PRIMARY KEY CHECK (CLIENT_NO LIKE 'C%'),
NAME VARCHAR(20) NOT NULL,
CITY VARCHAR(15),
STATE VARCHAR(15),
PINCODE NUMERIC(6),
BAL_DUE NUMERIC (10,2)
)


CREATE TABLE PRODUCT_MASTER(
PRODUCT_NO VARCHAR(6) NOT NULL PRIMARY KEY CHECK (PRODUCT_NO LIKE 'P%' ),
DESCRIPTION VARCHAR(50) NOT NULL ,
PROFIT_PERCENT NUMERIC(3,2) NOT NULL,
UNIT_MEASURE VARCHAR(10) NOT NULL,
QTY_ON_HAND NUMERIC(8) NULL,
RECORD_LVL NUMERIC(8) NOT NULL,
SELL_PRICE NUMERIC(8,2) NOT NULL CHECK(SELL_PRICE > 0),
COST_PRICE NUMERIC(8,2) NOT NULL CHECK(COST_PRICE > 0)
)


CREATE TABLE SALESMAN_MASTER
(
SALESMAN_NO VARCHAR(6) PRIMARY KEY CHECK(SALESMAN_NO LIKE'S%'),
SALESMAN_NAME VARCHAR(20) NOT NULL,
ADDRESS1 VARCHAR(30) NOT NULL,
ADDRESS2 VARCHAR(30),
CITY VARCHAR(20),
PINCODE VARCHAR(6),
STATE VARCHAR(20),
SAL_AMT NUMERIC(8,2) NOT NULL CHECK(SAL_AMT>0),
TGT_TO_GET NUMERIC(6,2) NOT NULL CHECK(TGT_TO_GET>0),
YTD_SALES NUMERIC(6,2) NOT NULL,
REMARKS VARCHAR(60)
)



CREATE TABLE SALES_ORDER (

S_ORDER_NO VARCHAR(6) PRIMARY KEY CHECK (S_ORDER_NO LIKE 'O%'),
S_ORDER_DATE DATE,
CLIENT_NO VARCHAR(6) REFERENCES CLIENT_MASTER(CLIENT_NO),
DELY_ADDR VARCHAR(25),
SALESMAN_NO VARCHAR(6) REFERENCES SALESMAN_MASTER(SALESMAN_NO),
DELY_TYPE CHAR(1) DEFAULT 'F' CHECK (DELY_TYPE IN('P','F')),
BILLED_YN CHAR(1) DEFAULT 'N' CHECK (BILLED_YN IN ('N','Y')),
DELY_DATE DATE,
ORDER_STATUS VARCHAR(10) CHECK (ORDER_STATUS IN ('IN PROCESS','FULFILLED','BACKORDER','CANCELED'))
)


CREATE TABLE SALES_ORDER_DETAILS
(
S_ORDER_NO VARCHAR(6)  REFERENCES SALES_ORDER(S_ORDER_NO),
PRODUCT_NO VARCHAR(6) REFERENCES PRODUCT_MASTER(PRODUCT_NO),
QTY_ORDERED NUMERIC(8),
QTY_DISP NUMERIC(8),
PRODUCT_RATE NUMERIC(10,2)
)



CREATE TABLE CHALLAN_HEADER(
CHALLAN_NO VARCHAR(6) PRIMARY KEY CHECK (CHALLAN_NO LIKE 'CH%'),
S_ORDER_NO VARCHAR(6) REFERENCES SALES_ORDER(S_ORDER_NO),
CHALLAN_DATE DATE NOT NULL,
BILLED_YN CHAR(1) DEFAULT 'N' CHECK (BILLED_YN IN ('Y','N'))
)


CREATE TABLE CHALLAN_DETAILS(
CHALLAN_NO VARCHAR(6)  REFERENCES CHALLAN_HEADER(CHALLAN_NO),
PRODUCT_NO VARCHAR(6)  REFERENCES PRODUCT_MASTER(PRODUCT_NO),
QTY_DISP NUMERIC(4,2) NOT NULL ,
PRIMARY KEY(CHALLAN_NO ,PRODUCT_NO)
)






INSERT INTO CLIENT_MASTER VALUES('C00001', 'IVAN BAYROSS', 'BOMBAY','MAHARASHTRA', 400054, 15000)
INSERT INTO CLIENT_MASTER VALUES('C00002', 'VANDANA SAITWAL', 'MADRAS','TAMIL NADU', 780001, 0)
INSERT INTO CLIENT_MASTER VALUES('C00003', 'PRAMADA JAGUSTE', 'BOMBAY','MAHARASHTRA', 400057, 5000)
INSERT INTO CLIENT_MASTER VALUES('C00004', 'BASU NAVINDGI', 'BOMBAY','MAHARASHTRA', 400056, 0)
INSERT INTO CLIENT_MASTER VALUES('C00005', 'RAVI SHREEDHARAN', 'DELHI','DELHI', 100001, 2000)
INSERT INTO CLIENT_MASTER VALUES('C00006', 'RUKMINI', 'BOMBAY','MAHARASHTRA', 400050, 0)

INSERT INTO PRODUCT_MASTER VALUES('P00001','1.44 FLOPPIES', 5, 'PIECE', 100, 20, 525, 500)
INSERT INTO PRODUCT_MASTER VALUES('P03453','MONITORS', 6, 'PIECE', 10, 3, 12000, 11280)
INSERT INTO PRODUCT_MASTER VALUES('P06734','MOUSE', 5, 'PIECE', 20, 5, 1050, 1000)
INSERT INTO PRODUCT_MASTER VALUES('P07865','1.22 FLOPPIES', 5, 'PIECE', 100, 20, 525, 500)
INSERT INTO PRODUCT_MASTER VALUES('P07868','KEYBOARDS', 2, 'PIECE', 10, 3, 3150, 3050)
INSERT INTO PRODUCT_MASTER VALUES('P07885','CD DRIVE', 2.5, 'PIECE', 10, 3, 5250, 5100)
INSERT INTO PRODUCT_MASTER VALUES('P07965','540 HDD', 4, 'PIECE', 10, 3, 8400, 8000)
INSERT INTO PRODUCT_MASTER VALUES('P07975','1.44 DRIVE', 5, 'PIECE', 10, 3, 1050, 1000)
INSERT INTO PRODUCT_MASTER VALUES('P08865','1.22 DRIVE', 5, 'PIECE', 2, 3, 1050, 1000)


INSERT INTO SALESMAN_MASTER VALUES('S00001','KIRAN','A/14','WORLI','BOMBAY',400002,'MAHARASHTRA',3000,100,50,'GOOD')
INSERT INTO SALESMAN_MASTER VALUES('S00002','MANISH','65','NARIMAN','BOMBAY',400001,'MAHARASHTRA',3000,200,100,'GOOD')
INSERT INTO SALESMAN_MASTER VALUES('S00003','RAVI','P-7','BANDRA','BOMBAY',400032,'MAHARASHTRA',3000,200,100,'GOOD')
INSERT INTO SALESMAN_MASTER VALUES('S00004','ASHISH','A/5','JUHU','BOMBAY',400044,'MAHARASHTRA',3500,200,150,'GOOD')


INSERT INTO SALES_ORDER(S_ORDER_NO, S_ORDER_DATE, CLIENT_NO, DELY_TYPE, BILLED_YN, SALESMAN_NO, DELY_DATE, ORDER_STATUS)
VALUES ('O19001','12-JAN-1996','C00001','F','N','S00001','20-JAN-1996','IN PROCESS')

INSERT INTO SALES_ORDER(S_ORDER_NO, S_ORDER_DATE, CLIENT_NO, DELY_TYPE, BILLED_YN, SALESMAN_NO, DELY_DATE, ORDER_STATUS)
VALUES ('O19002','25-JAN-1996','C00002','P','N','S00002','27-JAN-1996','CANCELED')

INSERT INTO SALES_ORDER(S_ORDER_NO, S_ORDER_DATE, CLIENT_NO, DELY_TYPE, BILLED_YN, SALESMAN_NO, DELY_DATE, ORDER_STATUS)
VALUES ('O46865','18-FEB-1996','C00003','F','Y','S00003','20-FEB-1996','FULFILLED')

INSERT INTO SALES_ORDER(S_ORDER_NO, S_ORDER_DATE, CLIENT_NO, DELY_TYPE, BILLED_YN, SALESMAN_NO, DELY_DATE, ORDER_STATUS)
VALUES ('O19003','03-APR-1996','C00001','F','Y','S00001','07-APR-1996','FULFILLED')

INSERT INTO SALES_ORDER(S_ORDER_NO, S_ORDER_DATE, CLIENT_NO, DELY_TYPE, BILLED_YN, SALESMAN_NO, DELY_DATE, ORDER_STATUS)
VALUES ('O46866','20-MAY-1996','C00004','P','N','S00002','22-MAY-1996','CANCELED')

INSERT INTO SALES_ORDER(S_ORDER_NO, S_ORDER_DATE, CLIENT_NO, DELY_TYPE, BILLED_YN, SALESMAN_NO, DELY_DATE, ORDER_STATUS)
VALUES ('O10008','24-MAY-1996','C00005','F','N','S00004','26-MAY-1996','IN PROCESS')


INSERT INTO SALES_ORDER_DETAILS VALUES('O19001','P00001',4, 4, 525)
INSERT INTO SALES_ORDER_DETAILS VALUES('O19001','P07965',2, 1, 8400)
INSERT INTO SALES_ORDER_DETAILS VALUES('O19001','P07885',2, 1, 5250)
INSERT INTO SALES_ORDER_DETAILS VALUES('O19002','P00001',10, 0, 525)
INSERT INTO SALES_ORDER_DETAILS VALUES('O46865','P07868',3, 3, 3150)
INSERT INTO SALES_ORDER_DETAILS VALUES('O46865','P07885',3, 1, 5250)
INSERT INTO SALES_ORDER_DETAILS VALUES('O46865','P00001',10, 10, 525)
INSERT INTO SALES_ORDER_DETAILS VALUES('O46865','P03453',4, 4, 1050)
INSERT INTO SALES_ORDER_DETAILS VALUES('O19003','P03453',2, 2, 1050)
INSERT INTO SALES_ORDER_DETAILS VALUES('O19003','P06734',1, 1, 12000)
INSERT INTO SALES_ORDER_DETAILS VALUES('O46866','P07965',1, 0, 8400)
INSERT INTO SALES_ORDER_DETAILS VALUES('O46866','P07975',1, 0, 1050)
INSERT INTO SALES_ORDER_DETAILS VALUES('O10008','P00001',10, 5, 525)
INSERT INTO SALES_ORDER_DETAILS VALUES('O10008','P07975',5, 3, 1050)


INSERT INTO CHALLAN_HEADER VALUES ('CH9001','O19001','12-DEC-1995','Y')
INSERT INTO CHALLAN_HEADER VALUES ('CH6865','O46865','12-NOV-1995','Y')
INSERT INTO CHALLAN_HEADER VALUES ('CH3965','O10008','12-OCT-1995','Y')



INSERT INTO CHALLAN_DETAILS VALUES('CH9001','P00001',4)
INSERT INTO CHALLAN_DETAILS VALUES('CH9001','P07965',1)
INSERT INTO CHALLAN_DETAILS VALUES('CH9001','P07885',1)
INSERT INTO CHALLAN_DETAILS VALUES('CH6865','P07868',3)
INSERT INTO CHALLAN_DETAILS VALUES('CH6865','P03453',4)
INSERT INTO CHALLAN_DETAILS VALUES('CH6865','P00001',10)
INSERT INTO CHALLAN_DETAILS VALUES('CH3965','P00001',5)
INSERT INTO CHALLAN_DETAILS VALUES('CH3965','P07975',2)




-------------------------------

--1. Single table retrieval

--1) Find out the names of all the clients.

SELECT NAME FROM CLIENT_MASTER

--2) Print the entire client_master table.

SELECT * FROM CLIENT_MASTER

--3) Retrieve the list of names and the cities of all the clients

SELECT NAME, CITY FROM CLIENT_MASTER

--4) List the various products available from the product_master table.

SELECT DESCRIPTION FROM PRODUCT_MASTER

--5) Find the names of all clients having �a� as the second letter in their table.

SELECT NAME FROM CLIENT_MASTER WHERE NAME LIKE '_A%'

--6) Find the names of all clients who stay in a city whose second letter is �a�

SELECT NAME FROM CLIENT_MASTER WHERE CITY LIKE '_A%'

--7) Find out the clients who stay in a city �Bombay� or city �Delhi� or city �Madras�.

SELECT * FROM CLIENT_MASTER WHERE CITY IN ('BOMBAY','DELHI','MADRAS')

--8) List all the clients who are located in Bombay.

SELECT * FROM CLIENT_MASTER WHERE CITY='BOMBAY'

--9) Print the list of clients whose bal_due are greater than value 10000

SELECT * FROM CLIENT_MASTER WHERE BAL_DUE > 10000

--10) Print the information from sales_order table of orders placed in the month of January.

SELECT * FROM SALES_ORDER WHERE DATENAME(MM,S_ORDER_DATE)='JANUARY'

--11) Display the order information for client_no �C00001� and �C00002�

SELECT * FROM SALES_ORDER WHERE CLIENT_NO IN ('C00001','C00002')

--12) Find the products with description as �1.44 Drive� and �1.22 Drive�

SELECT * FROM PRODUCT_MASTER WHERE DESCRIPTION IN ('1.44 DRIVE','1.22 DRIVE')

--13) Find the products whose selling price is greater than 2000 and less than or equal to 5000

SELECT * FROM PRODUCT_MASTER WHERE SELL_PRICE > 2000 AND SELL_PRICE<=5000

--14) Find the products whose selling price is more than 1500 and also find the new selling price as original selling price * 15

SELECT *,(SELL_PRICE*15) AS NEW_SELLING_PRICE FROM PRODUCT_MASTER WHERE SELL_PRICE > 1500

--15) Rename the new column in the above query as new_price

SELECT *,(SELL_PRICE*15) AS NEW_PRICE FROM PRODUCT_MASTER WHERE SELL_PRICE > 1500

--16) Find the products whose cost price is less than 1500

SELECT * FROM PRODUCT_MASTER WHERE COST_PRICE < 1500

--17) List the products in sorted order of their description.

SELECT * FROM PRODUCT_MASTER ORDER BY DESCRIPTION

--18) Calculate the square root the price of each product.

SELECT *,SQRT(SELL_PRICE) AS SQRT_SELL, SQRT(COST_PRICE) AS SQRT_COST FROM PRODUCT_MASTER  

--19) Divide the cost of product �540 HDD� by difference between its price and 100

SELECT (COST_PRICE/(SELL_PRICE-100)) FROM PRODUCT_MASTER WHERE DESCRIPTION='540 HDD'

--20) List the names, city and state of clients not in the state of Maharashtra

SELECT NAME, CITY, STATE FROM CLIENT_MASTER WHERE STATE!='MAHARASHTRA'

--21) List the product_no, description, sell_price of products whose description begin with letter �M�

SELECT PRODUCT_NO, DESCRIPTION, SELL_PRICE FROM PRODUCT_MASTER WHERE DESCRIPTION LIKE 'M%'

--22) List all the orders that were canceled in the month of May.SELECT * FROM SALES_ORDER WHERE ORDER_STATUS = 'CANCELED' AND DATENAME(MM,S_ORDER_DATE)='MAY'


--2. Set Functions and Concatenation :

--23) Count the total numeric of orders.

SELECT COUNT(S_ORDER_NO) AS TOTAL_NO_OF_ORDERS FROM SALES_ORDER

--24) Calculate the average price of all the products.

SELECT AVG(SELL_PRICE) AS AVERAGE_PRICE FROM PRODUCT_MASTER

--25) Calculate the minimum price of products.

SELECT MIN(SELL_PRICE) AS MINIMUM_PRICE FROM PRODUCT_MASTER

--26) Determine the maximum and minimum product prices. Rename the title as max_price and min_price respectively.

SELECT MIN(SELL_PRICE) AS MIN_PRICE, MAX(SELL_PRICE) AS MAX_PRICE FROM PRODUCT_MASTER

--27) Count the numeric of products having price greater than or equal to 1500.

SELECT COUNT(PRODUCT_NO) FROM PRODUCT_MASTER WHERE SELL_PRICE >= 1500

--28) Find all the products whose qty_on_hand is less than reorder level.

SELECT * FROM PRODUCT_MASTER WHERE QTY_ON_HAND < RECORD_LVL

--29) Print the information of client_master, product_master, sales_order table in the following formate for all the records
--{cust_name} has placed order {order_no} on {s_order_date}

SELECT C.NAME + ' HAS PLACED ORDER ' + CAST(S.S_ORDER_NO AS VARCHAR) +' ON ' + CAST(S.S_ORDER_DATE AS VARCHAR) 
FROM CLIENT_MASTER C
JOIN SALES_ORDER S
ON C.CLIENT_NO = S.CLIENT_NO



--3. Having and Group by:

--30) Print the description and total qty sold for each product

SELECT P.DESCRIPTION, SUM(S.QTY_ORDERED)
FROM PRODUCT_MASTER P
LEFT JOIN SALES_ORDER_DETAILS S
ON P.PRODUCT_NO=S.PRODUCT_NO
GROUP BY DESCRIPTION

--31) Find the value of each product sold.

SELECT COST_PRICE FROM PRODUCT_MASTER WHERE PRODUCT_NO IN (SELECT PRODUCT_NO FROM SALES_ORDER)

--32) Calculate the average qty sold for each client that has a maximum order value of 15000.00

SELECT SO.CLIENT_NO ,AVG(SD.QTY_ORDERED) 
FROM SALES_ORDER_DETAILS SD
LEFT JOIN SALES_ORDER SO
ON SD.S_ORDER_NO = SO.S_ORDER_NO
GROUP BY CLIENT_NO
HAVING SUM(QTY_ORDERED*PRODUCT_RATE) <= 15000


--33) Find out the total sales amount receivable for the month of jan. it will be the sum total of all the billed orders for the month.

SELECT SUM(SD.QTY_ORDERED*SD.PRODUCT_RATE) 
FROM SALES_ORDER_DETAILS SD
LEFT JOIN SALES_ORDER SO
ON SD.S_ORDER_NO = SO.S_ORDER_NO
GROUP BY DATENAME(MM,S_ORDER_DATE)
HAVING DATENAME(MM,S_ORDER_DATE)='JANUARY'


--34) Print the information of product_master, order_detail table in the following format for all the records
--{Description} worth Rs. {Total sales for the product} was sold.

SELECT P.DESCRIPTION + ' WORTH RS. ' + CAST(SUM(S.QTY_ORDERED) AS VARCHAR) + ' WAS SOLD' 
FROM PRODUCT_MASTER P
JOIN SALES_ORDER_DETAILS S
ON P.PRODUCT_NO = S.PRODUCT_NO
GROUP BY DESCRIPTION


--35) Print the information of product_master, order_detail table in the following format for all the records
--{Description} worth Rs. {Total sales for the product} was produced in the month of {s_order_date} in month formate.
SELECT P.DESCRIPTION + ' WORTH RS. ' + CAST(SUM(SD.QTY_ORDERED) AS VARCHAR) + ' WAS PRODUCED IN THE MONTH OF ' + CAST(DATENAME(MM,S.S_ORDER_DATE)AS VARCHAR)
FROM PRODUCT_MASTER P
JOIN SALES_ORDER_DETAILS SD
ON P.PRODUCT_NO = SD.PRODUCT_NO
JOIN SALES_ORDER S
ON SD.S_ORDER_NO = S.S_ORDER_NO
GROUP BY DESCRIPTION, DATENAME(MM,S_ORDER_DATE)
ORDER BY DESCRIPTION




--4. Joins and Correlation :

--36) Find out the products which has been sold to �Ivan Bayross�

SELECT P.* FROM PRODUCT_MASTER P
LEFT JOIN SALES_ORDER_DETAILS SD
ON P.PRODUCT_NO = SD.PRODUCT_NO
LEFT JOIN SALES_ORDER S
ON SD.S_ORDER_NO = S.S_ORDER_NO
LEFT JOIN CLIENT_MASTER C
ON S.CLIENT_NO = C.CLIENT_NO
WHERE NAME = 'IVAN BAYROSS'


--37) Find out the products and their quantities that will have to deliver in the current month.

SELECT P.DESCRIPTION, SUM(SD.QTY_ORDERED) 
FROM PRODUCT_MASTER P
JOIN SALES_ORDER_DETAILS SD
ON P.PRODUCT_NO = SD.PRODUCT_NO
LEFT JOIN SALES_ORDER S
ON SD.S_ORDER_NO = S.S_ORDER_NO
WHERE MONTH(DELY_DATE) = MONTH(GETDATE())
GROUP BY DESCRIPTION


--38) Find the product_no and description of moving products.

SELECT PRODUCT_NO, DESCRIPTION FROM PRODUCT_MASTER WHERE PRODUCT_NO IN 
(SELECT PRODUCT_NO FROM  SALES_ORDER_DETAILS WHERE S_ORDER_NO IN 
(SELECT S_ORDER_NO FROM SALES_ORDER WHERE ORDER_STATUS = 'IN PROCESS'))

--39) Find the names of clients who have purchased �CD Drive�

SELECT NAME FROM CLIENT_MASTER WHERE CLIENT_NO IN 
(SELECT CLIENT_NO FROM SALES_ORDER WHERE S_ORDER_NO IN 
(SELECT S_ORDER_NO FROM SALES_ORDER_DETAILS WHERE PRODUCT_NO IN
(SELECT PRODUCT_NO FROM PRODUCT_MASTER WHERE DESCRIPTION = 'CD DRIVE')))


--40) List the product_no and s_order_no of customers having qty_ordered less than 5 from the order details table for the product �1.44 floppies�

SELECT PRODUCT_NO, S_ORDER_NO FROM SALES_ORDER_DETAILS 
WHERE QTY_ORDERED < 5 AND PRODUCT_NO IN (SELECT PRODUCT_NO FROM PRODUCT_MASTER WHERE DESCRIPTION = '1.44 FLOPPIES')


--41) Find the products and their quantities for the orders placed by �Vandana Saitwal� and �Ivan Bayross�

SELECT P.DESCRIPTION, SD.QTY_ORDERED,C.NAME FROM  PRODUCT_MASTER P
JOIN SALES_ORDER_DETAILS SD
ON P.PRODUCT_NO = SD.PRODUCT_NO
LEFT JOIN SALES_ORDER S
ON SD.S_ORDER_NO = S.S_ORDER_NO
LEFT JOIN CLIENT_MASTER C
ON S.CLIENT_NO = C.CLIENT_NO
WHERE NAME IN ('VANDANA SAITWAL','IVAN BAYROSS')


--42) Find the products and their quantities for the orders placed by client_no �C00001� and �C00002�

SELECT P.DESCRIPTION, SD.QTY_ORDERED,S.CLIENT_NO FROM  PRODUCT_MASTER P
JOIN SALES_ORDER_DETAILS SD
ON P.PRODUCT_NO = SD.PRODUCT_NO
LEFT JOIN SALES_ORDER S
ON SD.S_ORDER_NO = S.S_ORDER_NO
WHERE S.CLIENT_NO IN ('C00001', 'C00002')




--5. Nested Queries :

--43) Find the product_no and description of non-moving products.

SELECT PRODUCT_NO, DESCRIPTION FROM PRODUCT_MASTER WHERE PRODUCT_NO IN 
(SELECT PRODUCT_NO FROM  SALES_ORDER_DETAILS WHERE S_ORDER_NO IN 
(SELECT S_ORDER_NO FROM SALES_ORDER WHERE ORDER_STATUS != 'IN PROCESS'))

--44) Find the customer name, address1, address2, city and pin code for the client who has placed order no �O19001�

SELECT C.NAME, SM.ADDRESS1, SM.ADDRESS2, SM.CITY, SM.PINCODE
FROM CLIENT_MASTER C
LEFT JOIN SALES_ORDER SO
ON C.CLIENT_NO = SO.CLIENT_NO
LEFT JOIN SALESMAN_MASTER SM
ON SO.SALESMAN_NO = SM.SALESMAN_NO
WHERE S_ORDER_NO = 'O19001'


--45) Find the client names who have placed orders before the month of May, 1996

SELECT NAME FROM CLIENT_MASTER WHERE CLIENT_NO IN (SELECT CLIENT_NO FROM SALES_ORDER WHERE S_ORDER_DATE < '01-MAY-1996')


--46) Find out if product �1.44 Drive� is ordered by client and print the client_no, name to whom it is was sold.

SELECT CLIENT_NO, NAME FROM CLIENT_MASTER WHERE CLIENT_NO IN 
(SELECT CLIENT_NO FROM SALES_ORDER WHERE S_ORDER_NO IN
(SELECT S_ORDER_NO FROM SALES_ORDER_DETAILS WHERE PRODUCT_NO IN
(SELECT PRODUCT_NO FROM PRODUCT_MASTER WHERE DESCRIPTION = '1.44 DRIVE')))

--47) Find the names of clients who have placed orders worth Rs. 10000 or more.

SELECT NAME FROM CLIENT_MASTER WHERE CLIENT_NO IN 
(SELECT CLIENT_NO FROM SALES_ORDER WHERE S_ORDER_NO IN 
(SELECT S_ORDER_NO FROM SALES_ORDER_DETAILS WHERE (QTY_ORDERED*PRODUCT_RATE) >= 10000))





--6. Queries using Date:

--48) Display the order numeric and day on which clients placed their order.

SELECT S_ORDER_NO, DATENAME(DW,S_ORDER_DATE) AS DAY FROM SALES_ORDER
ORDER BY DATEPART(DW,S_ORDER_DATE)


--49) Display the month (in alphabets) and date when the order must deliver.

SELECT DATENAME(MM,DELY_DATE) AS MONTH, DELY_DATE FROM SALES_ORDER
ORDER BY DATEPART(MM,DELY_DATE)


--50) Display the s_order_date in the format. E.g. 12-February-1996 

SELECT CAST(DATEPART(DD,S_ORDER_DATE) AS VARCHAR) + '-' + DATENAME(MM,S_ORDER_DATE) + '-' + CAST(DATEPART(YYYY,S_ORDER_DATE) AS VARCHAR) FROM SALES_ORDER

--51) Find the date, 15 days after today�s date.

SELECT DATEADD(DD,15,GETDATE()) AS [DATE AFTER 15 DAYS]

--52) Find the numeric of days elapsed between today�s date and the delivery date of the orders placed by the clients.SELECT DATEDIFF(DD,DELY_DATE,GETDATE()) FROM SALES_ORDER



--7. Misc (Rank, Case)

--53. In sales ordered detail table as pet the quantity ordered highest to lowest assign the rank. Don�t miss any numeric

SELECT DENSE_RANK() OVER(ORDER BY QTY_ORDERED) AS RANK,* FROM SALES_ORDER_DETAILS 

--54. Display product master record along with record no

SELECT * FROM PRODUCT_MASTER

--55. For sales ordered detail table assign row numeric for each s_order_no. 

SELECT ROW_NUMBER() OVER(PARTITION BY S_ORDER_NO ORDER BY S_ORDER_NO ) AS ROW_NUMBER,* FROM SALES_ORDER_DETAILS

--56. Print s_order_no, qty ordered, qty disp, and difference. Also display message if difference is 0 print all qty dispatched , 
--if difference is <=5 few qty left to dispatched, else display difference is high

SELECT S_ORDER_NO, QTY_ORDERED, QTY_DISP, (QTY_ORDERED-QTY_DISP) AS DIFF, CASE
                                          WHEN (QTY_ORDERED-QTY_DISP) = 0 THEN 'ALL DISPATCHED' 
										  WHEN (QTY_ORDERED-QTY_DISP) <= 5 THEN 'FEW QTY LEFT TO DISPATCH'
										  ELSE 'DIFFERENCE IS HIGH'
										  END AS MSG
 FROM SALES_ORDER_DETAILS

--57. List salesman master detail along with rank as per the sal_amt

SELECT RANK() OVER(ORDER BY SAL_AMT) AS RANK ,* FROM SALESMAN_MASTER




--8. Table Updations:

--58) Change the s_order_date of client_no �C00001� to 24/07/96.

UPDATE SALES_ORDER SET S_ORDER_DATE = CONVERT(DATE,'24/07/96',3)  WHERE CLIENT_NO = 'C00001'

--59) Change the selling price of �1.44 Floppy Drive� to Rs. 1150.00

UPDATE PRODUCT_MASTER SET SELL_PRICE = 1150.00 WHERE DESCRIPTION = '1.44 FLOPPY DRIVE'

--60) Delete the records with order numeric �O19001� from the order table.

DELETE FROM SALES_ORDER WHERE S_ORDER_NO = 'O19001'

--ERROR -- The DELETE statement conflicted with the REFERENCE constraint "FK__SALES_ORD__S_ORD__0A688BB1"

ALTER TABLE SALES_ORDER_DETAILS DROP CONSTRAINT FK__SALES_ORD__S_ORD__0A688BB1

ALTER TABLE SALES_ORDER_DETAILS ADD CONSTRAINT FK__SALES_ORD__S_ORD FOREIGN KEY (S_ORDER_NO) REFERENCES SALES_ORDER(S_ORDER_NO) ON DELETE SET NULL

DELETE FROM SALES_ORDER WHERE S_ORDER_NO = 'O19001'

--ERROR -- The DELETE statement conflicted with the REFERENCE constraint "FK__CHALLAN_H__S_ORD__0F2D40CE"

ALTER TABLE CHALLAN_HEADER DROP CONSTRAINT FK__CHALLAN_H__S_ORD__0F2D40CE

ALTER TABLE CHALLAN_HEADER ADD CONSTRAINT FK__CHALLAN_H__S_ORD__0F2D40CE FOREIGN KEY (S_ORDER_NO) REFERENCES SALES_ORDER(S_ORDER_NO) ON DELETE SET NULL

DELETE FROM SALES_ORDER WHERE S_ORDER_NO = 'O19001'


--61) Delete all the records having delivery date before 10th July�96

DELETE FROM SALES_ORDER WHERE DELY_DATE < '1996-07-10'

--62) Change the city of client_no �C00005� to �Bombay�.

UPDATE CLIENT_MASTER SET CITY = 'BOMBAY' WHERE CLIENT_NO= 'C00005'

--63) Change the delivery date of order numeric �O10008� to 16/08/96

UPDATE SALES_ORDER SET DELY_DATE = CONVERT(DATE,'16/08/96',3) WHERE S_ORDER_NO='O10008'

--64) Change the bal_due of client_no �C00001� to 1000

UPDATE CLIENT_MASTER SET BAL_DUE = 1000 WHERE CLIENT_NO='C00001'

--65) Change the cost price of �1.22 Floppy Drive� to Rs. 950.00.

UPDATE PRODUCT_MASTER SET COST_PRICE=950.00 WHERE DESCRIPTION = '1.22 FLOPPY DRIVE'





--9. Views
--66.Create a read only view which will display Client name, city and balance due

CREATE VIEW DISP_CLIENTS 
AS
SELECT NAME, CITY, BAL_DUE FROM CLIENT_MASTER;

SELECT * FROM DISP_CLIENTS

--67.Create a read only view which will display salesman name, city, sales amount, target to get

CREATE VIEW SALESMAN
AS
SELECT SALESMAN_NAME, CITY, SAL_AMT, TGT_TO_GET FROM SALESMAN_MASTER;

SELECT * FROM SALESMAN

--68.Create a view which display client name, salesman name s_oreder_no and order status

CREATE VIEW DISP
AS
SELECT C.NAME AS CLIENT, S.SALESMAN_NAME AS SALESMAN, SO.S_ORDER_NO, SO.ORDER_STATUS  FROM CLIENT_MASTER C
LEFT JOIN SALES_ORDER SO
ON C.CLIENT_NO = SO.CLIENT_NO
LEFT JOIN SALESMAN_MASTER S
ON SO.SALESMAN_NO = S.SALESMAN_NO

SELECT * FROM DISP


--69.From the sales order details table display product wise quantity ordered

SELECT PRODUCT_NO, SUM(QTY_ORDERED) FROM SALES_ORDER_DETAILS
GROUP BY PRODUCT_NO

--70.Create view which display all billed challan detail

CREATE VIEW BILLED_CHALLAN
AS
SELECT * FROM CHALLAN_HEADER
WHERE BILLED_YN = 'Y'
WITH CHECK OPTION;

SELECT * FROM BILLED_CHALLAN





--10.Stored Procedure (for all the procedure handle required error)

--71.Write a procedure which takes client name and display a client record from client master table.

CREATE PROCEDURE CLIENT_DETAILS (@CNAME VARCHAR(20))
AS
BEGIN
      IF (EXISTS (SELECT CLIENT_NO FROM CLIENT_MASTER WHERE NAME = @CNAME))
	  BEGIN
            SELECT * FROM CLIENT_MASTER WHERE NAME = @CNAME
	  END
	  ELSE
	      RAISERROR ('INVALID CLIENT NAME..NO SUCH CLIENT EXISTS',16,1)
END

EXEC CLIENT_DETAILS 'RUKMINI'


--72.Take city name as parameter and display all client name and the balance due and at the end total balance due from the city (total of balance_due)

ALTER PROCEDURE CITY (@CITY VARCHAR(20))
AS
BEGIN
     IF (EXISTS (SELECT CITY FROM CLIENT_MASTER WHERE CITY = @CITY))
	 BEGIN
            SELECT NAME, BAL_DUE FROM CLIENT_MASTER WHERE CITY=@CITY
            SELECT SUM(BAL_DUE) AS TOTAL_BALANCE_DUE FROM CLIENT_MASTER WHERE CITY=@CITY
	 END
	 ELSE 
	     RAISERROR ('NO RECORD FOR THAT CITY EXISTS',16,1)
END

EXEC CITY 'BOMBAY'
EXEC CITY 'ABCG'


--73.Write a procedure which takes product description as a parameter and display the details

CREATE PROCEDURE PRODUCT_DETAILS (@DESCRIP VARCHAR(20))
AS
BEGIN
     IF (EXISTS (SELECT PRODUCT_NO FROM PRODUCT_MASTER WHERE DESCRIPTION = @DESCRIP))
	 BEGIN
          SELECT * FROM PRODUCT_MASTER WHERE DESCRIPTION = @DESCRIP
	 END
	 ELSE
	      RAISERROR ('INVALID PRODUCT DESCRIPTION',16,1)
END

EXEC PRODUCT_DETAILS 'MOUSE'
EXEC PRODUCT_DETAILS 'WATCH'


--74.Write a procedure which will take quantify on hand as parameter and display all products greater then the value

CREATE PROCEDURE PROD_QTY(@QTY INT)
AS
BEGIN
      IF (@QTY < 0)
	  BEGIN
	       RAISERROR ('QUANTITY CANNOT BE NEGATIVE',16,1)
	  END
	  ELSE
	  BEGIN 
          SELECT * FROM PRODUCT_MASTER WHERE QTY_ON_HAND > @QTY
      END
END

EXEC PROD_QTY 15


--75.Write a procedure which will display details for all �Floppies� product

CREATE PROCEDURE FLOPPIES 
AS
BEGIN
    SELECT * FROM PRODUCT_MASTER WHERE DESCRIPTION LIKE '%FLOPPIES%'
END

EXEC FLOPPIES


--76.Write a procedure which takes client name and display S_order_date, Order Status.

ALTER PROCEDURE CLIENT_ORDER_STATUS (@CNAME VARCHAR(20))
AS
BEGIN
     IF (EXISTS (SELECT CLIENT_NO FROM CLIENT_MASTER WHERE NAME = @CNAME))
	 BEGIN
         SELECT S_ORDER_DATE, ORDER_STATUS FROM SALES_ORDER WHERE CLIENT_NO IN (SELECT CLIENT_NO FROM CLIENT_MASTER WHERE NAME = @CNAME)
	 END
	 ELSE
	     RAISERROR ('INVALID CLIENT NAME...NO SUCH CLIENT EXISTS',16,1)
END

EXEC CLIENT_ORDER_STATUS 'IVAN BAYROSS'
EXEC CLIENT_ORDER_STATUS 'JOHN'

--77. Write a procedure which print salesman name, whose Ytd sales > 100

CREATE PROCEDURE SALESMAN_YTD 
AS
BEGIN
      SELECT SALESMAN_NAME FROM SALESMAN_MASTER WHERE YTD_SALES > 100
END

EXEC SALESMAN_YTD


--78. Take a two S_order_date parameters and display all sales detail between two dates.

ALTER PROCEDURE SALES_BTWN (@DATE1 DATE, @DATE2 DATE)
AS
BEGIN
     IF (@DATE1 > @DATE2)
	 BEGIN
	     RAISERROR ('DATES ARE NOT VALID...',16,1)
	 END
	 ELSE
	 BEGIN
          SELECT * FROM SALES_ORDER WHERE S_ORDER_DATE BETWEEN @DATE1 AND  @DATE2
	 END
END

EXEC SALES_BTWN '1996-01-01','1996-05-01'
EXEC SALES_BTWN '1996-05-01','1996-01-01'


--79. Take bill_y/n as a parameter and list all order details like S_order_no, S_order_date, salesman name, order status

ALTER PROCEDURE BILL (@BILL CHAR(1))
AS
BEGIN
    IF (@BILL IN ('Y','N'))
	BEGIN
		SELECT SO.S_ORDER_NO, SO.S_ORDER_DATE, SM.SALESMAN_NAME, SO.ORDER_STATUS
		FROM SALES_ORDER SO
		LEFT JOIN SALESMAN_MASTER SM
		ON SO.SALESMAN_NO = SM.SALESMAN_NO
		WHERE BILLED_YN = @BILL
	END
	ELSE
	    RAISERROR ('INVALID BILL',16,1)
END

EXEC BILL 'Y'
EXEC BILL 'H'


--80. Takes S_order_no as a parameter and display product description and salesman name

ALTER PROCEDURE PROD_SALMAN (@SNO VARCHAR(6))
AS
BEGIN
      IF (EXISTS (SELECT S_ORDER_NO FROM SALES_ORDER WHERE S_ORDER_NO = @SNO))
	  BEGIN
		  SELECT P.DESCRIPTION, SM.SALESMAN_NAME FROM SALES_ORDER SO
		  LEFT JOIN SALESMAN_MASTER SM
		  ON SO.SALESMAN_NO = SM.SALESMAN_NO
		  LEFT JOIN SALES_ORDER_DETAILS SD
		  ON SO.S_ORDER_NO= SD.S_ORDER_NO
		  LEFT JOIN PRODUCT_MASTER P
		  ON SD.PRODUCT_NO = P.PRODUCT_NO
		  WHERE SO.S_ORDER_NO = @SNO
	  END
	  ELSE
	     RAISERROR ('INVALID ORDER NO.',16,1)
END

EXEC PROD_SALMAN 'O19003'
EXEC PROD_SALMAN 'HGJ090'


--81. Take client name as parameter and display S_order_no, S_order_date, salesman name, order status, product description, qty ordered, product 
--rate and total (qty ordered * product rate)

ALTER PROCEDURE CLIENT_ORDERS (@CNAME VARCHAR(20))
AS
BEGIN
     IF (EXISTS (SELECT CLIENT_NO FROM CLIENT_MASTER WHERE NAME = @CNAME))
	 BEGIN
		 SELECT SO.S_ORDER_NO, SO.S_ORDER_DATE, SM.SALESMAN_NAME, SO.ORDER_STATUS, P.DESCRIPTION, SD.QTY_ORDERED, SD.PRODUCT_RATE, (SD.QTY_ORDERED*SD.PRODUCT_RATE) AS TOTAL
		 FROM SALES_ORDER SO
		 LEFT JOIN SALESMAN_MASTER SM
		 ON SO.SALESMAN_NO = SM.SALESMAN_NO
		 LEFT JOIN SALES_ORDER_DETAILS SD
		 ON SO.S_ORDER_NO = SD.S_ORDER_NO
		 LEFT JOIN PRODUCT_MASTER P
		 ON SD.PRODUCT_NO = P.PRODUCT_NO
		 WHERE CLIENT_NO IN (SELECT CLIENT_NO FROM CLIENT_MASTER WHERE NAME = @CNAME)
	 END
	 ELSE
	    RAISERROR ('NO SUCH CLIENT EXISTS',16,1)
END

EXEC CLIENT_ORDERS 'VANDANA SAITWAL'
EXEC CLIENT_ORDERS 'VJL'


--82. List order details (order no, client name, salesman name, product description) where qty ordered is >= 10 

CREATE PROCEDURE O_DEAILS 
AS
BEGIN
      SELECT S.S_ORDER_NO , C.NAME, SM.SALESMAN_NAME, P.DESCRIPTION
	  FROM SALES_ORDER S
	  LEFT JOIN SALESMAN_MASTER SM
	  ON S.SALESMAN_NO = SM.SALESMAN_NO
	  LEFT JOIN CLIENT_MASTER C
	  ON S.CLIENT_NO = C.CLIENT_NO
	  LEFT JOIN SALES_ORDER_DETAILS SD
	  ON S.S_ORDER_NO = SD. S_ORDER_NO
	  LEFT JOIN PRODUCT_MASTER P
	  ON SD.PRODUCT_NO = P.PRODUCT_NO
	  WHERE SD.QTY_ORDERED >= 10
END

EXEC O_DEAILS


--83.Take challan no and print details (order no, challan date, client name, salesman name, order date, order status)

ALTER PROCEDURE CHALLANNO_DETAILS (@CNO VARCHAR(6))
AS
BEGIN
     IF (EXISTS (SELECT * FROM CHALLAN_DETAILS WHERE CHALLAN_NO = @CNO))
	 BEGIN
		 SELECT C.S_ORDER_NO, C.CHALLAN_DATE , CM.NAME, SM.SALESMAN_NAME, S.S_ORDER_DATE, S.ORDER_STATUS
		 FROM CHALLAN_HEADER C
		 LEFT JOIN SALES_ORDER S
		 ON C.S_ORDER_NO = S.S_ORDER_NO
		 LEFT JOIN CLIENT_MASTER CM
		 ON S.CLIENT_NO = CM.CLIENT_NO
		 LEFT JOIN SALESMAN_MASTER SM
		 ON S.SALESMAN_NO = SM.SALESMAN_NO
		 WHERE C.CHALLAN_NO = @CNO
	 END
	 ELSE
	    RAISERROR ('INVALID CHALLAN NO',16,1)
END

EXEC CHALLANNO_DETAILS 'CH3965'
EXEC CHALLANNO_DETAILS 'OJHS001'


--84.Take challan date month as a parameter and display challan detail like s_order_no, s_order_date, bill y/n, delay_date, order status

CREATE PROCEDURE CHALLAN_MNTH (@CMNTH VARCHAR(10))
AS
BEGIN
     IF (@CMNTH IN ('JANUARY','FEBRUARY','MARCH','APRIL','MAY','JUNE','JULY','AUGUST','SEPTEMBER','OCTOBER','NOVEMBER','DECEMBER'))
	 BEGIN
		 SELECT C.S_ORDER_NO, S.S_ORDER_DATE, S.BILLED_YN, S.DELY_DATE, S.ORDER_STATUS FROM CHALLAN_HEADER C
		 LEFT JOIN SALES_ORDER S
		 ON C.S_ORDER_NO = S.S_ORDER_NO
		 WHERE DATENAME(MM,C.CHALLAN_DATE) = @CMNTH
	 END
	 ELSE
	    RAISERROR ('INVALID MONTH',16,1)
END

EXEC CHALLAN_MNTH 'NOVEMBER'


--85.Take product no as parameter and print all the orders for the products like s_order_no, client name, salesman name
CREATE PROCEDURE PROD (@PNO VARCHAR(6))
AS
BEGIN
    IF (EXISTS (SELECT S_ORDER_NO FROM SALES_ORDER_DETAILS WHERE PRODUCT_NO = @PNO ))
	BEGIN
		SELECT S.S_ORDER_NO, C.CLIENT_NO, SM.SALESMAN_NAME FROM SALES_ORDER S
		LEFT JOIN CLIENT_MASTER C
		ON S.CLIENT_NO = C.CLIENT_NO
		LEFT JOIN SALESMAN_MASTER SM
		ON S.SALESMAN_NO = SM.SALESMAN_NO
		WHERE S.S_ORDER_NO IN (SELECT S_ORDER_NO FROM SALES_ORDER_DETAILS WHERE PRODUCT_NO = @PNO)
		END
	ELSE
	  RAISERROR ('INVALID PRODUCT NUMBER',16,1)
END

EXEC PROD 'P00001'
EXEC PROD 'HELS'


--86.Write a procedure which print order no and order date for the salesman kiran

CREATE PROC SALESMAN_KIRAN 
AS
BEGIN
    SELECT S_ORDER_NO,S_ORDER_DATE FROM SALES_ORDER WHERE SALESMAN_NO IN (SELECT SALESMAN_NO FROM SALESMAN_MASTER WHERE SALESMAN_NAME='KIRAN')
END

EXEC SALESMAN_KIRAN


--87. Write a procedure which takes order no as parameter and return in out parameter total qty ordered and total qty dispatched for the order (table sales_order)

ALTER PROC INOUT (@ONO VARCHAR(6), @QTY_ORD INT OUT, @QTY_DISP INT OUT)
AS
BEGIN
      IF (EXISTS (SELECT * FROM SALES_ORDER_DETAILS WHERE S_ORDER_NO = @ONO))
	  BEGIN
           SELECT @QTY_ORD = SUM(QTY_ORDERED), @QTY_DISP = SUM(QTY_DISP) FROM SALES_ORDER_DETAILS WHERE S_ORDER_NO = @ONO
	  END
	  ELSE
	     RAISERROR ('INVALID ORDER NO',16,1)
END


DECLARE @ORDERED INT, @DISPATCHED INT
EXEC INOUT 'O19003', @ORDERED OUT, @DISPATCHED OUT
SELECT @ORDERED AS TOTAL_QTY_ORDERED ,@DISPATCHED AS TOTAL_QTY_DISPATCHED


--88. Write a procedure which display product description cost price, sales price and profit amount (cost price � sales price). 
--At the end display total profit amount

CREATE PROCEDURE DISP_PROD
AS
BEGIN
     SELECT DESCRIPTION, COST_PRICE, SELL_PRICE, (SELL_PRICE - COST_PRICE) AS PROFIT FROM PRODUCT_MASTER
	 SELECT SUM(SELL_PRICE - COST_PRICE) AS TOTAL_PROFIT FROM PRODUCT_MASTER
END

EXEC DISP_PROD


--89.Display all the product detail where reorder level is below 5

CREATE PROC REORDER 
AS
BEGIN
    SELECT * FROM PRODUCT_MASTER WHERE RECORD_LVL < 5
END

EXEC REORDER

--90. Take sales order no check if qty dispatched is less than qty ordered than display product description , qty ordered, qty dispatched and the difference else print the message all qty dispatched.

ALTER PROC QTY (@ONO VARCHAR(6))
AS
BEGIN
     IF (EXISTS(SELECT * FROM SALES_ORDER_DETAILS WHERE S_ORDER_NO=@ONO))
	 BEGIN
	       IF (EXISTS ( SELECT * FROM SALES_ORDER_DETAILS WHERE S_ORDER_NO=@ONO AND QTY_DISP < QTY_ORDERED  ))
		   BEGIN
	           SELECT * FROM SALES_ORDER_DETAILS WHERE S_ORDER_NO=@ONO AND QTY_DISP < QTY_ORDERED  
		   END
		   ELSE
		   BEGIN
		        PRINT 'ALL QTY DISPATCHED'
		   END
	 END
	 ELSE
           RAISERROR ('INVALID ORDER NO',16,1)
END

EXEC QTY 'O10008'
EXEC QTY 'O19003'
EXEC QTY 'HO9199'



--11. Functions
--91. Take the city name and return total no of customer count in the city

CREATE FUNCTION CUST_COUNT (@CITY VARCHAR(20))
RETURNS INT
AS
BEGIN
     RETURN (SELECT COUNT(CLIENT_NO) FROM CLIENT_MASTER WHERE CITY=@CITY)
END

SELECT DBO.CUST_COUNT('BOMBAY')

--92. Take salesman name and return total order count 

CREATE FUNCTION ORDER_COUNT (@SNAME VARCHAR(20))
RETURNS INT
AS
BEGIN
     RETURN (SELECT COUNT(S_ORDER_NO) FROM SALES_ORDER WHERE SALESMAN_NO IN (SELECT SALESMAN_NO FROM SALESMAN_MASTER WHERE SALESMAN_NAME = @SNAME))
END

SELECT DBO.ORDER_COUNT('MANISH')

--93. Write a function which takes salesman name and return target to get.

CREATE FUNCTION TARTGET (@SNAME VARCHAR(20))
RETURNS NUMERIC(6,2)
AS
BEGIN
     RETURN (SELECT TGT_TO_GET FROM SALESMAN_MASTER WHERE SALESMAN_NAME=@SNAME)
END

SELECT DBO.TARTGET('KIRAN')

--94.Write a function which will return total target to get by all the salesman

CREATE FUNCTION TOTAL_TARTGET ()
RETURNS NUMERIC(6,2)
AS
BEGIN
     RETURN (SELECT SUM(TGT_TO_GET) FROM SALESMAN_MASTER )
END

SELECT DBO.TOTAL_TARTGET()


--95. Take order status as a parameter and return total order count for the order status

CREATE FUNCTION ORDER_STATUS_COUNT (@STATUS VARCHAR(10))
RETURNS INT
AS
BEGIN
      RETURN (SELECT COUNT(S_ORDER_NO) FROM SALES_ORDER WHERE ORDER_STATUS=@STATUS)
END

SELECT DBO.ORDER_STATUS_COUNT('FULFILLED')

--96. Take year and month as a parameter to a function and return order count

CREATE FUNCTION MNTHYR_ORDER_COUNT (@YR INT, @MNTH VARCHAR(10))
RETURNS INT
AS
BEGIN
      RETURN (SELECT COUNT(S_ORDER_NO) FROM SALES_ORDER WHERE YEAR(S_ORDER_DATE) = @YR AND DATENAME(MM,S_ORDER_DATE)=@MNTH)
END

SELECT DBO.MNTHYR_ORDER_COUNT(1996,'MAY')

--97.Take s_order_no as a parameter to a function and return total bill amount 

CREATE FUNCTION TOTAL_BILL(@ONO VARCHAR(6))
RETURNS NUMERIC 
AS
BEGIN
      RETURN (SELECT SUM(QTY_ORDERED*PRODUCT_RATE) FROM SALES_ORDER_DETAILS WHERE S_ORDER_NO=@ONO)
END


SELECT DBO.TOTAL_BILL('O19002')

--98. Return total salesman count in the city Mumbai

CREATE FUNCTION SALESMAN_MUMBAI ()
RETURNS INT
AS
BEGIN
    RETURN (SELECT COUNT(SALESMAN_NO) FROM SALESMAN_MASTER WHERE CITY = 'BOMBAY')
END

SELECT DBO.SALESMAN_MUMBAI()

--99.Take state name and return total client in the state

CREATE FUNCTION CLIENT_IN_STATE(@STATE VARCHAR(20))
RETURNS INT
AS
BEGIN
     RETURN (SELECT COUNT(CLIENT_NO) FROM CLIENT_MASTER WHERE STATE = @STATE)
END

SELECT DBO.CLIENT_IN_STATE('MAHARASHTRA')

--100. Take city name as parameter and return total amount of balance due for the city

CREATE FUNCTION BAL_DUE_CITY(@CITY VARCHAR(20))
RETURNS INT
AS 
BEGIN
     RETURN (SELECT SUM(BAL_DUE) FROM CLIENT_MASTER WHERE CITY=@CITY) 
END

SELECT DBO.BAL_DUE_CITY('BOMBAY')



----
SELECT * FROM PRODUCT_MASTER
SELECT * FROM SALES_ORDER
SELECT * FROM SALES_ORDER_DETAILS
SELECT * FROM SALESMAN_MASTER
SELECT * FROM CLIENT_MASTER
SELECT * FROM CHALLAN_DETAILS
SELECT * FROM CHALLAN_HEADER







----------------------



--Observation
--Before deleting any table create the copy of the table
--How to create copy of an existing table is your assignment. 


--WE CAN CREATE A COPY OF AN EXISTING TABLE USING THE 'SELECT * INTO [NEW TABLE NAME] FROM [OLD TABLE NAME]' STATEMENT


--1) Add the following record into the challan_details table and check if the records get added or not. Note the observation for each of them
--    CH9001    P00001   5
--    P785341   P06734   9
--    P00001    CH9001   1

INSERT INTO CHALLAN_DETAILS VALUES ('CH9001','P00001',5)
--INSERT FAILS BECAUSE THE CHALLAN_N0 COLUMN REFERS TO THE CHALLAN_NO COLUMN PRESENT IN THE CHALLAN_HEADER TABLE
--AND IN THE CHALLAN_HEADER TABLE NO RECORD FOR CHALLAN_NO - 'CH9001' WAS FOUND

INSERT INTO CHALLAN_DETAILS VALUES ('P785341','P06734',9)
--INSERT FAILS BECAUSE THE MAXIMUM LENGTH ALLOTED TO CHALLAN_N0 COLUMN IS OF 6 CHARACTERS 
--WHILE WE ARE ATTEMPTING TO INSERT A VALUE WHOSE LENGTH IS GREATER THAN 6 CHARACTERS
 
INSERT INTO CHALLAN_DETAILS(PRODUCT_NO, CHALLAN_NO, QTY_DISP) VALUES ('P00001','CH9001',1)
--INSERT FAILS BECAUSE THE CHALLAN_N0 COLUMN REFERS TO THE CHALLAN_NO COLUMN PRESENT IN THE CHALLAN_HEADER TABLE
--AND IN THE CHALLAN_HEADER TABLE NO RECORD FOR CHALLAN_NO - 'CH9001' WAS FOUND


--2) Drop the table product_master. Can the product_master be dropped. If not, Note the error message.

--DROP TABLE PRODUCT_MASTER

--THE TABLE PRODUCT_MASTER CANNOT BE DROPPED BECAUSE OTHER TABLES REFERENCES ONE OR MORE COLUMNS OF THIS TABLE 
--THE FOREIGN KEY CONSTRAINT RESTRICTS THE DELETION OF THE THIS TABLE


--3) Drop the table challan_details, challan_header and product_master in specified sequence.


SELECT * INTO PRODUCT_MASTER_COPY FROM PRODUCT_MASTER

SELECT * INTO CHALLAN_HEADER_COPY FROM CHALLAN_HEADER

SELECT * INTO CHALLAN_DETAILS_COPY FROM CHALLAN_DETAILS

DROP TABLE CHALLAN_DETAILS
DROP TABLE CHALLAN_HEADER
DROP TABLE PRODUCT_MASTER



--4) What conclusions can you draw, performing the above tasks

--WE CAN DROP THE TABLES CHALLAN_DETAILS AND CHALLAN_HEADER TABLES IN THE GIVEN SEQUENCE
--BUT WE CANNOT DROP THE PRODUCT_MASTER TABLE BECAUSE IT'S REFERENCE IS USED IN THE SALES_ORDER_DETAILS TABLES




