CREATE DATABASE Movies
USE Movies

CREATE TABLE Directors(
Id INT PRIMARY KEY IDENTITY NOT NULL,
DirectorName NVARCHAR(100) NOT NULL,
Notes NVARCHAR(500)
)

CREATE TABLE Genres(
Id INT PRIMARY KEY IDENTITY NOT NULL,
GenreName NVARCHAR(100) NOT NULL,
Notes NVARCHAR(500)
)

CREATE TABLE Categories(
Id INT PRIMARY KEY IDENTITY NOT NULL,
CategoryName NVARCHAR(100) NOT NULL,
Notes NVARCHAR(500)
)


CREATE TABLE Movies(
Id INT PRIMARY KEY IDENTITY NOT NULL,
Title NVARCHAR(200) NOT NULL,
DirectorId INT FOREIGN KEY REFERENCES Directors(Id) NOT NULL,
CopyrightYear INT,
[Length] NVARCHAR(10),
GenreId INT FOREIGN KEY REFERENCES Genres(Id) NOT NULL,
CategoryId INT FOREIGN KEY REFERENCES Categories(Id) NOT NULL,
Rating NUMERIC(4,2),
Notes NVARCHAR(500)
)
DROP TABLE Movies

INSERT INTO Directors(DirectorName)
VALUES
('Director1'),
('Director2'),
('Director3'),
('Director4'),
('Director5')

INSERT INTO Genres(GenreName)
VALUES
('Genre1'),
('Genre2'),
('Genre3'),
('Genre4'),
('Genre5')

INSERT INTO Categories(CategoryName)
VALUES
('Category1'),
('Category2'),
('Category3'),
('Category4'),
('Category5')

INSERT INTO Movies(Title,DirectorId, CopyrightYear, [Length], GenreId, CategoryId, Rating, Notes)
VALUES
('Title1',5,1996, '25:44', 3,3,6.8, 'some note Lorem'),
('Title2',4,1996, '', 2,3,6.8, 'some note Lorem'),
('Title3',5,1996, '25:44', 2,4,6.8, 'some note Lorem'),
('Title4',1,1996, '25:44', 5,3,6.8, 'some note Lorem'),
('Title5',2,1996, '25:44', 2,1,6.8, 'some note Lorem')


