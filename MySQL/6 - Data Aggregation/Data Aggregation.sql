--1

SELECT COUNT(*) FROM WizzardDeposits


--2
SELECT TOP(1) MagicWandSize AS LongestMagicWand
FROM WizzardDeposits
ORDER BY MagicWandSize DESC

--3
SELECT DepositGroup, MAX(MagicWandSize) AS LongestMagicWand
FROM WizzardDeposits
GROUP BY DepositGroup

--4

SELECT TOP(2)DepositGroup
FROM WizzardDeposits
GROUP BY DepositGroup
ORDER BY AVG(MagicWandSize)

SELECT *  from WizzardDeposits

--5

SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
GROUP BY DepositGroup

--6

SELECT DepositGroup, SUM(DepositAmount)
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup

--7
SELECT DepositGroup, SUM(DepositAmount) AS TotalSum
FROM WizzardDeposits
WHERE MagicWandCreator = 'Ollivander family'
GROUP BY DepositGroup
HAVING SUM(DepositAmount) < 150000
ORDER BY SUM(DepositAmount) DESC

--8
SELECT DepositGroup, MagicWandCreator, 
MIN(DepositCharge) AS MinDepositCharge
FROM WizzardDeposits
GROUP BY DepositGroup, MagicWandCreator
ORDER BY MagicWandCreator, DepositGroup

--9
SELECT groups.AgeGroup, 
		COUNT(*) 
FROM --това цялото е от долния селект
	(
	SELECT CASE
		WHEN Age BETWEEN 0 and 10 THEN'[0-10]'
		WHEN Age BETWEEN 11 and 20 THEN'[11-20]'
		WHEN Age BETWEEN 21 and 30 THEN'[21-30]'
		WHEN Age BETWEEN 31 and 40 THEN'[31-40]'
		WHEN Age BETWEEN 41 and 50 THEN'[41-50]'
		WHEN Age BETWEEN 51 and 60 THEN'[51-60]'
		WHEN Age >60 THEN'[61+]'
		ELSE 'N/A'
		END AS AgeGroup	
		FROM WizzardDeposits) as groups
GROUP BY groups.AgeGroup


--10

SELECT  LEFT(FirstName,1) AS FirstLetter
FROM WizzardDeposits
WHERE DepositGroup = 'Troll Chest'
GROUP BY LEFT(FirstName,1)

--11

SELECT
	DepositGroup,
	IsDepositExpired,
	AVG(DepositInterest)
FROM WizzardDeposits
WHERE DepositStartDate > '1985-01-01'
GROUP BY DepositGroup, IsDepositExpired
ORDER BY DepositGroup DESC, IsDepositExpired

--12

SELECT * FROM WizzardDeposits

SELECT SUM([Difference])
FROM
(
	SELECT
	FirstName AS [Host Wizzard],
	DepositAmount AS [Host Wizard Deposit],
	LEAD (FirstName) OVER ( ORDER BY Id ASC) AS [Guest Wizard],
	LEAD (DepositAmount) OVER ( ORDER BY Id ASC) AS [Guest Wizard Deposit],
	DepositAmount - LEAD (DepositAmount) OVER ( ORDER BY Id ASC) AS [Difference]

	FROM WizzardDeposits) as wd --дава се име на целия селект, за да се ползва след това по-горе
WHERE wd.Difference IS NOT NULL

--13

USE SoftUni
GO

SELECT DepartmentID, SUM(Salary)
	FROM Employees
	GROUP BY DepartmentID
	ORDER BY DepartmentID

--14

SELECT 
	DepartmentID, MIN(Salary)
	FROM Employees
	WHERE DepartmentID IN(2,5,7) AND HireDate > '2000-01-01'
	GROUP BY DepartmentID

--15

SELECT *
INTO MyNewTable
	FROM Employees
	WHERE Salary > 30000 

DELETE FROM MyNewTable 
WHERE ManagerID = 42

UPDATE MyNewTable
SET Salary += 5000
WHERE DepartmentID = 1

SELECT 
DepartmentID,
AVG(Salary)
FROM MyNewTable
GROUP BY DepartmentID

--16

SELECT
DepartmentID, MAX(Salary)
FROM Employees
GROUP BY DepartmentID
HAVING MAX(Salary) NOT BETWEEN 30000 AND 70000


--17

SELECT
COUNT(Salary) AS [Count]
FROM Employees
WHERE ManagerID IS NULL

--18
SELECT DepartmentID, Salary AS ThirdHighestSalary
FROM
(
	SELECT DepartmentID,
			Salary,
			DENSE_RANK() OVER (PARTITION BY DepartmentID ORDER BY Salary DESC) AS [SalaryRank]
	FROM Employees
	GROUP BY DepartmentID,Salary --за да вземе само уникалните
	)AS [SalaryRankQuery]
WHERE SalaryRank = 3



