USE Northwind;

--Task2

--CREATE TABLE Author
--(
--    Id INT PRIMARY KEY IDENTITY(1, 1),
--    FirstName NVARCHAR(MAX) NOT NULL,
--    SecondName NVARCHAR(MAX),
--    MiddleName NVARCHAR(MAX),
--    BirthDate DATETIME2,
--    Mail NVARCHAR(255),
--    PhoneNumber NVARCHAR(255),
--	IsVIP BIT
--)


--INSERT INTO Author VALUES

--(N'John', N'Doe', NULL, CAST(N'1979-01-22 10:34:09.000' AS DateTime2), 'john_d@gmail.com', '(555) 525-4281', NULL),
--(N'Sarah', N'Menson', NULL, CAST(N'2006-01-27 10:34:09.000' AS DateTime2), 'sarah_m_on@gmail.com', '(555) 732-1689', NULL),
--(N'Steve', N'Sinclair', NULL, CAST(N'1986-12-17 10:34:09.000' AS DateTime2), 'steve_sinc@gmail.com', ' (555) 792-9732', NULL)

--UPDATE Author
--SET SecondName = N'Green'
--WHERE [FirstName] = N'Sarah';

--UPDATE Author
--SET IsVIP = 1
--WHERE YEAR(BirthDate) < 2004;


--DELETE FROM Author
--WHERE FirstName LIKE '%N';

--SELECT *
--FROM Author;



--Task1

--SELECT *
--FROM Customers
--WHERE ContactName LIKE 'R%' OR ContactName LIKE 'A%';

--SELECT *
--FROM Customers
--WHERE Phone LIKE '%5%5%5%';

--SELECT *
--FROM Customers
--WHERE PostalCode LIKE '[0-9][0-9][0-9][0-9][0-9]';

--SELECT *
--FROM Orders
--WHERE YEAR(OrderDate) > 1997 AND MONTH(OrderDate) > 3 AND DAY(OrderDate) > 14;

--SELECT *
--FROM Suppliers
--WHERE Address LIKE '%[0-9]';

--SELECT Top(10) *
--FROM Suppliers
--WHERE ContactName LIKE '%a%';

--SELECT [Address], City, Country, Phone
--FROM Suppliers
--WHERE Fax LIKE '%5%5%5%'
--ORDER BY [Address]
--OFFSET 1 ROW
--FETCH NEXT 3 ROWS ONLY

--SELECT LastName + ' ' + FirstName + ' is working at Northwind as ' + Title + ' since ' + CAST(HireDate AS nvarchar(MAX)) + ' year'
--FROM Employees


