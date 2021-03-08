FROM LAB

WHILE @Year <= 2005
BEGIN
	SELECT @Year, COUNT(*) FROM [Employees]
	WHERE DATEPART(year, [HireDate])
	SET @Year +=1;
END

BREAK -> приключва
CONTINUE -> продължи

FOR цикъл в sql НЯМА




CREATE OR ALTER FUNCTION udf_YearNumbers(@Year int, @Number int)
RETURNS int
AS
BEGIN
	DECLARE @result int; --деклариране на резултата

	WHILE (@Year < 2005)
	BEGIN
		SET @result =  @Year + @Number
		SET @Year +=1;
		END
	RETURN @result;

END

DROP FUNCTION dbo.udf_YearNumbers

SELECT dbo.udf_YearNumbers(2000, 5)

--функция, която връща разлика между две седмици, като ако 
--едната дата е null, то взема текущата дата

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

--обикновено се ползва да изведе колона в селект


--функция, която връща таблица с резултат
CREATE OR ALTER FUNCTION ucf_GetCOuntOfEmployeesByHireYear(@Year int)
RETURNS TABLE
AS
RETURN
(
	SELECT COUNT(*) AS [Count] -- SELECT* за да върне всиката информация за служителите наети през тази година
		FROM Employees
		WHERE DATEPART(year, HireDate) = @Year
		)
		
--функцията се явява таблица за селект, която връща резултат??
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

--със зададен параметър
CREATE OR ALTER PROC sp_GetEmployeesByExperience
(@Year int, @MinSalary money = 12000)
AS
	SELECT * FROM Employees
	WHERE DATEDIFF( year, HireDAte, GETDATE())>@Year
	AND Salary > @MinSalary
	ORDER BY HireDate

GO

EXEC sp_GetEmployeesByExperience 10 , 30000
--или се подава като @MinSalary = 15000 и т.н.
--ако в процедурата е посочена стойност по дефолт, то се взема тя.
--и ако не е уточнено при извикването, се взема по дефолт посочената


--*************
--врщане на резултат различен от селект, записан в променлива
--това не работи, не знам защо
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

--хвърляне на грешки -> пишат се на един ред като проста проверка
IF (@Year <0) THROW 50001, 'The year must be positive', 1)

--*********** ПРИМЕР
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
		--ако е хванало грешка прекъсва 
	INSERT INTO EmployeesProjects(EmployeeID, ProjectID)
	VALUES (@EmployeeId, @ProjectId);
GO

EXEC sp_InsertEmployeeForProject 1, 6