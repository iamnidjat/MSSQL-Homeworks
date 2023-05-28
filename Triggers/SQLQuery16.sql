USE Northwind

CREATE TABLE [User]
(
    Id INT IDENTITY (1, 1),
    FirstName NVARCHAR(MAX) NOT NULL,
    Birthdate DATETIME2 NOT NULL,
    Email NVARCHAR(MAX) NOT NULL,
    IsEmailConfirmed BIT NOT NULL,
    CONSTRAINT PK_User_Id PRIMARY KEY ([Id]),
)
 
CREATE TABLE [Posts]
(
    Id INT IDENTITY (1, 1),
    UserID INT,
    Postdate DATETIME2 NOT NULL,
    [Text] NVARCHAR(MAX) NOT NULL,
    CONSTRAINT PK_Posts_Id PRIMARY KEY ([Id]),
    CONSTRAINT FK_Posts_User_Id FOREIGN KEY (UserID) REFERENCES [User](Id) ON DELETE CASCADE
)
 
CREATE TABLE [NewPosts]
(
    [PostId] INT,
    [DateAdded] DATETIME2,
    [Text] NVARCHAR(MAX),
    CONSTRAINT [FK_NewPosts_PostId] FOREIGN KEY([PostId]) REFERENCES [Posts]([Id]) ON DELETE CASCADE
)
 
INSERT INTO [User] VALUES
(
    N'Nidjat', CONVERT(datetime, 'Dec 04 12:18:52 2002'), N'gurbanli.nidjat@mail.ru', 1
), 
(
    N'Nidjat2', CONVERT(datetime, 'Dec 04 12:18:52 2002'), N'gurbanli.nidjat@mail.ru', 1
), 
(
    N'Nidjat3', CONVERT(datetime, 'Dec 04 12:18:52 2002'), N'gurbanli.nidjat@mail.ru', 1
)

 
GO
CREATE PROCEDURE InsertPosts(@UserID AS INT, @Text AS NVARCHAR(MAX))
AS
BEGIN
    INSERT INTO Posts VALUES
    (@UserID, CURRENT_TIMESTAMP, @Text)
END


GO
 
CREATE TRIGGER TG_Posts_INSERT ON [Posts]
FOR INSERT
AS
BEGIN
    DECLARE @Id AS INT = (SELECT [Id]
                        FROM inserted);
    DECLARE @Text AS NVARCHAR(MAX) = (SELECT [Text]
                        FROM inserted)
 
    
    INSERT INTO [NewPosts] VALUES
    (
        @Id, SYSDATETIME(), @Text
    );  
END
 
 
GO
 
EXEC InsertPosts 1, N'Hello1!'
EXEC InsertPosts 2, N'Hello2!'
EXEC InsertPosts 3, N'Hello3!'


GO
 
-- SELECT * FROM Posts
-- SELECT * FROM NewPosts
 
---------------------------------------------------------------------------------------
CREATE TABLE DeletedPosts
(
    --[PostId] INT,
	[Text] NVARCHAR(MAX),
    [DateDeleted] DATETIME2,
   -- CONSTRAINT [FK_DeletedPosts_PostId] FOREIGN KEY([PostId]) REFERENCES [Posts]([Id]) С Constraint-ом были проблемы при удалении поста поэтому пришлось мне их удалить
)
 
GO
CREATE PROCEDURE DeletePosts(@Text AS NVARCHAR(MAX))
AS
BEGIN
    DELETE FROM Posts
    WHERE Id = (SELECT Id FROM Posts WHERE [Text] = @Text)
END

 
GO
CREATE TRIGGER TG_Posts_DELETE ON [Posts]
FOR DELETE
AS 
BEGIN
    --DECLARE @Id AS INT = (SELECT [Id]
    --                      FROM deleted);
	DECLARE @Text AS NVARCHAR(MAX) = (SELECT [Text]
                          FROM deleted);
    
     INSERT INTO [DeletedPosts] VALUES
     (
         @Text, SYSDATETIME()
     ); 
END
 
EXEC DeletePosts N'Hello3!'
 
--SELECT * FROM Posts
--SELECT * FROM DeletedPosts
------------------------------------------------------------------------------------------
CREATE TABLE NewText
(
    PostsID INT,
    [DateUpdated] DATETIME2,
    CONSTRAINT [FK_NewText_PostsId] FOREIGN KEY([PostsID]) REFERENCES [Posts]([Id]) ON DELETE CASCADE
)

GO
CREATE PROCEDURE [UpdateText] (@Id AS INT, @Text AS NVARCHAR(MAX))
AS
BEGIN
    UPDATE Posts
    SET [Text] = @Text
    WHERE Id = @Id
END
 
GO 
 
CREATE TRIGGER TG_Posts_UPDATE ON [Posts]
AFTER UPDATE
AS
BEGIN
    DECLARE @Id AS INT = (SELECT [Id]
                          FROM inserted);
 
    INSERT INTO NewText VALUES
    (@Id, CURRENT_TIMESTAMP)
END
 
EXEC [UpdateText] 3, N'Bye'
 
--SELECT * FROM Posts
--SELECT * FROM [NewText]
 
GO
 
---------------------------------------------------------------------------------------
 
--TASK2
 
CREATE TABLE DisabledUser
(
    UserID INT,
    DateRemoved DATETIME2,
    RecoveryDeadline DATETIME2,
    CONSTRAINT [FK_DisabledUser_UserId] FOREIGN KEY([UserId]) REFERENCES [User]([Id])
)
 
 GO
CREATE TRIGGER TG_User_INSTEADOFDELETE ON [User]
INSTEAD OF DELETE
AS
BEGIN
    DECLARE @Id AS INT = (SELECT [Id]
                        FROM deleted);
 
    INSERT INTO [DisabledUser] VALUES
    (@Id, CURRENT_TIMESTAMP, DATEADD(month,6,CURRENT_TIMESTAMP));
END
 
 GO
CREATE PROCEDURE DeleteUser(@UserId AS INT)
AS 
BEGIN
        DELETE FROM [User]
        WHERE Id = @UserId
END
 
EXEC DeleteUser 2
 
--SELECT * FROM [DisabledUser]
 
--SELECT * FROM [User]