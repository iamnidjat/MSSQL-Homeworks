USE Northwind;

-- Task1
--SELECT DISTINCT Title
--FROM Employees


-- Task2
--SELECT Title
--FROM Employees
--GROUP BY Title

-- Task3
--SELECT EmployeeID, ShipCountry , Count([EmployeeID]) AS CountOfOrders
--FROM Orders
--GROUP BY EmployeeID, ShipCountry
--ORDER BY EmployeeID

-- Task4
--SELECT Top(1) ShipCountry, Count([EmployeeID]) AS CountOfOrders
--FROM Orders
--GROUP BY ShipCountry
--ORDER BY CountOfOrders DESC

-- Task5
--SELECT ShippedDate, Count(ShipCountry) AS CountOfCountries
--FROM Orders
--WHERE ShippedDate IS NULL
--Group BY ShippedDate

-- Task6
--SELECT CustomerID
--FROM Customers AS C
--WHERE NOT EXISTS
--(
--	SELECT CustomerID
--	FROM Orders AS O
--	WHERE C.CustomerID = O.CustomerID
--)
--GROUP BY CustomerID

-- Task7
--SELECT OrderID, AVG(Freight) AS AvgFreight
--FROM Orders
--GROUP BY OrderID
--HAVING AVG(Freight) > (SELECT AVG(Orders.Freight) FROM Orders)

-- Task8
--SELECT OrderID, AVG(Discount) AS AvgDiscount
--FROM [Order Details]
--WHERE Discount > 0
--GROUP BY OrderID


