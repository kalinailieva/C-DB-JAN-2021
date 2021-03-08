--1
CREATE DATABASE TableRelations
USE TableRelations


CREATE TABLE Passports(
PassportID INT PRIMARY KEY IDENTITY(100,1),
PassportNumber NVARCHAR(20) NOT NULL
)
--SET IDENTITY_INSERT Passports ON

CREATE TABLE Persons(
PersonID INT PRIMARY KEY IDENTITY,
FirstName NVARCHAR(30) NOT NULL,
Salary DECIMAL(10,2) NOT NULL,
PassportID INT FOREIGN KEY REFERENCES Passports(PassportID)
)

INSERT INTO Passports(PassportID, PassportNumber)
VALUES
(101, 'N34FG21B'),
(102,'K65LO4R7'),
(103, 'ZE657QP2')

INSERT INTO Persons
VALUES
('Roberto', 43300.00, 102),
('Tom',56100.00, 103),
('Yana',60200.00,101)

SELECT * FROM Persons

--2
CREATE TABLE Manufacturers(
ManufacturerID INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50) NOT NULL,
EstablishedOn DATE NOT NULL
)
INSERT INTO Manufacturers
VALUES
	('BMW','1916/07/03'),
	('Tesla','01/01/2003'),
	('Lada','01/05/1966')



CREATE TABLE Models(
ModelID INT PRIMARY KEY IDENTITY(101,1),
[Name] NVARCHAR(50) NOT NULL,
ManufacturerID INT FOREIGN KEY REFERENCES Manufacturers(ManufacturerID)
)

INSERT INTO Models
VALUES
	('X1',1),
	('i6',1),
	('Model S',2),
	('Model X',2),
	('Model 3',2),
	('Nova',3)


--3
CREATE TABLE Students(
StudentID INT PRIMARY KEY IDENTITY,
[Name] NVARCHAR(50) NOT NULL
)
INSERT INTO Students
VALUES
	('Mila'),
	('Toni'),
	('Ron')

CREATE TABLE Exams(
ExamID INT PRIMARY KEY IDENTITY(101,1),

[Name] NVARCHAR(50) NOT NULL
)

INSERT INTO Exams
VALUES
	('SpringMVC'),
	('Neo4j'),
	('Oracle 11g')

CREATE TABLE StudentsExams(
StudentID INT FOREIGN KEY REFERENCES Students(STudentID),
ExamID INT FOREIGN KEY REFERENCES Exams(ExamID)

CONSTRAINT PK_CompositeStudentIDExamID
PRIMARY KEY(StudentID, ExamID)
)


INSERT INTO StudentsExams
VALUES
	(1,101),
	(1,102),
	(2,101),
	(3,103),
	(2,102),
	(2,103)

--4
CREATE TABLE Teachers(
TeacherID INT PRIMARY KEY,
[Name] NVARCHAR(50) NOT NULL,
ManagerID INT REFERENCES Teachers(TeacherID)
)

INSERT INTO Teachers VALUES
(101, 'John', NULL),
(102, 'Maya',106),
(103, 'Silvia', 106),
(104, 'Ted', 105),
(105, 'Mark', 101),
(106, 'Greta', 101)

--5
CREATE DATABASE OnlineStoreDatabase
USE OnlineStoreDatabase

CREATE TABLE Cities(
CityId INT PRIMARY KEY NOT NULL,
[Name] NVARCHAR(50) NOT NULL
)

CREATE TABLE Customers(
CustomerId INT PRIMARY KEY NOT NULL,
[Name] NVARCHAR(50) NOT NULL,
Birthday DATE,
CityID INT REFERENCES Cities(CityId)
)

CREATE TABLE Orders(
OrderId INT PRIMARY KEY NOT NULL,
CustomerId INT FOREIGN KEY REFERENCES Customers(CustomerId)
)

CREATE TABLE ItemTypes(
ItemTypeId INT PRIMARY KEY NOT NULL,
[Name] NVARCHAR(50)
)

CREATE TABLE Items(
ItemId INT PRIMARY KEY NOT NULL,
[Name] NVARCHAR(50) NOT NULL,
ItemType INT FOREIGN KEY REFERENCES ItemTypes(ItemTypeId)
)

CREATE TABLE OrderItems(
OrderId INT FOREIGN KEY REFERENCES Orders(OrderId),
ItemId INT FOREIGN KEY REFERENCES Items(ItemId),
CONSTRAINT PK_CompositeOrderIdItemId
PRIMARY KEY (OrderId, ItemId)
)


--6
CREATE DATABASE Students
USE Students

CREATE TABLE Majors(
MajorID INT PRIMARY KEY,
[Name] NVARCHAR(30) NOT NULL
)
CREATE TABLE Students(
StudentID INT PRIMARY KEY,
StudentNumber NVARCHAR(15) NOT NULL,
StudentName NVARCHAR(50),
MajorID INT FOREIGN KEY REFERENCES Majors(MajorID) NOT NULL
)
CREATE TABLE Payments(
PaymentID INT PRIMARY KEY,
PaymentDate SMALLDATETIME NOT NULL,
PaymentAmount DECIMAL(10,2) NOT NULL,
StudentID INT FOREIGN KEY REFERENCES Students(StudentID) NOT NULL
)
CREATE TABLE Subjects(
SubjectID INT PRIMARY KEY,
SubjectName NVARCHAR(30) NOT NULL
)
CREATE TABLE Agenda(
StudentID INT FOREIGN KEY REFERENCES Students(StudentID),
SubjectID INT FOREIGN KEY REFERENCES Subjects(SubjectID),
CONSTRAINT PK_CompositeStudentIDSubjectID
PRIMARY KEY(StudentID, SubjectID)
)

--9
SELECT m.MountainRange, p.PeakName, p.Elevation
FROM Peaks AS p
JOIN Mountains AS m
ON p.MountaintID = m.Id
WHERE m.MountainRange = 'Rila'
ORDER BY p.Elevation DESC