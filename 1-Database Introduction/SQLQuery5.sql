CREATE DATABASE Minions
USE Minions

CREATE TABLE Minions(
	Id INT PRIMARY KEY NOT NULL,
	--primary key дава уникален код, който после се ползва за релации
	[Name] NVARCHAR(50) NOT NULL,
	--[] ескейпва специалните думи
	Age TINYINT NOT NULL
)

CREATE TABLE Towns(
	Id INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
)
ALTER TABLE Minions
ADD TownId INT FOREIGN KEY REFERENCES Towns(Id)
--A FOREIGN KEY is a key used to link two tables together.

INSERT INTO Towns(Id, [Name])--по кои колони
		VALUES
			(1, 'Sofia'),--първи ред
			(2, 'Plovdiv'),--втори ред
			(3, 'Varna')--трети ред

INSERT INTO Minions(Id, [Name], Age, TownId)
	VALUES
		(1, 'Kevin', 22, 1),
		(2, 'Bob', 15, 3),
		(3, 'Steward', NULL, 2)


SELECT * FROM Minions
--Показва желаната информация

TRUNCATE TABLE Minions

DROP TABLE Minions
DROP TABLE Towns

CREATE TABLE Users(
	Id BIGINT PRIMARY KEY NOT NULL,
	Username VARCHAR(30) NOT NULL,
	[Password] VARCHAR(26) NOT NULL,
	ProfilePicture IMAGE,
	LastLoginTime DATETIME2,
	IsDeleted BIT
)