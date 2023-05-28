USE ITStep
-- TASK1

CREATE TABLE Students
(
    Id INT IDENTITY(1, 1),
    [Name] NVARCHAR(MAX) NOT NULL,
    Surname NVARCHAR(MAX) NOT NULL,
	Age INT NOT NULL,
	Mail NVARCHAR(MAX) NOT NULL,
	GroupsID INT,
	[Status] NVARCHAR(MAX) NOT NULL,
	CONSTRAINT PK_Students_Id PRIMARY KEY ([Id]),
);
 
GO
 
CREATE TABLE Groups
(
    Id INT IDENTITY(1, 1),
    GroupName NVARCHAR(MAX) NOT NULL, 
    DepartmentsID INT,
	TeacherID INT,
	CONSTRAINT PK_Groups_Id PRIMARY KEY ([Id]),
);

 
GO
 
CREATE TABLE Departments
(
    Id INT IDENTITY(1, 1),
    Title NVARCHAR(MAX) NOT NULL,
    DepartmentsHeadsID INT,
    CONSTRAINT PK_Departments_Id PRIMARY KEY ([Id]),
)
 
GO
 
CREATE TABLE Teachers
(
    Id INT IDENTITY(1, 1),
    [Name] NVARCHAR(MAX) NOT NULL,
	[Surname] NVARCHAR(MAX) NOT NULL,
	Age INT,
	Mail NVARCHAR(MAX) NOT NULL, 
	AssistentID INT UNIQUE,
	[Status] NVARCHAR(MAX) NOT NULL,
	CONSTRAINT PK_Teachers_Id PRIMARY KEY ([Id]),
)
 
GO
 
CREATE TABLE DepartmentsHeads
(
    Id INT IDENTITY(1, 1),
    [Name] NVARCHAR(MAX) NOT NULL,
	[Surname] NVARCHAR(MAX) NOT NULL,
	Age INT NOT NULL,
	Mail NVARCHAR(MAX) NOT NULL, 
	[Status] NVARCHAR(MAX) NOT NULL,
    CONSTRAINT PK_DepartmentsHeads_Id PRIMARY KEY ([Id]),
)

GO

CREATE TABLE Assistents
(
	Id INT IDENTITY(1, 1),
    [Name] NVARCHAR(MAX) NOT NULL,
    Surname NVARCHAR(MAX) NOT NULL,
	Age INT NOT NULL,
	Mail NVARCHAR(MAX) NOT NULL, 
	[Status] NVARCHAR(MAX) NOT NULL,
    CONSTRAINT PK_Assistents_Id PRIMARY KEY ([Id]),
)

GO

ALTER TABLE Students
ADD CONSTRAINT FK_Students_Groups_Id FOREIGN KEY (GroupsID) REFERENCES Groups(Id)

ALTER TABLE Groups
ADD CONSTRAINT FK_Groups_Departments_Id FOREIGN KEY (DepartmentsID) REFERENCES Departments(Id)

ALTER TABLE Groups
ADD CONSTRAINT FK_Groups_Teachers_Id FOREIGN KEY (TeacherID) REFERENCES Teachers(Id)

ALTER TABLE Departments
ADD CONSTRAINT FK_Departments_DepartmentsHeads_Id FOREIGN KEY (DepartmentsHeadsID) REFERENCES DepartmentsHeads(Id)

ALTER TABLE Teachers
ADD CONSTRAINT FK_Teachers_Assistents_Id FOREIGN KEY (AssistentID) REFERENCES Assistents(Id)

INSERT Students VALUES
(N'Barack', N'Obama', 18, N'obama@mail.ru', 1, N'Student'),
(N'Donald', N'Trump', 19, N'trump@mail.ru', 2, N'Student'),
(N'Vladimir', N'Putin', 20, N'putin@mail.ru', 3, N'Student'),
(N'Volodimir', N'Zelesnkiy', 21, N'zelenskiy@mail.ru', 3, N'Student'),
(N'Viktor', N'Yanukovich', 22, N'yanukovich@mail.ru', 2, N'Student'),
(N'Dmitriy', N'Medvedev', 23, N'medvedev@mail.ru', 1, N'Student')

INSERT Groups VALUES
(N'1213', 1, 1),
(N'1212', 2, 2),
(N'1211', 3, 3)

INSERT Departments VALUES
(N'Айти', 1),
(N'МКА', 2),
(N'Программирование', 3) 

INSERT Teachers VALUES
(N'Teacher1', N'TSurname1', 30, N'teacher1@mail.ru', 1, N'Teacher'),
(N'Teacher2', N'TSurname2' ,31, N'teacher2@mail.ru', 2,  N'Teacher'),
(N'Teacher3', N'TSurname3', 32, N'teacher3@mail.ru', NULL,  N'Teacher')

INSERT DepartmentsHeads VALUES
(N'DepartmentsHead1', N'DSurname1', 40, N'head1@mail.ru', N'DepartmentHead'),
(N'DepartmentsHead2', N'DSurname2', 41, N'head2@mail.ru', N'DepartmentHead'),
(N'DepartmentsHead3', N'DSurname3', 42, N'head3@mail.ru', N'DepartmentHead')

INSERT Assistents VALUES
(N'Barack', N'Obama', 18, N'obama@mail.ru', N'Assistent'),
(N'Donald', N'Trump', 19, N'trump@mail.ru', N'Assistent')


-- TASK2
 
-- 2.1
SELECT [Name], Surname, Age, Mail
FROM Students
INTERSECT
SELECT [Name], Surname, Age, Mail
FROM Assistents

-- 2.2
SELECT [Name], Surname, Age, Mail
FROM Students
EXCEPT
SELECT [Name], Surname, Age, Mail
FROM Assistents

-- 2.3
SELECT [Name], Surname, Age, Mail
FROM Students
UNION
SELECT [Name], Surname, Age, Mail
FROM Teachers
UNION
SELECT [Name], Surname, Age, Mail 
FROM DepartmentsHeads 
ORDER BY Surname

-- 2.4
SELECT [Name], Surname, [Status]
FROM Teachers 
UNION
SELECT [Name], Surname, [Status]
FROM Assistents

-- 2.5 Не совсем корректно работает код :(
SELECT S.[Name], S.Surname, S.[Status]
FROM Students AS S
INNER JOIN [Groups] AS G ON S.GroupsID = G.Id
INNER JOIN [Teachers] AS T ON G.TeacherID = T.Id
WHERE GroupName = N'1213'
UNION
SELECT [Name], Surname, [Status]
FROM Teachers

