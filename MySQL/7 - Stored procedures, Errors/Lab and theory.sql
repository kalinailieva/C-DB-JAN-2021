FROM LAB

WHILE @Year <= 2005
BEGIN
	SELECT @Year, COUNT(*) FROM [Employees]
	WHERE DATEPART(year, [HireDate])
	SET @Year +=1;
END

BREAK -> ���������
CONTINUE -> ��������

FOR ����� � sql ����




CREATE OR ALTER FUNCTION udf_YearNumbers(@Year int, @Number int)
RETURNS int
AS
BEGIN
	DECLARE @result int; --����������� �� ���������

	WHILE (@Year < 2005)
	BEGIN
		SET @result =  @Year + @Number
		SET @Year +=1;
		END
	RETURN @result;

END

DROP FUNCTION dbo.udf_YearNumbers

SELECT dbo.udf_YearNumbers(2000, 5)

--�������, ����� ����� ������� ����� ��� �������, ���� ��� 
--������ ���� � null, �� ����� �������� ����

USE SoftUni

CREATE OR ALTER FUNCTION udf_GetDiffWeek
(@StartDate datetime, @EndDate datetime)
RETURNS int
AS
BEGIN
	IF(@EndDate IS NULL)
		SET @EndDate = GETDATE();

	RETURN DATEDIFF(week, @StartDate, @EndDate);
END

--���������� �� ������ �� ������ ������ � ������


--�������, ����� ����� ������� � ��������
CREATE OR ALTER FUNCTION ucf_GetCOuntOfEmployeesByHireYear(@Year int)
RETURNS TABLE
AS
RETURN
(
	SELECT COUNT(*) AS [Count] -- SELECT* �� �� ����� ������� ���������� �� ����������� ����� ���� ���� ������
		FROM Employees
		WHERE DATEPART(year, HireDate) = @Year
		)
		
--��������� �� ����� ������� �� ������, ����� ����� ��������??
SELECT * FROM [dbo].ucf_GetCOuntOfEmployeesByHireYear(2000)


--STORED PROCEDURES

USE SoftUni 
GO

CREATE PROC dbo.usp_SelectEmployeesBySeniorirty
AS
	SELECT *
	FROM Employees
	WHERE DATEDIFF(Year, HireDate, GETDATE()) >19
GO

EXEC dbo.usp_SelectEmployeesBySeniorirty


CREATE OR ALTER PROC sp_GetEmployeesByExperience
AS
	SELECT * FROM Employees
	WHERE DATEDIFF( year, HireDAte, GETDATE())>20
	UPDATE Employees
	SET DepartmentID = 7 WHERE DepartmentID = 10
GO

EXEC sp_GetEmployeesByExperience

--��� ������� ���������
CREATE OR ALTER PROC sp_GetEmployeesByExperience
(@Year int, @MinSalary money = 12000)
AS
	SELECT * FROM Employees
	WHERE DATEDIFF( year, HireDAte, GETDATE())>@Year
	AND Salary > @MinSalary
	ORDER BY HireDate

GO

EXEC sp_GetEmployeesByExperience 10 , 30000
--��� �� ������ ���� @MinSalary = 15000 � �.�.
--��� � ����������� � �������� �������� �� ������, �� �� ����� ��.
--� ��� �� � �������� ��� �����������, �� ����� �� ������ ����������


--*************
--������ �� �������� �������� �� ������, ������� � ����������
--���� �� ������, �� ���� ����
CREATE OR ALTER PROC sp_GetEmployeesCountByYear
(@Count int OUTPUT, @Year int = 2000)
AS
	SET @Count = (
			SELECT COUNT(*) FROM Employees
			WHERE YEAR(HireDate) > @Year)
GO

DECLARE @Count int;
EXEC sp_GetEmployeesCountByYear @Count OUTPUT
SELECT @Count;

--�������� �� ������ -> ����� �� �� ���� ��� ���� ������ ��������
IF (@Year <0) THROW 50001, 'The year must be positive', 1)

--*********** ������
CREATE PROC sp_InsertEmployeeForProject
	(@EmployeeId int, @ProjectId int)
AS
	DECLARE @ProjectsCount int;
	SET @ProjectsCount = (
		SELECT COUNT(*)
		FROM Employees
		WHERE EmployeeID = @EmployeeId);

	IF (@ProjectsCount >=3)
		THROW 5001, 'Employee must have no more than 3 projects',1;
		--��� � ������� ������ �������� 
	INSERT INTO EmployeesProjects(EmployeeID, ProjectID)
	VALUES (@EmployeeId, @ProjectId);
GO

EXEC sp_InsertEmployeeForProject 1, 6