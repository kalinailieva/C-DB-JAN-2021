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

--долепя стринговете, като ако е NULL го изпуска
SELECT CONCAT (FirstName, ' ', LastName) FROM Employees

--като String.Join. Първо е делителя и после параметрите за съединяване
--Kalina*Ilieva
SELECT CONCAT_WS ('*', FirstName, LastName) FROM Employees

--реже символи, броенето е от едно, а не от нула
--от къде да среже, от кой символ и колко

SELECT SUBSTRING (FirstName,1,2) FROM Employees AS [First Two Letters]

--Заменя стринг с друг
--от коя колона е, кои думи се търсят, с какво се заменя
--ако искаме няколко букви, може Replace в Replace

SELECT TOP(10) REPLACE ([FirstName], 'Jo', '**')
FROM Employees
WHERE FirstName = 'John'


UPDATE Employees SET FirstName = REPLACE ([FirstName], 'Jo', '**')
WHERE FirstName = 'John'

--триене на низ отпред или отзад, спейс, табулации
--само trim реже от двете страни
SELECT TRIM/LTRIM/RTRIM ('   Kikiriki   ')

--дължина на низ
SELECT LEN(RTRIM ('   Kikiriki   '))--11

--пред всичко, което не е латиница, се слага N, за да го разбере.
--иначе отива в сървъра като ???????
SELECT LEN(RTRIM (N'   Kikiriki   '))

--селекция на символи вляво и вдясно LEFT/RIGHT

SELECT LEFT(FirstName,5) FROM Employees

--малки, големи букви. Работи и с различно от латиница
SELECT UPPER/LOWER(FirstName) FROM Employees

--обръща наопаки
SELECT REVERSE(FirstName) FROM Employees

--повтаря и долепа. Кое и колко бр.
SELECT REPLICATE(FirstName,10) FROM Employees

--форматира. Като string.Format
--p за процент
SELECT FORMAT(0.15, 'p')
SELECT FORMAT(GETDATE(), 'dd/MMMM/yyyy')
SELECT FORMAT(GETDATE(), 'MMMM') --месеца с думи
SELECT FORMAT(GETDATE(), 'dd/MMMM/yyyy', 'bg-BG')--трети параметър, култура
SELECT FORMAT(100.56, 'c', 'bg-BG') -->100.56 лв.

--форматиране на цифри
--p5 -> процент до петия знак
SELECT FORMAT(1.22569544, 'F2')

--преобразуване на данни/в какво, кое/
SELECT FORMAT(CONVERT(datetime, '2020-01-03'), 'MMMM')

--търси на кой индекс е конкретен стринг. Връща САМО първия срещнат. За това
--има опция за трети параметър - от кой индекс нататък да се търси
SELECT CHARINDEX ('ima','Kiro ima kotka')

--подпъхва низ на определена позиция в друг низ
--Стринг, от кой индекс да започва, колко да изтрие, кое да пъхне
SELECT STUFF ('Kiro ima kotka', 5, 0, '*')


--MATH OPERATIONS
--ако са цели числа, деленето винаги е едночислено
--за дробна част, то поне едната част трябва да е дробна
--decimal, float, int
--на нула не е позволено
--има модулно деление, което връща остатък 4%2=0
--има всякакви функции като в с#, търси ги в нета
--ясна документация с всички функции https://docs.microsoft.com/en-us/sql/odbc/reference/appendixes/numeric-functions?view=sql-server-ver15

/*когато двете са инт, а ни трябва дроб или се умножава всичко по 1,0 или
CAST(Quantity AS FLOAT) и продължаваме*/

SELECT SIGN(-10) --> връща знака
SELECT RAND() --> връща произволно число

--DATE FUNCTIONS

SELECT 
DATEPART(WEEKDAY/YEAR/HOUR/QUARTER, StartDate) --година от вече съществ.колона StartDate
FROM Projects

SELECT 
YEAR/MONTH/DAYStartDate)
FROM Projects

SELECT DATEADD(YEAR, 2, StartDate) FROM Projects -->добавя две години

SELECT DATEDIFF(day, StartDate, EndDate) FROM Projects -->разлика в дни, може да се избира и в друго

SELECT
	FirstName,
	ISNULL(MiddleName, 'no entry') AS MiddleName --остави празно, ако няма
	FROM Employees

SELECT COALESCE(NULL, 5, 6, NULL) --> връща първото не null

SELECT FirstName FROM Employees
ORDER BY FirstName -->БЕЗ СОРТИРОВКА НЕ РАБОТИ!!!!
OFFSET 10 ROWS --> пропуска и взема редове
FETCH NEXT 5 ROWS ONLY

--РАНГ ЛИСТА

SELECT * ,
ROW_NUMBER () OVER(ORDER BY Salary DESC),-->кой щеше да е, ако сорта е по заплата
--ако вземат една и съща заплата обаче, не се съобразява
RANK () OVER(ORDER BY Salary DESC) AS [Rank] -->ако има двама на първо, то до тях да пише едно
DENSE_RANK(),
NTILE(10)OVER(ORDER BY Salary DESC) AS Groups -->разпредели ги в 10 групи по заплата
SUM(Salary) OVER(ORDER BY Salary DESC) AS AccumulateSalary -->прави нова колона с акумулиране на заплати
FROM Employees
ORDER BY EmployeeID 
WHERE ...

--ТЪРСИ НЕЩО КОЕТО ИМА В СЕБЕ СИ ДРУГО
FROM ...
WHERE JobTitle LIKE '%Chief%'--или %chief , % замества 'каквото и да е' отпред или отзад. Това е wildcard. Работи като регекс има и други функции, виж документацията
Order BY Salary
