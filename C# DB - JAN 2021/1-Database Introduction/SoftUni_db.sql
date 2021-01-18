CREATE DATABASE SOftUni
USE SoftUni

CREATE TABLE Towns(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Addresses(
	Id INT PRIMARY KEY IDENTITY,
	AddressText NVARCHAR(100) NOT NULL,
	TownId INT FOREIGN KEY REFERENCES Towns(Id) NOT NULL
)

CREATE TABLE Departments(
	Id INT PRIMARY KEY IDENTITY,
	[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Employees(
	Id INT PRIMARY KEY IDENTITY NOT NULL,
	FirstName NVARCHAR(30) NOT NULL,
	MiddleName NVARCHAR(30),
	LastName NVARCHAR(30) NOT NULL,
	JobTitle NVARCHAR(30) NOT NULL,
	DepartmentId INT FOREIGN KEY REFERENCES Departments(Id),
	HireDate DATE NOT NULL,
	Salary DECIMAL(10,2) NOT NULL,
	AddressId INT FOREIGN KEY REFERENCES Addresses(Id)
)

INSERT INTO Towns([Name])
VALUES
	('Sofia'),
	('Plovdiv'),
	('Varna'),
	('Burgas')

INSERT INTO Departments([Name])
VALUES
	('Engineering'),
	('Sales'),
	('Marketing'),
	('Software Development'),
	('Quality Assurance')

INSERT INTO Employees(FirstName, MiddleName, LastName,JobTitle, DepartmentId, HireDate, Salary)
VALUES
('Ivan','Ivanov', 'Ivanov','.NET Developer', 4, '2013-02-01', 3500.00),
('Petar','Petrov', 'Petrov','Senior Engineer', 1, '2004-03-02', 4000.00),
('Maria','Petrova', 'Ivanova','Intern', 5, '2016-08-28', 525.25),
('Georgi','Terziev', 'Ivanov','CEO', 2, '2007-12-09', 3000.00),
('Peter','Pan', 'Pan','Intern', 3, '2016-08-28', 599.88)

--Възможно е да даде грешка при въвеждането на датата. Не е ММ/ДД/ГГГГ

SELECT * FROM Towns
SELECT * FROM Departments
SELECT * FROM Employees

--Много лесно, само по кой критерий и ASC или DESC
SELECT * FROM Towns
ORDER BY [Name] ASC

SELECT * FROM Departments
ORDER BY [Name] ASC

SELECT * FROM Employees
ORDER BY Salary DESC

SELECT [Name] FROM Towns

SELECT [Name] FROM Departments

Select FirstName, LastName, JobTitle, Salary FROM Employees 

UPDATE Employees
SET Salary += Salary *0.1

SELECT Salary FROM Employees

