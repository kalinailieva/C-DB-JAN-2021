--1

CREATE PROC usp_GetEmployeesSalaryAbove35000 
AS
	SELECT FirstName, LastName
	FROM Employees
	WHERE Salary > 35000
GO

EXEC usp_GetEmployeesSalaryAbove35000

--2

CREATE PROC usp_GetEmployeesSalaryAboveNumber (@Salary DECIMAL(18,4))
AS
	SELECT FirstName,LastName
	FROM Employees
	WHERE Salary >= @Salary
GO

EXEC usp_GetEmployeesSalaryAboveNumber 48100

--3

CREATE OR ALTER PROC usp_GetTownsStartingWith (@StartString VARCHAR(50))

AS
	SELECT t.Name
	FROM Employees as e
	JOIN Addresses as a ON e.AddressID = a.AddressID
	JOIN Towns as t ON a.TownID = t.TownID
	WHERE t.Name LIKE '[@StartString]%'

GO

EXEC usp_GetTownsStartingWith @StartString ='B'

	SELECT * FROM Employees