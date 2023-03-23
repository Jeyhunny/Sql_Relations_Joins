--Company adinda database yaradirsiz. 3 eded table olur:
--Employees(columns: Id, Name, Surname,Age, Salary, Position, IsDeleted), Cities(Id,Name), Countries(Id,Name). Relationlarini qurursuz.

CREATE DATABASE Company
USE Company

CREATE TABLE Employees(
  Id INT PRIMARY KEY IDENTITY(1,1),
  Name NVARCHAR(50) NOT NULL,
  Surname NVARCHAR(50) NOT NULL,
  Age INT,
  Salary DECIMAL,
  Position NVARCHAR(50),
  IsDeleted BIT NOT NULL DEFAULT 0
)

CREATE TABLE Countries(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50)
)

CREATE TABLE Cities(
	Id INT PRIMARY KEY IDENTITY(1,1),
	Name NVARCHAR(50),
	CountryId INT FOREIGN KEY REFERENCES Countries(Id)
)

ALTER TABLE Employees ADD CityId INT FOREIGN KEY REFERENCES Cities(Id)

--*  Ishcilerin ozlerini, yashadiqi sheherlerini ve olkelerini gosterin.

SELECT emp.Name,emp.Surname,ct.Name,co.Name FROM ((Employees emp 
INNER JOIN Cities ct ON emp.CityId = ct.Id)
INNER JOIN Countries co ON ct.CountryId = co.Id)


 --*  Maashi 2000-den yuxari olan ishcilerin adlari ve yashadiqi olkeleri gosterin.

 SELECT emp.Name,co.Name FROM ((Employees emp 
 INNER JOIN Cities ct ON emp.CityId = ct.Id)
 INNER JOIN Countries co ON co.Id = ct.CountryId)
 where emp.Salary > 2000

 --*  Hansi sheherin hansi olkeye aid olduqunu gosterin.
SELECT co.Name,ct.Name FROM Countries co INNER JOIN Cities ct ON ct.CountryId = co.Id


--*  Positioni "Reseption" olan ishcilerin table-larin id-leri daxil olmamaq sherti ile butun melumatlarini gostermek.
SELECT emp.Name,emp.Surname,emp.Age,emp.Position,emp.Salary,emp.IsDeleted,emp.CityId FROM Employees emp WHERE emp.Position = 'Reception'

 --* Ishden cixan ishcilerin yashadiqi sheher ve olkeleri, hemcinin ishcilerin oz ad ve soyadlarini gosteren query yazin.

 SELECT emp.Name,emp.Surname,co.Name,ct.Name FROM ((Employees emp 
 INNER JOIN Cities ct ON emp.CityId = ct.Id)
 INNER JOIN Countries co ON co.Id = ct.CountryId)
 where emp.IsDeleted = 1