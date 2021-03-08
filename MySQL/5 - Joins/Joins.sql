--1
USE SoftUni

SELECT TOP(5) EmployeeID, JobTitle, e.AddressID, AddressText
FROM Employees as e
JOIN Addresses as a ON e.AddressID = a.AddressID
ORDER BY AddressID ASC

--2

SELECT TOP(50) 
FirstName, LastName, t.Name AS Town, a.AddressText
FROM Employees as e
JOIN Addresses as a ON e.AddressID = a.AddressID
JOIN Towns as t ON a.TownID = t.TownID
ORDER BY FirstName, LastName

--3

SELECT e.EmployeeID, e.FirstName, e.LastName, d.Name AS DepartmentName
FROM Employees as e
JOIN Departments as d ON e.DepartmentID = d.DepartmentID
WHERE d.Name = 'Sales'
ORDER BY EmployeeID


--4
SELECT TOP(5) EmployeeID, FirstName, Salary,
d.Name AS DepartamentName
FROM Employees as e
JOIN Departments as d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > 15000
ORDER BY e.DepartmentID




--5
SELECT TOP(3)
e.EmployeeID, FirstName
FROM Employees as e
LEFT JOIN EmployeesProjects as p ON e.EmployeeID = p.EmployeeID
WHERE p.ProjectID IS NULL

--6

SELECT
	FirstName,LastName,HireDate,
	d.Name AS DeptName
FROM Employees as e
JOIN Departments as d ON e.DepartmentID = d.DepartmentID
WHERE HireDate > '1999-01-01' AND d.Name IN ('Sales','Finance')
ORDER BY e.HireDate

--7

SELECT TOP(5)
	e.EmployeeID, e.FirstName, 
	p.Name AS ProjectName
FROM Employees as e
JOIN EmployeesProjects as ep ON e.EmployeeID= ep.EmployeeID
JOIN Projects as p ON ep.ProjectID = p.ProjectID
WHERE p.StartDate > '2002-08-13' AND p.EndDate IS NULL
ORDER BY e.EmployeeID

--8

SELECT
	e.EmployeeID, e.FirstName, 
	CASE
		WHEN YEAR(StartDate) >='2005' THEN 'NULL'--Judge accept p.StartDate > 2005
		ELSE p.Name
	END AS ProjectName
FROM Employees as e
JOIN EmployeesProjects as ep ON e.EmployeeID= ep.EmployeeID
JOIN Projects as p ON ep.ProjectID = p.ProjectID
WHERE e.EmployeeID = 24

--9

SELECT
	e.EmployeeID, e.FirstName, e.ManagerID,
	e2.FirstName AS ManagerName --important to be taken from the right table
FROM Employees as e
JOIN Employees as e2 ON e.ManagerID = e2.EmployeeID
WHERE e.ManagerID IN(3,7)
ORDER BY EmployeeID




--10
SELECT TOP(50)
	e.EmployeeID,
	CONCAT(e.FirstName, ' ', e.LastName) AS EmployeeName,
	CONCAT(e2.FirstName, ' ', e2.LastName) AS ManagerName,
	ISNULL(d.[Name], 'None') AS DepartmentName
	FROM Employees AS e
	LEFT JOIN Employees AS e2 ON  e.ManagerID = e2.EmployeeID
	LEFT JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
	ORDER BY e.EmployeeID

--11

SELECT TOP(1) 
	(SELECT AVG(Salary) FROM Employees e 
	WHERE e.DepartmentID = d.DepartmentID)
	AS MinAverageSalary
	FROM Departments d
	WHERE (SELECT COUNT(*) FROM Employees e
		WHERE e.DepartmentID = d.DepartmentID) >0
	ORDER BY MinAverageSalary 

--using GroupBy

SELECT TOP(1) AVG(Salary) FROM Employees
GROUP BY DepartmentID
ORDER BY AVG(Salary)


SELECT MIN([avg]) AS [MinAverageSalary]
FROM(
	SELECT AVG(Salary) as [avg]
	FROM Employees
	GROUP BY DepartmentID) AS AverageSalary

USE Geography

--12

