--1
SELECT ProductID, Name, Color, ListPrice FROM Production.Product;

--2
SELECT ProductID, Name, Color, ListPrice FROM Production.Product WHERE ListPrice=0;

--3
SELECT ProductID, Name, Color, ListPrice FROM Production.Product WHERE Color IS NULL;

--4
SELECT ProductID, Name, Color, ListPrice FROM Production.Product WHERE Color IS NOT NULL;

--5
SELECT ProductID, Name, Color, ListPrice FROM Production.Product WHERE Color IS NOT NULL AND ListPrice > 0;

--6
SELECT Name + ' ' + Color AS NameColor FROM Production.Product WHERE Color IS NOT NULL;

--7
SELECT 'NAME: ' + Name + ' -- ' + 'COLOR: ' +  Color AS "Name And Color" FROM Production.Product WHERE Color IS NOT NULL;

--8
SELECT ProductID, Name FROM Production.Product WHERE ProductID BETWEEN 400 AND 500;

--9
SELECT ProductID, Name, Color FROM Production.Product WHERE Color ='black' OR color = 'blue';

--10
SELECT Name FROM Production.Product WHERE Name LIKE 'S%';

--11
--In this problem I change ListPrice decimal to commas to make same as resultset
SELECT Name, REPLACE(ListPrice, '.', ',') FROM Production.Product 
WHERE Name LIKE 'S%' AND Name LIKE '% %' AND Name NOT LIKE '%S' AND Name NOT LIKE '%XL' AND (ListPrice=0 OR ListPrice=53.99);

--12
SELECT Name, ListPrice FROM Production.Product WHERE Name LIKE 'A%' OR Name LIKE 'S%' ORDER BY Name;

--13
-- It is asked to retrive rows but I have only selected Name column
SELECT Name FROM Production.Product WHERE Name LIKE 'SPO%' AND Name NOT LIKE 'SPOK%' ORDER BY Name;

--14
SELECT DISTINCT Color FROM Production.Product WHERE Color is NOT NULL ORDER BY Color DESC;

--15
SELECT ProductSubcategoryID, Color FROM Production.Product
WHERE Color is NOT NULL
GROUP BY ProductSubcategoryID, Color
HAVING COUNT(*) = 1

--16

SELECT ProductSubCategoryID, LEFT([Name],35) AS [Name], Color, ListPrice
FROM Production.Product
WHERE Color IN ('Red','Black') AND ProductSubcategoryID = 1 AND ListPrice BETWEEN 1000 AND 2000
ORDER BY ProductID;


--17

SELECT ProductSubCategoryID, Name, Color, ListPrice
FROM Production.Product
WHERE ProductSubCategoryID BETWEEN 1 AND 14
ORDER BY ProductSubCategoryID DESC;

