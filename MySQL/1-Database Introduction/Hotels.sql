CREATE DATABASE Hotel
USE Hotel

CREATE TABLE Employees (
Id INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(20) NOT NULL,
LastName NVARCHAR(20) NOT NULL,
Title NVARCHAR(20) NOT NULL,
Notes NVARCHAR(500)
)

INSERT INTO Employees (FirstName, LastName, Title)
VALUES
	('Kiro','Peshev', 'manager'),
	('Kiro1','Peshev', 'manager'),
	('Kiro1','Peshev', 'manager')

CREATE TABLE Customers (
AccountNumber INT PRIMARY KEY NOT NULL,
FirstName NVARCHAR(20) NOT NULL,
LastName NVARCHAR(20) NOT NULL,
PhoneNumber INT,
EmergencyName NVARCHAR(20) NOT NULL,
EmergencyNumber INT NOT NULL,
Notes NVARCHAR(500)
)


INSERT INTO Customers(AccountNumber, FirstName, LastName, PhoneNumber, EmergencyName, EmergencyNumber)
VALUES
	(123456,'Miki','Mouse', 0879025333, 'Mitka Tomova', 0879265478),
	(123457,'Miki','Mouse', 0879025333, 'Mitka Tomova', 0879265478),
	(123458,'Miki','Mouse', 0879025333, 'Mitka Tomova', 0879265478)



CREATE TABLE RoomStatus (
RoomStatus NVARCHAR(30) PRIMARY KEY NOT NULL,
Notes NVARCHAR(500) 
)
INSERT INTO RoomStatus(RoomStatus)
VALUES
	('Available'),
	('Cleaning'),
	('Occupied')


CREATE TABLE RoomTypes (
RoomType NVARCHAR(30) PRIMARY KEY NOT NULL,
Notes NVARCHAR(500) 
)

INSERT INTO RoomTypes(RoomType)
VALUES
	('Single'),
	('Double'),
	('Appartmant')

	
CREATE TABLE BedTypes (
BedType NVARCHAR(30) PRIMARY KEY NOT NULL,
Notes NVARCHAR(500) 
)

INSERT INTO BedTypes(BedType)
VALUES
	('Single'),
	('Double'),
	('KingSize')

	

CREATE TABLE Rooms (
RoomNumber NVARCHAR(10) UNIQUE NOT NULL,
RoomType NVARCHAR(30) FOREIGN KEY REFERENCES RoomTypes(RoomType),
BedType NVARCHAR(30) FOREIGN KEY REFERENCES BedTypes(BedType),
Rate INT,
RoomStatus NVARCHAR(20) NOT NULL,
Notes NVARCHAR(500)
)
INSERT INTO Rooms(RoomNumber, RoomType, BedType, Rate, RoomStatus)
VALUES
	('12A', 'Single', 'Single', 12, 'Available')
INSERT INTO Rooms(RoomNumber, RoomType, BedType, Rate, RoomStatus)
VALUES
	('12B', 'Single', 'Single', 12, 'Available'),
	('12C', 'Single', 'Single', 12, 'Available')

CREATE TABLE Payments (
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
PaymentDate DATE NOT NULL,
AccountNumber INT FOREIGN KEY REFERENCES Customers(AccountNumber) NOT NULL,
FirstDateOccupied DATE NOT NULL,
LastDateOccupied DATE NOT NULL,
TotalDays AS DATEDIFF (DAY,FirstDateOccupied,LastDateOccupied),
AmountCharged DECIMAL(10,2) NOT NULL,
TaxRate  DECIMAL(10,2)NOT NULL,
TaxAmount DECIMAL(10,2)NOT NULL,
PaymentTotal AS AmountCharged + TaxAmount ,
Notes NVARCHAR(500)
)



INSERT INTO Payments(EmployeeId,PaymentDate, AccountNumber, FirstDateOccupied,
LastDateOccupied,AmountCharged, TaxRate, TaxAmount)
VALUES
	(1,'2020-02-13', 123456, '2020-02-16', '2020-02-17', 20.00, 15.00, 35.00),
	(1,'2020-02-13', 123456, '2020-02-16', '2020-02-17', 20.00, 15.00, 35.00),
	(1,'2020-02-13', 123456, '2020-02-16', '2020-02-17', 20.00, 15.00, 35.00)

CREATE TABLE Occupancies (
Id INT PRIMARY KEY IDENTITY,
EmployeeId INT FOREIGN KEY REFERENCES Employees(Id) NOT NULL,
DateOccupied DATE NOT NULL,
AccountNumber NVARCHAR(50) NOT NULL,
RoomNumber NVARCHAR(10) FOREIGN KEY REFERENCES Rooms(RoomNumber),
RateApplied DECIMAL(5,2) NOT NULL,
PhoneCharge DECIMAL(5,2),
Notes NVARCHAR(500)
)

INSERT INTO Occupancies (EmployeeId, DateOccupied, AccountNumber, 
RoomNumber, RateApplied, PhoneCharge)
VALUES
	(1, '2020-12-16', 123456, '12A', 12.5, 12.00),
	(1, '2020-12-16', 123456, '12A', 12.5, 12.00),
	(1, '2020-12-16', 123456, '12A', 12.5, 12.00)


