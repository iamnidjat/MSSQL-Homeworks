CREATE DATABASE MYHOMEWORK;

-- Task1

CREATE TABLE Author
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    FirstName NVARCHAR(MAX) NOT NULL,
    SecondName NVARCHAR(MAX),
    MiddleName NVARCHAR(MAX),
    BirthDate DATETIME2,
    Mail NVARCHAR(255) UNIQUE NOT NULL,
    PhoneNumber NVARCHAR(255) UNIQUE
)

-- Task2

CREATE TABLE Book
(
    Id INT PRIMARY KEY IDENTITY(1, 1),
    Title  NVARCHAR(MAX) NOT NULL,
    FullName  NVARCHAR(MAX) NOT NULL,
    PublisherName  NVARCHAR(MAX) NOT NULL,
    BooksCount INT NOT NULL,
    BooksPrice INT NOT NULL,
    Discount FLOAT
)


ALTER TABLE Book
ADD CONSTRAINT CK_Books_Id CHECK (Discount > 0 AND Discount < 1);



-- Здесь нарушены первая и третья нормальные формы, так как данные дублируются (1-я форма нарушена), лучше было бы фио разделить на имя, фамилию и отчество, а ещё можно было сразу указать цену, не указывая скидку (3-я форма нарушена)

-- Task3

ALTER TABLE Book
DROP CONSTRAINT CK_Books_Id

ALTER TABLE Book
DROP COLUMN Discount

-- Task4

CREATE TABLE Author2
(
    Id INT IDENTITY(1, 1),
    FirstName NVARCHAR(MAX) NOT NULL,
    SecondName NVARCHAR(MAX),
    MiddleName NVARCHAR(MAX),
    BirthDate DATETIME2,
    Mail NVARCHAR(255) NOT NULL,
    PhoneNumber NVARCHAR(255)
)

ALTER TABLE Author2
ADD CONSTRAINT PK_Author_Id PRIMARY KEY (Id);

ALTER TABLE Author2 
ADD CONSTRAINT UQ_Author_Mail UNIQUE (Mail);

ALTER TABLE Author2 
ADD CONSTRAINT UQ_Author_PhoneNumber UNIQUE (PhoneNumber);

CREATE TABLE Book2
(
    Id INT IDENTITY(1, 1),
    Title  NVARCHAR(MAX) NOT NULL,
    FullName  NVARCHAR(MAX) NOT NULL,
    PublisherName  NVARCHAR(MAX) NOT NULL,
    BooksCount INT NOT NULL,
    BooksPrice INT NOT NULL,
    Discount FLOAT CHECK(Discount > 0 AND Discount < 1)
)

ALTER TABLE Book2
ADD CONSTRAINT PK_Books_Id PRIMARY KEY (Id);

ALTER TABLE Book2
ADD CONSTRAINT CK_Books_Id CHECK (Discount > 0 AND Discount < 1);

-- Task5

DROP TABLE Author;

DROP TABLE Author2;

DROP TABLE Book;

DROP TABLE Book2;