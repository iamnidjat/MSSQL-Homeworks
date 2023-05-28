USE Northwind;

GO
CREATE PROCEDURE AddOrderForCustomer(@CustomerID AS NVARCHAR(MAX), @EmployeeID AS INT, @ProductName AS NVARCHAR(MAX), @Quantity AS INT, @Discount AS INT, @Shipper AS NVARCHAR(MAX))
AS
BEGIN
	BEGIN TRANSACTION AddOrders

	IF (SELECT CustomerID FROM Customers WHERE CustomerID = @CustomerID) = NULL OR (SELECT EmployeeID FROM Employees WHERE EmployeeID = @EmployeeID) = NULL
	BEGIN
		PRINT N'Incorrect datas!'
		ROLLBACK TRANSACTION Addorders
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
		ROLLBACK TRANSACTION Addorders
	END

	COMMIT TRANSACTION Addorders
END

EXEC AddOrderForCustomer N'AAABC', 4, N'Camembert Pierrot', 2, 0, N'United Package'
-- N'AAABC' это customer которого я добавил, для системных customer-ов процедура работает, если эта строка (SELECT OrderID FROM Orders WHERE CustomerID = @CustomerID AND EmployeeID = @EmployeeID) вернет 1 значение 
--(а это в малых случаях невозможно из за того, что некоторые CUSTOMERID, EMPLOYEEID, SHIPVIA (параметры наши) полностью совпадают как например SUPRD, 4, 2. Это можно исправить, если добавить параметр время, а не делать его системным(чтобы хоть как то различать))