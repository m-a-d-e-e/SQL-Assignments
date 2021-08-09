SELECT * FROM PRODUCTS
SELECT * FROM ORDERS
SELECT * FROM CATEGORIES
SELECT * FROM CUSTOMERS
SELECT * FROM EMPLOYEES

--JOIN AND SUBQUERY ASSIGNMENT

--1  LIST ALL THE PRODUCTS DETAILS WHOSE CATEGORY IS SAME AS 'TOFU'

SELECT * FROM PRODUCTS WHERE CATEGORYID IN (SELECT CATEGORYID FROM PRODUCTS WHERE PRODUCTNAME='TOFU')

--2  LIST ALL THE PRODUCTS DETAILS FOR THE CATEGORY 'BEVERAGES'

SELECT * FROM PRODUCTS WHERE CATEGORYID IN (SELECT CATEGORYID FROM CATEGORIES WHERE CATEGORYNAME = 'BEVERAGES')

--3  LIST ALL THE ORDERS PLACED BY THE COMPANY NAME "ISLAND TRADING"

SELECT * FROM ORDERS WHERE CUSTOMERID IN (SELECT CUSTOMERID FROM CUSTOMERS WHERE CompanyName='ISLAND TRADING')

--4  LIST COMPANY NAME AND NO OF ORDER COUNT PLACED BY EACH COMPANY

SELECT COMPANYNAME, COUNT(ORDERID) AS TOTAL_ORDERS_PLACED  FROM CUSTOMERS C
LEFT JOIN ORDERS O
ON O.CUSTOMERID = C.CUSTOMERID
GROUP BY COMPANYNAME

--5  LIST ORDERID, CUSTOMER_COMAPNAYNAME FOR ALL THE ORDERS WHICH ARE HANDLE BY THE EMPLOYEES WHOSE TITLE IS "SALES MANAGER"

SELECT O.ORDERID , COMPANYNAME, TITLE
FROM ORDERS O
LEFT JOIN CUSTOMERS C
ON O.CUSTOMERID = C.CUSTOMERID
LEFT JOIN EMPLOYEES E
ON E.EMPLOYEEID = O.EMPLOYEEID
WHERE E.TITLE = 'SALES MANAGER'

--6  LIST 3RD HIGHEST COSTLIEST PRODUCT

;WITH HIGH3
AS(
SELECT DENSE_RANK() OVER(ORDER BY UNITPRICE DESC) AS DRNK, *  FROM PRODUCTS
)
SELECT * FROM HIGH3 WHERE DRNK=3;

--7  FOR THE PRODUCT TABLE DISPLAY PRODUCTNAME AND CATEGORYNAME. ARRANGE AS PER THE CATEGORYNAME

SELECT P.PRODUCTNAME, C.CATEGORYNAME
FROM PRODUCTS P
LEFT JOIN CATEGORIES C
ON P.CategoryID = C.CATEGORYID
ORDER BY C.CATEGORYNAME

--8  FOR THE ORDERS TABLE DISPLAY ORDERID CUSTOMER_COMPANYNAME AND EMPLOYEE_FULLNAME

SELECT O.ORDERID, C.COMPANYNAME AS CUSTOMER_COMPANYNAME , (E.FIRSTNAME + E.LASTNAME) AS EMPLOYEE_NAME
FROM ORDERS O
LEFT JOIN CUSTOMERS C
ON O.CUSTOMERID = C.CUSTOMERID
LEFT JOIN EMPLOYEES E
ON O.EMPLOYEEID = E.EMPLOYEEID

--9  LIST ORDERID, EMPLOYEE_FULLNAME, CUSTOMER_COMPANYNAME, CATEGORYNAME, SUPPLIER_COMPANYNAME, PRODUCTNAME, ORDERDETAIS_UNIRPRICE, ORDERDETAILS_QUANTITY , NETSTOCK

SELECT O.ORDERID, (E.FIRSTNAME + E.LASTNAME) AS EMPLOYEE_NAME, C.COMPANYNAME AS CUSTOMER_COMPANYNAME, CAT.CATEGORYNAME, S.COMPANYNAME AS SUPPLIER_COMPANYNAME,
P.PRODUCTNAME, OD.UNITPRICE, OD.QUANTITY,  P.UNITSINSTOCK
FROM ORDERS O
LEFT JOIN EMPLOYEES E
ON O.EMPLOYEEID = E.EMPLOYEEID
LEFT JOIN CUSTOMERS C
ON O.CUSTOMERID = C.CUSTOMERID
LEFT JOIN [ORDER DETAILS] OD
ON O.ORDERID = OD.ORDERID 
LEFT JOIN PRODUCTS P
ON OD.PRODUCTID = P.PRODUCTID
LEFT JOIN CATEGORIES CAT
ON P.CATEGORYID = CAT.CATEGORYID
LEFT JOIN SUPPLIERS S
ON P.SUPPLIERID = S.SUPPLIERID


--10  LIST ALL THE ORDERS (ORDERID, PRODUCTNAME) PLACED BY THE CUSTOMER IN LONDON

SELECT O.ORDERID, P.PRODUCTNAME, CITY
FROM ORDERS O
LEFT JOIN [ORDER DETAILS] OD
ON O.ORDERID = OD.ORDERID
LEFT JOIN PRODUCTS P
ON OD.PRODUCTID = P.PRODUCTID
LEFT JOIN CUSTOMERS C
ON C.CUSTOMERID = O.CUSTOMERID
WHERE C.CITY = 'LONDON'


