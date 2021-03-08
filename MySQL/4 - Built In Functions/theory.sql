SELECT * FROM Employees
SELECT * FROM Departments


SELECT CONCAT (e.FirstName, ' ', e.LastName) AS [Employee Name],
e.JobTitle
FROM Employees AS e

SELECT CONCAT (e.FirstName, ' ', e.LastName) AS [Employee Name],
e.JobTitle,
	CASE	
		WHEN e.FirstName IS NULL THEN 'No manager'
		ELSE CONCAT (e2.FirstName, ' ', e.LastName)
		END AS [Manager Name]
FROM Employees AS e
LEFT OUTER JOIN Employees AS e2
ON e.ManagerID = e2.EmployeeID

--������ �����������, ���� ��� � NULL �� �������
SELECT CONCAT (FirstName, ' ', LastName) FROM Employees

--���� String.Join. ����� � �������� � ����� ����������� �� �����������
--Kalina*Ilieva
SELECT CONCAT_WS ('*', FirstName, LastName) FROM Employees

--���� �������, �������� � �� ����, � �� �� ����
--�� ���� �� �����, �� ��� ������ � �����

SELECT SUBSTRING (FirstName,1,2) FROM Employees AS [First Two Letters]

--������ ������ � ����
--�� ��� ������ �, ��� ���� �� ������, � ����� �� ������
--��� ������ ������� �����, ���� Replace � Replace

SELECT TOP(10) REPLACE ([FirstName], 'Jo', '**')
FROM Employees
WHERE FirstName = 'John'


UPDATE Employees SET FirstName = REPLACE ([FirstName], 'Jo', '**')
WHERE FirstName = 'John'

--������ �� ��� ������ ��� �����, �����, ���������
--���� trim ���� �� ����� ������
SELECT TRIM/LTRIM/RTRIM ('   Kikiriki   ')

--������� �� ���
SELECT LEN(RTRIM ('   Kikiriki   '))--11

--���� ������, ����� �� � ��������, �� ����� N, �� �� �� �������.
--����� ����� � ������� ���� ???????
SELECT LEN(RTRIM (N'   Kikiriki   '))

--�������� �� ������� ����� � ������ LEFT/RIGHT

SELECT LEFT(FirstName,5) FROM Employees

--�����, ������ �����. ������ � � �������� �� ��������
SELECT UPPER/LOWER(FirstName) FROM Employees

--������ �������
SELECT REVERSE(FirstName) FROM Employees

--������� � ������. ��� � ����� ��.
SELECT REPLICATE(FirstName,10) FROM Employees

--���������. ���� string.Format
--p �� �������
SELECT FORMAT(0.15, 'p')
SELECT FORMAT(GETDATE(), 'dd/MMMM/yyyy')
SELECT FORMAT(GETDATE(), 'MMMM') --������ � ����
SELECT FORMAT(GETDATE(), 'dd/MMMM/yyyy', 'bg-BG')--����� ���������, �������
SELECT FORMAT(100.56, 'c', 'bg-BG') -->100.56 ��.

--����������� �� �����
--p5 -> ������� �� ����� ����
SELECT FORMAT(1.22569544, 'F2')

--������������� �� �����/� �����, ���/
SELECT FORMAT(CONVERT(datetime, '2020-01-03'), 'MMMM')

--����� �� ��� ������ � ��������� ������. ����� ���� ������ �������. �� ����
--��� ����� �� ����� ��������� - �� ��� ������ ������� �� �� �����
SELECT CHARINDEX ('ima','Kiro ima kotka')

--�������� ��� �� ���������� ������� � ���� ���
--������, �� ��� ������ �� �������, ����� �� ������, ��� �� �����
SELECT STUFF ('Kiro ima kotka', 5, 0, '*')


--MATH OPERATIONS
--��� �� ���� �����, �������� ������ � �����������
--�� ������ ����, �� ���� ������ ���� ������ �� � ������
--decimal, float, int
--�� ���� �� � ���������
--��� ������� �������, ����� ����� ������� 4%2=0
--��� �������� ������� ���� � �#, ����� �� � ����
--���� ������������ � ������ ������� https://docs.microsoft.com/en-us/sql/odbc/reference/appendixes/numeric-functions?view=sql-server-ver15

/*������ ����� �� ���, � �� ������ ���� ��� �� �������� ������ �� 1,0 ���
CAST(Quantity AS FLOAT) � ������������*/

SELECT SIGN(-10) --> ����� �����
SELECT RAND() --> ����� ���������� �����

--DATE FUNCTIONS

SELECT 
DATEPART(WEEKDAY/YEAR/HOUR/QUARTER, StartDate) --������ �� ���� �������.������ StartDate
FROM Projects

SELECT 
YEAR/MONTH/DAYStartDate)
FROM Projects

SELECT DATEADD(YEAR, 2, StartDate) FROM Projects -->������ ��� ������

SELECT DATEDIFF(day, StartDate, EndDate) FROM Projects -->������� � ���, ���� �� �� ������ � � �����

SELECT
	FirstName,
	ISNULL(MiddleName, 'no entry') AS MiddleName --������ ������, ��� ����
	FROM Employees

SELECT COALESCE(NULL, 5, 6, NULL) --> ����� ������� �� null

SELECT FirstName FROM Employees
ORDER BY FirstName -->��� ���������� �� ������!!!!
OFFSET 10 ROWS --> �������� � ����� ������
FETCH NEXT 5 ROWS ONLY

--���� �����

SELECT * ,
ROW_NUMBER () OVER(ORDER BY Salary DESC),-->��� ���� �� �, ��� ����� � �� �������
--��� ������ ���� � ���� ������� �����, �� �� ����������
RANK () OVER(ORDER BY Salary DESC) AS [Rank] -->��� ��� ����� �� �����, �� �� ��� �� ���� ����
DENSE_RANK(),
NTILE(10)OVER(ORDER BY Salary DESC) AS Groups -->���������� �� � 10 ����� �� �������
SUM(Salary) OVER(ORDER BY Salary DESC) AS AccumulateSalary -->����� ���� ������ � ����������� �� �������
FROM Employees
ORDER BY EmployeeID 
WHERE ...

--����� ���� ����� ��� � ���� �� �����
FROM ...
WHERE JobTitle LIKE '%Chief%'--��� %chief , % �������� '������� � �� �' ������ ��� �����. ���� � wildcard. ������ ���� ������ ��� � ����� �������, ��� ��������������
Order BY Salary
