1.	Join is preferred over subquery because join is faster than subquery. In subquery you may need to group 
	by multiple columns which take extra time to execute.
2.	CTE is Common Table Expression in which query will be in readable form and can write recursive queries.
	It also solves one of the problems of derived table i.e., it is difficult to understand complex queries 
	while using derived table. The only problem with CTE is its life cycle. After creating CTE must be used 
	exactly into next select statement.
3.	Table variables store the set of records which can be used instead of temporary variables. Its scope is 
	that it cannot be used as parameter for input or output but useful in stored procedure, batch just like 
	local variables.
4.	The differences between DELETE and TRUNCATE are as follows.
	a.	DELETE is used to delete a specified row. And TRUNCATE is used to delete all the rows in a table.
	b.	DELETE has where clause whereas TRUNCATE does not.
	c.	TRUNCATE is faster than DELETE because it makes less use of the transaction log.
5.	Identity column is created automatically by database which identifies rows with different numbers. After
	DELETE identity column retains its identity on the other hand TRUNCATE will reset the identity of a column.
6.	Since there is no WHERE clause for delete it will delete all the rows of the table which is same as 
	TRUNCATE.


USE Northwind

--1
SELECT DISTINCT City FROM Customers WHERE City IN (SELECT DISTINCT City FROM Employees);

--or

SELECT DISTINCT c.City, c.ContactName, e.FirstName + ' ' +  e.LastName AS EmployeesName FROM Customers c
INNER JOIN Employees e
ON c.City = e.City

--2
--a
SELECT DISTINCT City FROM Customers WHERE City NOT IN (SELECT DISTINCT City FROM Employees);

--b
SELECT DISTINCT C.City AS Cities FROM Customers C
LEFT JOIN Employees E ON C.City = E.City
WHERE E.City IS NULL;

--3
SELECT od.ProductID,p.ProductName, SUM(od.Quantity) AS ProductQuantity  FROM [Order Details] od
RIGHT JOIN Products p
ON od.ProductID = p.ProductID
GROUP BY od.ProductID, p.ProductName
ORDER BY od.ProductID

--4
SELECT c.City, COUNT(od.ProductID) AS TotalProducts FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
LEFT JOIN [Order Details] od
ON o.OrderID = od.OrderID
GROUP BY c.City

--5
SELECT City, COUNT(CustomerID) AS TotalCustomers FROM Customers GROUP By City HAVING COUNT(CustomerID) >= 2;

--6
SELECT DISTINCT City FROM Customers WHERE CustomerID IN
(SELECT CustomerID FROM Orders WHERE OrderID IN
(SELECT OrderID FROM [Order Details] 
GROUP BY OrderID HAVING COUNT(ProductID) >= 2))

--or using join

SELECT c.City, COUNT(od.ProductID) as TotalProductsOrdered FROM Customers c
LEFT JOIN Orders o
ON c.CustomerID = o.CustomerID
LEFT JOIN [Order Details] od
ON o.OrderID = od.OrderID
GROUP BY c.City
HAVING COUNT(od.ProductID) > 2
ORDER BY c.City;

--7
SELECT DISTINCT c.CustomerID, c.ContactName, c.City, o.ShipCity FROM Customers c
INNER JOIN Orders o ON c.CustomerID = o.CustomerID
WHERE c.City <> o.ShipCity;

--8
SELECT dt2.ShipCity, P.ProductID, P.ProductName,P.UnitPrice As AveragePrice, dt2.ProductQuantity FROM Products P
RIGHT JOIN
(SELECT O.OrderID, O.ShipCity, dt.ProductID, dt.ProductQuantity
FROM Orders O RIGHT JOIN
(SELECT TOP 5 ProductID, OrderID, SUM(Quantity) AS ProductQuantity
FROM [Order Details] GROUP BY ProductID, OrderID ORDER BY ProductQuantity DESC) dt
ON O.OrderID= dt.OrderID) dt2
ON P.ProductID = dt2.ProductID

--9
--a
SELECT City FROM Employees WHERE City NOT IN (SELECT DISTINCT ShipCity FROM Orders);

--b
SELECT DISTINCT e.City FROM Employees e
LEFT JOIN Orders o
ON e.City = o.ShipCity
WHERE o.ShipCity IS NULL;

--10
SELECT TOP 1 ShipCity FROM Orders WHERE ShipCity-- ORDER BY COUNT(OrderID)
IN
(SELECT DISTINCT o.ShipCity--, SUM(od.Quantity) as TotalQty
FROM Orders o
INNER JOIN [Order Details] od
ON o.OrderID = od.OrderID
GROUP BY od.ProductID, o.ShipCity
ORDER BY SUM(od.Quantity) DESC)

--11
To remove the duplicate records of the table:
a) Using GROUP BY clause we can find duplicate rows and duplicate rows can be removed using detele statement
b) We can aslo create a new table with distinct records and delete the original table.



--12
We can list out distinct manager id and check if employee id is not there then those employee donot
manage anybody
SELECT empid FROM Employee NOT IN (SELECT DISTINCT mgrid FROM Employee);

--13
SELECT d.deptname, dt.TotalEmployees FROM Dept d INNER JOIN
(SELECT deptid, COUNT(empid) as TotalEmployees, dense_rank() over(
 ORDER BY COUNT(empid)) rnk FROM Employee GROUP BY deptid) dt
 ON d.deptid = dt.deptid
 WHERE dt.rnk = 1;

 --14
 SELECT d.deptname, dt.empid, dt.salary FROM Dept d
 INNER JOIN
 (SELECT deptid, empid, salary, DENSE_RANK() over(PARTITION BY deptid ORDER BY salary DESC) rnk
 FROM Employee WHERE rnk <=3) dt
 ON dt.deptid = d.deptid
 ORDER BY d.deptname;

 /*
SELECT * FROM Suppliers;
SELECT * FROM Customers;
SELECT * FROM EmployeeTerritories;
SELECT * FROM Employees;
SELECT * FROM Orders;
SELECT * FROM [Order Details];
SELECT * FROM Products;
SELECT * FROM Shippers;
*/