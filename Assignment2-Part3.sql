USE Northwind

--14
--SELECT ProductID, ProductName, ReorderLevel FROM Products WHERE ReorderLevel <= 25;

--15
/*
SELECT TOP 5 ShipPostalCode, count(OrderID) TotalOrders  FROM Orders
WHERE ShipPostalCode IS NOT NULL GROUP BY ShipPostalCode ORDER BY TotalOrders DESC;
*/

--16
/*
SELECT TOP 5 ShipPostalCode, count(OrderID) TotalOrders  FROM Orders
WHERE ShipPostalCode IS NOT NULL AND (GETDATE() - YEAR(ShippedDate) <= 20) GROUP BY ShipPostalCode ORDER BY TotalOrders DESC;
*/

--17
--SELECT City, Count(CustomerID) TotalCustomers FROM Customers GROUP BY City;

--18
--SELECT City, Count(CustomerID) TotalCustomers FROM Customers GROUP BY City HAVING Count(*) > 10;

--19
/*
SELECT C.ContactName, O.OrderID FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
--WHERE O.OrderDate > Convert(datetime, '1998-1-1')
WHERE O.OrderDate > '1998-1-1'
*/

--20
/*
SELECT C.ContactName, O.OrderDate FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
ORDER BY O.OrderDate DESC
*/

--21
/*
SELECT C.ContactName, COUNT(O.OrderID) CountOfProducts FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.ContactName;
*/

--22
/*
SELECT C.CustomerID, COUNT(O.OrderID) CountOfProducts FROM Customers C
INNER JOIN Orders O
ON C.CustomerID = O.CustomerID
GROUP BY C.CustomerID
HAVING COUNT(O.OrderID) > 100;
*/

--23
--SELECT S.CompanyName AS 'Supplier Company Name', SH.CompanyName AS 'Shipping Company Name'  FROM Suppliers AS S CROSS JOIN Shippers As SH;

--24 
--There must be some relation between products and customer but can't find one.

--25
/*
SELECT E1.EmployeeID, E1.FirstName, E1.LastName, E2.EmployeeID, E2.FirstName, E2.LastName 
FROM Employees E1, Employees E2
WHERE E1.Title = E2.Title AND E1.EmployeeID <> E2.EmployeeID;
*/

--26
/*
SELECT ReportsTo AS Manager, COUNT(1) NoOfEmployees FROM Employees
GROUP BY ReportsTo
HAVING COUNT(1) > 2;
*/


--27
/*
SELECT C.City, C.CompanyName, C.ContactName, S.CompanyName, S.ContactName FROM Customers C
INNER JOIN Suppliers S ON C.City = S.City;
*/

--28
/*
SELECT * FROM F1.T1
CROSS JOIN F2.T2;

--29
SELECT * FROM F1.T1
LEFT JOIN F2.T2;

Result Set
1  NULL
2  NULL
3  NULL
*/
