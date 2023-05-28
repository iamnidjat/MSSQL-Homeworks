USE Northwind;
 
-- Task1
--SELECT ContactName, City, Country
--FROM Customers AS C
--INNER JOIN [Orders] AS O ON C.CustomerID = O.CustomerID
--WHERE YEAR(O.OrderDate) > 1996
 
-- Task2
--SELECT ProductName, CategoryName, [Description]
--FROM Categories AS C
--INNER JOIN [Products] AS P ON C.CategoryID = P.CategoryID
--ORDER BY ProductName
 
-- Task3
--SELECT ContactName
--FROM Customers AS C
--LEFT JOIN [Orders] AS O ON C.CustomerID = O.CustomerID
--WHERE O.CustomerID IS NULL
 
-- Task4 Не смог довести до конца
--SELECT ProductName, CategoryName
--FROM Categories AS C
--INNER JOIN [Products] AS P ON C.CategoryID = P.CategoryID
--INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
--INNER JOIN [Orders] AS O ON OD.OrderID = O.OrderID
--WHERE O.Freight > (SELECT Sum((SELECT Top(10) Freight
--    FROM Orders
--    ORDER BY CustomerID))
--	FROM Orders)

-- Task5
--SELECT FirstName, COUNT(O.EmployeeID) AS CountOfOrders
--FROM Employees AS E
--INNER JOIN [Orders] AS O ON E.EmployeeID = O.EmployeeID
--WHERE YEAR(ShippedDate) = 1997
--GROUP BY FirstName