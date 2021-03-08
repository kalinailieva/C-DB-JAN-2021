USE SoftUni

SELECT DepartmentId, AVG(Salary) --�� ����� �� ��������� � ����� ���������� �� ���� ����� �� ����
FROM Employees
GROUP BY DepartmentID

SELECT JobTitle, COUNT(*) FROM Employees -- �� ����� ������ �� ����� job title ���
GROUP BY JobTitle

SELECT JobTitle, DepartmentID, COUNT(*) AS CountFromJobTitle FROM Employees -- �� ����� ������ �� ����� job title ���
GROUP BY JobTitle, DepartmentID -- ���� �� ��� ��������

--���������� ������ ����� GROUP BY

SELECT DepartmentId, COUNT(*),STRING_AGG(FirstName, ' ') 
-- ����� ���� ������ ��� ��� ����� �����
--������ ������ ����� �� ���� ���, ��������� �� ���������� ��
FROM Employees
GROUP BY DepartmentID

--FROM,JOIN,WHERE �� ����� GROUP BY
SELECT d.Name, SUM(Salary) AS SumSalary
FROM Employees as e
JOIN Departments as d ON e.DepartmentID = d.DepartmentID
WHERE d.DepartmentID IN (1,2,3) AND Salary > 5000
GROUP BY d.Name
--� ����� �� ���� ����������� ���� ���� �����, �����:
HAVING SUM(Salary) > 500000 --where ���� Groupby � HAVING.��� ������ ����� ���� SumSalary �� ������!

--���� �� �� ������ �������� ����������, ����� �� �� �� �������� � �� �� �������� ������������ �������

SELECT DepartmentID,
	MIN(HireDate) AS LastHireDate,
	MIN(Salary) AS MinSalary, MAX(Salary) AS MaxSalary,
	MAX(Salary) - MIN(Salary) AS Diff
FROM Employees
GROUP BY DepartmentID