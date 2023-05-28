USE Northwind;
GO

--Task1
CREATE VIEW [GetCustomerNames]
AS
SELECT [ContactName] 
FROM [Customers]

--Task2
CREATE VIEW [GetEmployeeNames]
AS
SELECT [FirstName] 
FROM [Employees]

--Task3
CREATE VIEW [GetOrdersAndEmployees]
AS
SELECT ShipAddress, LastName, FirstName, Title
FROM Orders AS O
INNER JOIN [Employees] AS E ON O.EmployeeID = E.EmployeeID



--Task4
CREATE VIEW [GetAllProducts]
AS
SELECT CategoryName, ProductName, UnitPrice
FROM Categories AS C
INNER JOIN [Products] AS P ON C.CategoryID = P.CategoryID

--Task5
CREATE VIEW [GetProductsCount]
AS
SELECT CategoryName, COUNT(P.CategoryID) AS CountOfProducts
FROM Products AS P
INNER JOIN [Categories] AS C ON P.CategoryID = C.CategoryID
GROUP BY CategoryName

--Task6
CREATE VIEW [GetOrdersCount]
AS
SELECT ContactName, COUNT(OD.OrderID) AS CountOfOrders
FROM Customers AS C
INNER JOIN [Orders] AS O ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
GROUP BY ContactName

--Task7
CREATE VIEW [GetDiscountProducts]
AS
SELECT P.ProductName, P.UnitPrice, CategoryName
FROM Products AS P
INNER JOIN [Categories] AS C ON P.CategoryID = C.CategoryID
INNER JOIN [Order Details] AS OD ON P.ProductID = OD.ProductID
WHERE OD.Discount > 0

--Task8
CREATE VIEW [GetShippersName]
AS
SELECT CompanyName, COUNT(OD.OrderID) AS CountOfOrderrs
FROM Shippers AS S
INNER JOIN [Orders] AS O ON S.ShipperID = O.ShipVia
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
GROUP BY CompanyName

--Task9
CREATE VIEW [GetCountOrders]
AS
SELECT City, COUNT(OD.OrderID) AS CountOfOrders
FROM Customers AS C
INNER JOIN [Orders] AS O ON C.CustomerID = O.CustomerID
INNER JOIN [Order Details] AS OD ON O.OrderID = OD.OrderID
GROUP BY City


