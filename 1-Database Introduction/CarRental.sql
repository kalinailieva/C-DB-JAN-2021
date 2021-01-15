CREATE DATABASE CarRental
USE CarRental

CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY,
CategoryName NVARCHAR(50) NOT NULL,
DailyRate DECIMAL(6,2) NOT NULL,
WeeklyRate DECIMAL(6,2) NOT NULL,
MonthlyRate DECIMAL(6,2) NOT NULL,
WeekendRate DECIMAL(6,2) NOT NULL
) 

CREATE TABLE Cars(
Id INT PRIMARY KEY IDENTITY,
PlateNumber NVARCHAR(10) NOT NULL,
Manufacturer NVARCHAR(50) NOT NULL ,
Model NVARCHAR(50) NOT NULL,
CarYear SMALLINT NOT NULL,
CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
Doors SMALLINT NOT NULL,
Picture VARBINARY(MAX),
Condition NVARCHAR(10) NOT NULL,
Available BIT NOT NULL
)


CREATE TABLE Employees(
Id INT PRIMARY KEY IDENTITY ,
FirstName NVARCHAR(20) NOT NULL,
LastName NVARCHAR(20) NOT NULL,
Title NVARCHAR(50) NOT NULL,
Notes NVARCHAR(500)
)

CREATE TABLE Customers
(Id INT PRIMARY KEY IDENTITY,
DriverLicenceNumber INT UNIQUE NOT NULL,
FullName NVARCHAR(20) NOT NULL,
[Address] NVARCHAR(20) NOT NULL,
City  NVARCHAR(20) NOT NULL,
ZIPCode INT NOT NULL,
Notes NVARCHAR(500)
)

CREATE TABLE RentalOrders (
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
CustomerId INT FOREIGN KEY REFERENCES Customers(Id) NOT NULL,
CarId INT FOREIGN KEY REFERENCES Cars(Id) NOT NULL,
TankLevel INT NOT NULL,
KilometrageStart INT NOT NULL,
KilometrageEnd INT NOT NULL,
TotalKilometrage INT NOT NULL,
StartDate DATE NOT NULL,
EndDate DATE NOT NULL,
TotalDays INT NOT NULL,
RateApplied DECIMAL(6,2) NOT NULL,
TaxRate DECIMAL(6,2) NOT NULL,
OrderStatus NVARCHAR(20) NOT NULL,
Notes NVARCHAR(500)
)

INSERT INTO Categories (CategoryName, DailyRate, WeeklyRate, MonthlyRate, WeekendRate)
VALUES 
	('Small Cars', 20.00, 200.00, 6000.00, 400.00),
	('Middle Cars', 20.00, 200.00, 6000.00, 400.00),
	('Big Cars', 20.00, 200.00, 6000.00, 400.00)

INSERT INTO Cars (PlateNumber, Manufacturer, Model, CarYear, CategoryId, Doors, Condition, Available)
VALUES
	(123456, 'Volvo', '300', 1896, 1,4,'good',0),
	(123457, 'Pegeout', '300', 1896, 1,4,'good',1),
	(123458, 'TOyota', '300', 1896, 1,4,'good',1)

INSERT INTO Employees (FirstName, LastName, Title)
VALUES
('Mitko','Stoyanov', 'manager'),
('Maia','Stoyanova', 'office manager'),
('Kircho','Petkanov', 'sales representative')

INSERT INTO Customers (DriverLicenceNumber, FullName, [Address], City, ZIPCode)
VALUES
	(123658, 'Dragan  Kirov', 'Ruse, Sveta Gora 43','Ruse', 2568),
	(1236558, 'Mitko  Kirov', 'Ruse, Sveta Gora 43','Ruse', 2568),
	(123658455, 'Cveta  Kirov', 'Ruse, Sveta Gora 43','Ruse', 2568)

INSERT INTO RentalOrders (EmployeeId, CustomerId, CarId, TankLevel, KilometrageStart, KilometrageEnd, TotalKilometrage, StartDate, EndDate, TotalDays, RateApplied, TaxRate, OrderStatus)
VALUES
	(1,3,2, 50, 1,3,2, '2020-02-13', '2020-03-16', 25,4.16, 20.00, 'done'),
	(1,3,2, 50, 1,3,2, '2020-02-13', '2020-03-16', 25,4.16, 20.00, 'done'),
	(1,3,2, 50, 1,3,2, '2020-02-13', '2020-03-16', 25,4.16, 20.00, 'done')

