USE ITStep
-- TASK1

CREATE TABLE Students
(
    Id INT IDENTITY(1, 1),
    [Name] NVARCHAR(MAX) NOT NULL,
    Surname NVARCHAR(MAX) NOT NULL,
	GroupsID INT,
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
	CONSTRAINT PK_Teachers_Id PRIMARY KEY ([Id]),
)
 
GO
 
CREATE TABLE DepartmentsHeads
(
    Id INT IDENTITY(1, 1),
    Title NVARCHAR(MAX) NOT NULL,
    CONSTRAINT PK_DepartmentsHeads_Id PRIMARY KEY ([Id]),
)


ALTER TABLE Students
ADD CONSTRAINT FK_Students_Groups_Id FOREIGN KEY (GroupsID) REFERENCES Groups(Id)

ALTER TABLE Groups
ADD CONSTRAINT FK_Groups_Departments_Id FOREIGN KEY (DepartmentsID) REFERENCES Departments(Id)

ALTER TABLE Groups
ADD CONSTRAINT FK_Groups_Teachers_Id FOREIGN KEY (TeacherID) REFERENCES Teachers(Id)

ALTER TABLE Departments
ADD CONSTRAINT FK_Departments_DepartmentsHeads_Id FOREIGN KEY (DepartmentsHeadsID) REFERENCES DepartmentsHeads(Id)


INSERT Students VALUES
(N'Barack', N'Obama', 1),
(N'Donald', N'Trump', 2),
(N'Vladimir', N'Putin', 3),
(N'Volodimir', N'Zelesnkiy', 3),
(N'Viktor', N'Yanukovich', 2),
(N'Dmitriy', N'Medvedev', 1)

INSERT Groups VALUES
(N'1213', 1, 1),
(N'1212', 2, 2),
(N'1211', 3, 3)

INSERT Departments VALUES
(N'Айти', 1),
(N'МКА', 2),
(N'Программирование', 3) 

INSERT Teachers VALUES
(N'Teacher1'),
(N'Teacher2'),
(N'Teacher3')

INSERT DepartmentsHeads VALUES
(N'DepartmentsHead1'),
(N'DepartmentsHead2'),
(N'DepartmentsHead3')

-- TASK2

-- 2.1
SELECT * 
FROM Students
WHERE (SELECT Id
FROM Groups 
WHERE (SELECT Id FROM Departments WHERE Title = N'МКА') = DepartmentsID) = GroupsID

-- 2.2
SELECT *
FROM Groups
WHERE (SELECT GroupsId FROM Students WHERE [Name] = N'Barack') = Id

-- 2.3
SELECT * 
FROM Groups
WHERE (SELECT Id FROM Teachers WHERE [Name] = N'Teacher1') = TeacherID

-- 2.4
SELECT *
FROM GROUPS
WHERE (SELECT Id
FROM Departments
WHERE (SELECT Id FROM DepartmentsHeads WHERE Title = N'DepartmentsHead1') = DepartmentsHeadsID) = DepartmentsID

-- 2.5
SELECT *
FROM Students
WHERE (SELECT Id
FROM GROUPS
WHERE (SELECT Id
FROM Departments
WHERE (SELECT Id FROM DepartmentsHeads WHERE Title = N'DepartmentsHead1') = DepartmentsHeadsID) = DepartmentsID) = GroupsID

-- 2.6
SELECT Id
FROM Groups
WHERE (SELECT Id FROM Departments WHERE Title = N'Программирование') = DepartmentsID




