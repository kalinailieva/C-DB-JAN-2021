CREATE DATABASE Minions
USE Minions

CREATE TABLE Minions(
	Id INT PRIMARY KEY NOT NULL,
	--primary key ���� �������� ���, ����� ����� �� ������ �� �������
	[Name] NVARCHAR(50) NOT NULL,
	--[] �������� ����������� ����
	Age TINYINT NOT NULL
)

CREATE TABLE Towns(
	Id INT PRIMARY KEY NOT NULL,
	[Name] NVARCHAR(50) NOT NULL
)
ALTER TABLE Minions
ADD TownId INT FOREIGN KEY REFERENCES Towns(Id)
--A FOREIGN KEY is a key used to link two tables together.

INSERT INTO Towns(Id, [Name])--�� ��� ������
		VALUES
			(1, 'Sofia'),--����� ���
			(2, 'Plovdiv'),--����� ���
			(3, 'Varna')--����� ���

INSERT INTO Minions(Id, [Name], Age, TownId)
	VALUES
		(1, 'Kevin', 22, 1),
		(2, 'Bob', 15, 3),
		(3, 'Steward', NULL, 2)


SELECT * FROM Minions
--������� �������� ����������

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