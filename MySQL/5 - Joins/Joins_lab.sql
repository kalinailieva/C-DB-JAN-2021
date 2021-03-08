USE SoftUni

SELECT * FROM Employees
SELECT * FROM Departments

--*****JOIN/INNER JOIN***** ��� ���� � NULL �� �������� ������
--������ ����� ������� �� �������� �� join
--���� �� �������� <>= ��� �����. ���� �� ��� � ����� � AND
SELECT * FROM Employees
JOIN Departments ON Employees.DepartmentID = Departments.DepartmentID

--�������� �����
SELECT * FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID

--����� �� ���� ����� ������
SELECT e.FirstName, d.Name FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID

--*****LEFT/RIGHT JOIN*****�� �������� �����
--������ ������ ������ �����, � ��� ���� ���� ������, ������ �� null

--*****FULL OUTER JOIN*****�� �������� ������� �����, ������� ������

--JOIN����� ���� �� �� ����� ���� ���� ����

SELECT e.FirstName, d.Name FROM Employees AS e
JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
LEFT JOIN Towns t ON e.AddressID = t.AddressID
--���������� ������ ������ �� ��������!!!!!

--������ �� ����

--1

SELECT e.FirstName, e.LastName, t.[Name] AS Town, a.AddressText FROM Employees AS e
JOIN Addresses AS a ON e.AddressID = a.AddressID
JOIN Towns AS t ON a.TownID = t.TownID
ORDER BY FirstName, LastName

--2

SELECT 
	EmployeeID, 
	FirstName,
	LastName, 
	[Name] AS [DepartmentName]
	FROM Employees AS e
	JOIN Departments as d ON e.DepartmentID = d.DepartmentID
	WHERE d.[Name] = 'Sales'
	ORDER BY EmployeeID

SELECT *
	FROM Employees AS e
	JOIN Departments AS d ON e.DepartmentID = d.DepartmentID
	WHERE [HireDate] > '1999-01-01'
		AND (d.Name = 'Sales' OR d.Name = 'Finance')
		--��� d.Name IN('Sales','Finance' )

--����� ����� �� �� ������� �� ��� ������ �� ������ �������, �� �� ���� �����������
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

SELECT * FROM Employees