SELECT 
c.CountryCode,
m.MountainRange, p.PeakName, p.Elevation
FROM Countries as c
JOIN  MountainsCountries as mc ON c.CountryCode = mc.CountryCode
JOIN Mountains as m ON mc.MountainId = m.Id
JOIN Peaks as p ON m.Id = p.MountainId
WHERE c.CountryCode = 'BG' AND Elevation > 2835
ORDER BY p.Elevation DESC


--13

SELECT 
c.CountryCode,
m.MountainRange
FROM Countries as c
JOIN  MountainsCountries as mc ON c.CountryCode = mc.CountryCode
JOIN Mountains as m ON mc.MountainId = m.Id
WHERE c.CountryCode IN ( 'BG', 'US', 'RO')

--14

SELECT TOP (5)
c.CountryName, r.RiverName
FROM Countries as c
JOIN Continents as co ON c.ContinentCode = co.ContinentCode
LEFT JOIN CountriesRivers as cr ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers as r ON cr.RiverId = r.Id
WHERE co.ContinentName = 'Africa'
ORDER BY c.CountryName


--15
USE Geography
SELECT c.ContinentCode, c.CurrencyCode,
Count(c.CurrencyCode) AS CurrencyUsage
FROM Countries as c
JOIN Continents as cont ON c.ContinentCode = cont.ContinentCode
JOIN Currencies as curr ON c.CurrencyCode = curr.CurrencyCode
GROUP BY c.ContinentCode, c.CurrencyCode
HAVING Count(c.CurrencyCode) > 1
ORDER BY c.ContinentCode

--¬“Œ–» Õ¿◊»Õ, ¬¿∆ÕŒ!!!!
SELECT ContinentCode, CurrencyCode, Total 
	FROM
		(
		SELECT ContinentCode, CurrencyCode, COUNT(CurrencyCode) AS Total,
		--Ë ÒÎÂ‰ Í‡ÚÓ „Ë ËÁ·ÓË ‰‡ „Ë ÔÓ‰Â‰Ë ÔÓ ‡ÌÍ
		--‚ partition ÒÂ ËÁ·Ë‡ Ó·˘ÓÚÓ ÏÂÊ‰Û Úˇı
		DENSE_RANK() OVER(PARTITION BY ContinentCode ORDER BY COUNT(CurrencyCode)DESC) AS Ranked
		FROM Countries
		GROUP BY ContinentCode, CurrencyCode) as k
		WHERE Ranked = 1 AND Total > 1
		ORDER BY ContinentCode


--16.



SELECT COUNT(*) AS [Count]
FROM Countries as c
LEFT JOIN MountainsCountries as m ON c.CountryCode = m.CountryCode
WHERE m.CountryCode IS NULL


--17


SELECT TOP(5) c.CountryName, 
MAX(p.Elevation) AS HighestPeakElevation,
MAX(r.Length) AS LongestRiverLength
FROM Countries as c
LEFT JOIN MountainsCountries as mc ON c.CountryCode = mc.CountryCode
LEFT JOIN Mountains as m ON mc.MountainId = m.Id
LEFT JOIN Peaks as p ON m.Id = p.MountainId
LEFT JOIN CountriesRivers as cr ON c.CountryCode = cr.CountryCode
LEFT JOIN Rivers as r ON cr.RiverId = r.Id
GROUP BY CountryName
ORDER BY MAX(p.Elevation) DESC,MAX(r.Length) DESC, c.CountryName

--18 “¿«» Õ≈ ﬂ –¿«¡–¿’! Œ“Õ¿◊¿ÀŒ

SELECT * FROM Countries
SELECT *  FROM MountainsCountries

SELECT * 
	FROM (
			SELECT c.CountryName, 
			ISNULL(p.PeakName, '(no highest peak)') AS [Highest Peak Name],
			ISNULL(MAX(p.Elevation), 0) AS [Highest Peak Elevation],
			DENSE_RANK() OVER(PARTITION BY c.CountryName ORDER BY MAX(p.Elevation)DESC)AS Ranked
			FROM Countries as c
			LEFT JOIN MountainsCountries as mc ON c.CountryCode = mc.CountryCode
			LEFT JOIN Mountains as m ON mc.MountainId = m.Id
			LEFT JOIN Peaks as p ON m.Id = p.MountainId
			ORDER BY c.CountryName)
















