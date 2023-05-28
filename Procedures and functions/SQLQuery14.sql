USE Northwind;
 
GO
-- TASK 1.1
CREATE PROCEDURE AddEmployee(@LastName AS NVARCHAR(255), @FirstName AS NVARCHAR(255), @Title AS NVARCHAR(255), @TitleOfCourtesy AS NVARCHAR(255), @BirthDate AS DATETIME, @HireDate AS DATETIME, @Address AS NVARCHAR(255), @City AS NVARCHAR(255), @Region AS NVARCHAR(255), @PostalCode AS NVARCHAR(255), @Country AS NVARCHAR(255), @HomePhone AS NVARCHAR(255), @Extension AS NVARCHAR(255), @Photo AS IMAGE, @Notes AS NTEXT, @ReportsTo AS INT, @PhotoPath AS NVARCHAR(255))
AS
BEGIN
    INSERT Employees VALUES
    (@LastName, @FirstName, @Title, @TitleOfCourtesy, @BirthDate, @HireDate, @Address, @City, @Region, @PostalCode, @Country, @HomePhone, @Extension, @Photo, @Notes, @ReportsTo, @PhotoPath)
END
 
EXECUTE AddEmployee N'Name', N'Surname', N'Nobody', N'Mr.', 'Sep 09 12:18:52 2014', 'Sep 09 12:18:52 2017', N'WBHFHWNFN', N'Baku', N'WA', N'12345', N'Azerbaijan', N'XXX-XXX-XXXX', N'2345', NULL, N'Student at STEP IT', 2, NULL
 
GO
--TASK 1.2
CREATE PROCEDURE AddCustomer(@CustomerID AS NVARCHAR(255), @CompanyName AS NVARCHAR(255), @ContactName AS NVARCHAR(255), @ContactTitle AS NVARCHAR(255), @Address AS NVARCHAR(255), @City AS NVARCHAR(255), @Region AS NVARCHAR(255), @PostalCode AS NVARCHAR(255), @Country AS NVARCHAR(255), @Phone AS NVARCHAR(255), @Fax AS NVARCHAR(255))
AS
BEGIN
    INSERT Customers VALUES
    (@CustomerID, @CompanyName, @ContactName, @ContactTitle, @Address, @City, @Region, @PostalCode, @Country, @Phone, @Fax)
END
 
EXECUTE AddCustomer N'AAAAB', N'STEP IT', N'Nidjat', N'Student', N'****', N'Baku', NULL, N'12345', N'Azerbaijan', N'XXX-XXX-XXX', NULL
 
GO
--TASK 1.3
CREATE PROCEDURE DeleteOrder(@OrderID AS INT)
AS
BEGIN
	DELETE FROM [Order Details]
    WHERE OrderID = @OrderID

	DELETE FROM [Orders]
    WHERE OrderID = @OrderID
END
 
EXECUTE DeleteOrder 10306

GO
--TASK 1.4
CREATE PROCEDURE AddOrderForCustomer(@CustomerID AS NVARCHAR(MAX), @EmployeeID AS INT, @ProductName AS NVARCHAR(MAX), @Quantity AS INT, @Discount AS INT, @Shipper AS NVARCHAR(MAX))
AS
BEGIN

	IF (SELECT CustomerID FROM Customers WHERE CustomerID = @CustomerID) = NULL OR (SELECT EmployeeID FROM Employees WHERE EmployeeID = @EmployeeID) = NULL
	BEGIN
		PRINT N'Incorrect datas!'
	END
	ELSE
	BEGIN
		INSERT INTO Orders VALUES
		(@CustomerID, @EmployeeID, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, CURRENT_TIMESTAMP, (SELECT ShipperID FROM Shippers WHERE CompanyName = @Shipper), 10, NULL, (SELECT [Address] FROM Customers WHERE CustomerID = @CustomerID), (SELECT City FROM Customers WHERE CustomerID = @CustomerID), NULL, N'12346', (SELECT Country FROM Customers WHERE CustomerID = @CustomerID))
	END

	IF (SELECT UnitsInStock FROM Products WHERE ProductName = @ProductName) >= @Quantity
	BEGIN
		UPDATE Products
		SET UnitsInStock = UnitsInStock - @Quantity
		WHERE ProductName = @ProductName

		INSERT INTO [Order Details] VALUES
		((SELECT OrderID FROM Orders WHERE CustomerID = @CustomerID AND EmployeeID = @EmployeeID), (SELECT ProductID FROM Products WHERE ProductName = @ProductName), (SELECT UnitPrice FROM Products WHERE ProductName = @ProductName), @Quantity, @Discount)
	END
	ELSE
	BEGIN
		PRINT N'The quantity of this item is not enough!'
	END
END

EXEC AddOrderForCustomer N'AAAAB', 10, N'Tofu', 2, 0, N'Speedy Express'
-- N'AAAAB' это customer которого я добавил, для системных customer-ов процедура работает, если эта строка (SELECT OrderID FROM Orders WHERE CustomerID = @CustomerID AND EmployeeID = @EmployeeID) вернет 1 значение 
--(а это в малых случаях невозможно из за того, что некоторые CUSTOMERID, EMPLOYEEID, SHIPVIA (параметры наши) полностью совпадают как например SUPRD, 4, 2. Это можно исправить, если добавить параметр время, а не делать его системным(чтобы хоть как то различать))
 
GO
--TASK 1.5
CREATE PROCEDURE GetEmployeesAndCustomers
AS
BEGIN
    SELECT(SELECT COUNT(CustomerID) FROM Customers) AS CountOfCustomers, 
    (SELECT COUNT(EmployeeID) FROM Employees) AS CountOfEmployees
END
 
EXECUTE GetEmployeesAndCustomers
 
GO
--TASK 2.1
CREATE FUNCTION GetEmployeeAndCustomer()
RETURNS TABLE
AS
RETURN
    SELECT(SELECT COUNT(CustomerID) FROM Customers) AS CountOfCustomers, 
    (SELECT COUNT(EmployeeID) FROM Employees) AS CountOfEmployees
 
GO
SELECT * FROM GetEmployeeAndCustomer()


GO 
--TASK 2.2
CREATE FUNCTION CustomerCount()
RETURNS TABLE
AS
RETURN
	SELECT LEFT(ContactName, 1) AS Letters, COUNT(ContactName) AS CountOfCustomersByLetters
	FROM Customers
	WHERE ContactName BETWEEN 'A%' AND 'Z%'
	GROUP BY LEFT(ContactName, 1)

GO

SELECT * FROM CustomerCount()
 
GO
--TASK 2.3 !
CREATE FUNCTION GetOrders(@Num1 AS INT)
RETURNS TABLE
AS
RETURN	
	WITH SRC AS (SELECT TOP (@Num1) PERCENT * 
	FROM Orders
	ORDER BY OrderID DESC)

	SELECT TOP(SELECT COUNT(*) FROM Orders) *
	FROM SRC
	ORDER BY OrderID
GO

SELECT * FROM GetOrders(10)
	