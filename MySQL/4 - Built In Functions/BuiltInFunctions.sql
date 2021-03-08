SELECT 
	[CustomerID],
	[FirstName],
	[LastName],
	LEFT(PaymentNumber,6) + REPLICATE('*', LEN(PaymentNumber) -6)
	AS [Payment Number]
	FROM Customers
--1
SELECT FirstName, LastName FROM Employees
WHERE FirstName LIKE 'Sa%'


--2
SELECT FirstName, LastName FROM Employees
WHERE LastName LIKE '%ei%'

--3
SELECT FirstName 
	FROM Employees
	WHERE DepartmentID IN(3, 10) AND YEAR(HireDate) BETWEEN 1995 AND 2005


SELECT * FROM Employees

--4
SELECT FirstName,LastName	
	FROM Employees	
		WHERE JobTitle NOT LIKE '%engineer%'

--5
SELECT [Name] FROM Towns
WHERE LEN([Name]) BETWEEN 5 AND 6
ORDER BY [Name]

--6
SELECT TownID, [Name] FROM Towns
WHERE [Name] LIKE '[M,K,B,E]%'
ORDER BY [Name] 

--7
SELECT TownID, [Name] FROM Towns
WHERE [Name] NOT LIKE '[R,B,D]%'
ORDER BY [Name] 

--8
CREATE VIEW V_EmployeesHiredAfter2000  AS
SELECT FirstName, LastName 
FROM Employees
WHERE YEAR(HireDate) > 2000

DROP VIEW V_EmployeesHiredAfter2000 

SELECT * FROM V_EmployeesHiredAfter2000 

--9

SELECT FirstName, LastName FROM Employees
WHERE LEN(LastName) = 5

--10 SELECT â SELECT

USE SoftUni

SELECT *
FROM (
	SELECT EmployeeID,FirstName,LastName,Salary,
	DENSE_RANK() OVER (PARTITION BY Salary ORDER BY EmployeeID) AS [Rank]
	FROM Employees
	WHERE Salary BETWEEN 10000 AND 50000) AS MyTable
WHERE [Rank] = 2
ORDER BY Salary DESC

--12
USE Geography

SELECT * FROM Countries

SELECT CountryName, ISOCode FROM Countries
WHERE CountryName LIKE '%a%a%a%'
ORDER BY ISOCode

--13

SELECT Peaks.PeakName, Rivers.RiverName,
LOWER(CONCAT(LEFT(Peaks.PeakName, LEN(Peaks.PeakName)-1),Rivers.RiverName)) AS Mix
FROM Peaks, Rivers
WHERE RIGHT(PeakName,1) = LEFT(RiverName,1)
ORDER BY Mix

--14
USE Diablo
SELECT * FROM Games

SELECT TOP(50) [Name], 
FORMAT([Start],'yyyy-MM-dd') AS Start
FROM Games
WHERE YEAR(Start) BETWEEN 2011 AND 2012
ORDER BY[Start]

--15

SELECT Username,
RIGHT (Email, CHARINDEX('@',REVERSE(Email))-1) AS [Email Provider] 
FROM Users
ORDER BY [Email Provider], Username

--16

SELECT Username,
IpAddress AS [IP Address] 
FROM Users
WHERE IpAddress LIKE '___.1_%._%.___'
ORDER BY Username

--17

SELECT * FROM Games

SELECT [Name] AS Game,
	CASE 
		WHEN DATEPART(HOUR, [Start]) BETWEEN 0 AND 11
		THEN 'Morning'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 12 AND 17
		THEN 'Afternoon'
		WHEN DATEPART(HOUR, [Start]) BETWEEN 18 AND 23
		THEN 'Evening'
		ELSE 'N\A'
	END AS [Part of the Day],
CASE
           WHEN Duration <= 3
           THEN 'Extra Short'
           WHEN Duration BETWEEN 4 AND 6
           THEN 'Short'
           WHEN Duration > 6
           THEN 'Long'
           WHEN Duration IS NULL
           THEN 'Extra Long'
           ELSE 'Error - must be unreachable case'
       END AS [Duration]
FROM Games
ORDER BY Name,
         [Duration],
         [Part of the Day]; 

--18

USE ORDERS
SELECT * FROM Orders

SELECT 
	ProductName,
	OrderDate,
	DATEADD(day, 3, OrderDate) AS [Pay Due],
	DATEADD(month,1,OrderDate) AS [Deliver Due]
	FROM Orders








