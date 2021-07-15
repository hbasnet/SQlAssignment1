USE AdventureWorks2019

--1
SELECT COUNT(ProductID) as TotalNumberOfProducts FROM Production.Product;

--2
SELECT COUNT(ProductID) as TotalProductsInSubcategory FROM Production.Product WHERE ProductSubcategoryID IS NOT NULL;
--3
SELECT P.ProductSubcategoryID, COUNT(1) as CountedProducts FROM Production.Product P 
WHERE P.ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID;

--4
SELECT COUNT(1) as ProductsWithNoSubcategory FROM Production.Product P WHERE P.ProductSubcategoryID IS NULL;


--5
SELECT ProductID, SUM(Quantity) AS TheSum FROM Production.ProductInventory GROUP BY ProductID;

--6
SELECT ProductID, SUM(Quantity) AS TheSum FROM Production.ProductInventory 
WHERE LocationID = 40
GROUP BY ProductID
HAVING SUM(Quantity) < 100;

--7
SELECT Shelf, ProductID, SUM(Quantity) AS TheSum FROM Production.ProductInventory 
WHERE LocationID = 40
GROUP BY ProductID, Shelf
HAVING SUM(Quantity) < 100;

--8
SELECT ProductID, AVG(Quantity) AS TheAvg FROM Production.ProductInventory
WHERE LocationID=10
GROUP BY ProductID;

--9
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg FROM Production.ProductInventory
GROUP BY Shelf, ProductID;

--10
SELECT ProductID, Shelf, AVG(Quantity) AS TheAvg FROM Production.ProductInventory
GROUP BY Shelf, ProductID
HAVING Shelf <> 'N/A';

--11
SELECT Color, Class, Count(1) AS TheCount, AVG(ListPrice) AS AvgPrice FROM Production.Product
GROUP BY Color,Class
HAVING Color IS NOT NULL AND Class IS NOT NULL;

--Joins
--12
SELECT C.Name AS Country, StateProvinceCode AS Province FROM Person.CountryRegion AS C
INNER JOIN Person.StateProvince AS S ON C.CountryRegionCode = S.CountryRegionCode;

--13
SELECT C.Name AS Country, StateProvinceCode AS Province FROM Person.CountryRegion AS C
INNER JOIN Person.StateProvince AS S ON C.CountryRegionCode = S.CountryRegionCode
WHERE C.Name IN ('Germany','Canada');

