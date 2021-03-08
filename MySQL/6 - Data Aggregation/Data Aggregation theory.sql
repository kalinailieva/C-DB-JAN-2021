USE SoftUni

SELECT DepartmentId, AVG(Salary) --по какво са групирани и каква агрегираща от тази група се иска
FROM Employees
GROUP BY DepartmentID

SELECT JobTitle, COUNT(*) FROM Employees -- по колко записа от всеки job title има
GROUP BY JobTitle

SELECT JobTitle, DepartmentID, COUNT(*) AS CountFromJobTitle FROM Employees -- по колко записа от всеки job title има
GROUP BY JobTitle, DepartmentID -- сорт по два критерия

--АГРЕГИРАЩИ ФУНЦИИ ВЪРХУ GROUP BY

SELECT DepartmentId, COUNT(*),STRING_AGG(FirstName, ' ') 
-- колко броя записи има във всяка група
--изреди всички имена на един ред, групирани по департмънт ИД
FROM Employees
GROUP BY DepartmentID

--FROM,JOIN,WHERE са преди GROUP BY
SELECT d.Name, SUM(Salary) AS SumSalary
FROM Employees as e
JOIN Departments as d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentID IN (1,2,3) AND Salary > 5000
GROUP BY d.Name
--и вземи от вече групираните само тези групи, които:
HAVING SUM(Salary) > 500000 --where след Groupby е HAVING.Тук новите имена като SumSalary не работи!

--може да се правят всякакви изчисления, стига те да са смислени и да ги разбират агрегиращите функции

SELECT DepartmentID,
	MIN(HireDate) AS LastHireDate,
	MIN(Salary) AS MinSalary, MAX(Salary) AS MaxSalary,
	MAX(Salary) - MIN(Salary) AS Diff
FROM Employees
GROUP BY DepartmentID