--11  FOR THE COSTLIEST PRODUCT DISPLAY PRODUCTNAME, UNITPRICE, CATEGORYNAME, SUPPLIER_CONTACTNAME

SELECT PRODUCTNAME, UNITPRICE, CATEGORYNAME, CONTACTNAME AS SUPPLIER_CONTACTNAME
FROM PRODUCTS P
LEFT JOIN CATEGORIES C
ON P.CATEGORYID = C.CATEGORYID
LEFT JOIN SUPPLIERS S
ON P.SUPPLIERID = S.SUPPLIERID


--12  LIST ALL THE PRODUCTNAME WHOSE ORDER PLACED IN MONTH OF AUGUST

SELECT PRODUCTNAME FROM PRODUCTS WHERE PRODUCTID IN 
(SELECT PRODUCTID FROM [ORDER DETAILS] WHERE ORDERID IN 
(SELECT ORDERID FROM ORDERS WHERE DATENAME(MM,ORDERDATE)='AUGUST')) ORDER BY PRODUCTNAME


--13  LIST ORDERID, QUANTITY FOR ALL THE ORDERS. ASSIGNED RANK AS PER THE HIGHEST OT LOWEST QUANTITY. DO NOT MISS ANY NUMBER WHILE ASSIGNING THE RANK

SELECT DENSE_RANK() OVER(ORDER BY QUANTITY DESC) AS RNK, ORDERID, QUANTITY 
FROM [ORDER DETAILS]

--14 LIST ALL THE PRODUCTS FOR THE CATEGORY �DAIRY PRODUCT�

SELECT * FROM  PRODUCTS 
WHERE CATEGORYID IN (SELECT CATEGORYID FROM CATEGORIES WHERE CATEGORYNAME = 'DAIRY PRODUCTS')


--15 LIST ALL THE PRODUCTS WHICH IS SUPPLIED BY THE COMPANY �BIGFOOT BREWERIES�  FOR THE CATEGORY �BEVERAGES�

SELECT * FROM PRODUCTS WHERE SUPPLIERID IN (SELECT SUPPLIERID FROM SUPPLIERS WHERE COMPANYNAME='BIGFOOT BREWERIES')
AND CATEGORYID IN (SELECT CATEGORYID FROM CATEGORIES WHERE CATEGORYNAME = 'BEVERAGES')


--16 PRINT   CATEGORYNAME , SUPPLIER COMAPNY NAME  AND PRODUCT COUNT FOR EACH CATEGORY AND SUPPLIER

SELECT C.CATEGORYNAME, S.COMPANYNAME,  COUNT(PRODUCTID) AS PRODUCT_COUNT
FROM CATEGORIES C 
LEFT JOIN PRODUCTS P
ON C.CATEGORYID = P.CATEGORYID
LEFT JOIN SUPPLIERS S
ON P.SUPPLIERID = S.SUPPLIERID
GROUP BY CATEGORYNAME, S.COMPANYNAME
ORDER BY CATEGORYNAME


--17 PRINT REGION AND TERRITORYDESCRIPTION NAME IN ASCENDING ORDER

SELECT R.REGIONID, R.REGIONDESCRIPTION , T.TERRITORYDESCRIPTION 
FROM REGION R
LEFT JOIN TERRITORIES T
ON R.REGIONID = T.REGIONID

--18 PRINT  EMPLOYEES NAME, REGION NAME, CITY AND COUNTRY  --(CHECK FOR THE ERROR,  NO REGION RELATIONSHIP)

--------
SELECT * FROM EMPLOYEES
SELECT * FROM REGION
--------


--19 FOR EACH CATEGORIES PRINT CATEGORYNAME AND SUPPLIERS NAME

SELECT DISTINCT C.CATEGORYNAME, S.COMPANYNAME AS SUPPLIER_NAME
FROM CATEGORIES C
LEFT JOIN PRODUCTS P
ON C.CATEGORYID = P.CATEGORYID
LEFT JOIN SUPPLIERS S
ON P.SUPPLIERID = S.SUPPLIERID


--20 PRINT EMPLOYEE TITLEOFCOURTESY, EMPLOYEE FIRST + LASTNAME , EMPLOYEE TITLE, MANAGER TITLEOFCURTASY, MANAGER FIRSTNAME + LASTNAME, MANAGER TITLE

SELECT E.TITLEOFCOURTESY, (E.FIRSTNAME + ' ' + E.LASTNAME) AS NAME, E.TITLE , M.TITLEOFCOURTESY AS MGR_TITLEOFCOURTESY, (M.FIRSTNAME + ' ' + M.LASTNAME) AS MGRNAME, M.TITLE AS MGRTITLE
FROM EMPLOYEES E
LEFT JOIN EMPLOYEES M
ON E.REPORTSTO = M.EMPLOYEEID

-----------



SELECT * FROM PRODUCTS
SELECT * FROM ORDERS
SELECT * FROM CATEGORIES
SELECT * FROM CUSTOMERS
SELECT * FROM EMPLOYEES
SELECT * FROM SUPPLIERS
SELECT * FROM [ORDER DETAILS]
SELECT * FROM TERRITORIES
SELECT * FROM REGION


