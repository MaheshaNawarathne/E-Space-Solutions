USE master;
GO
IF DB_ID('ESpaceSolutions') IS NOT NULL
    DROP DATABASE ESpaceSolutions;
GO

-- Create new database
CREATE DATABASE ESpaceSolutions;
GO

USE ESpaceSolutions;
GO

-- Drop existing tables if they exist (in correct order due to FK constraints)
IF OBJECT_ID('ColonistTrip', 'U') IS NOT NULL DROP TABLE ColonistTrip;
IF OBJECT_ID('ColonistJob', 'U') IS NOT NULL DROP TABLE ColonistJob;
IF OBJECT_ID('Dependent', 'U') IS NOT NULL DROP TABLE Dependent;
IF OBJECT_ID('Pilot', 'U') IS NOT NULL DROP TABLE Pilot;
IF OBJECT_ID('Trip', 'U') IS NOT NULL DROP TABLE Trip;
IF OBJECT_ID('Colonist', 'U') IS NOT NULL DROP TABLE Colonist;
IF OBJECT_ID('E_Jet', 'U') IS NOT NULL DROP TABLE E_Jet;
IF OBJECT_ID('Job', 'U') IS NOT NULL DROP TABLE Job;
IF OBJECT_ID('House', 'U') IS NOT NULL DROP TABLE House;
GO

-- Create House Table
CREATE TABLE House (
    LotNo VARCHAR(20) PRIMARY KEY,
    NoOfRooms INT,
    SquareFeet INT
);
GO

-- Create Job Table
CREATE TABLE Job (
    JobID INT PRIMARY KEY,
    JobName VARCHAR(50),
    JobDescription VARCHAR(200)
);
GO

-- Create E_Jet Table
CREATE TABLE E_Jet (
    JetCode VARCHAR(20) PRIMARY KEY,
    NoOfSeats INT,
    NuclearEnginePower VARCHAR(20),
    MadeYear INT,
    Weight INT,
    PowerSource VARCHAR(20),
    JetType VARCHAR(50)
);
GO

-- Create Colonist Table
CREATE TABLE Colonist (
    MarsColonistID INT PRIMARY KEY,
    HouseLotNo VARCHAR(20) FOREIGN KEY REFERENCES House(LotNo),
    FirstName VARCHAR(50),
    MiddleName VARCHAR(50),
    LastName VARCHAR(50),
    DOB DATE,
    Age INT,
    Qualification VARCHAR(100),
    EarthAddress VARCHAR(100),
    Gender VARCHAR(10),
    FamilyMembersCount INT,
    CivilStatus VARCHAR(50)
);
GO

-- Create Dependent Table
CREATE TABLE Dependent (
    DependentID INT PRIMARY KEY,
    ColonistID INT FOREIGN KEY REFERENCES Colonist(MarsColonistID),
    Name VARCHAR(100),
    DOB DATE,
    Age INT,
    Gender VARCHAR(10),
    RelationshipToColonist VARCHAR(20)
);
GO

-- Create Pilot Table
CREATE TABLE Pilot (
    PilotID INT PRIMARY KEY,
    Name VARCHAR(50),
    Designation VARCHAR(50),
    Rank VARCHAR(50),
    SpaceHours INT,
    JetCode VARCHAR(20) FOREIGN KEY REFERENCES E_Jet(JetCode)
);
GO

-- Create Trip Table
CREATE TABLE Trip (
    TripID INT PRIMARY KEY,
    JetCode VARCHAR(20) FOREIGN KEY REFERENCES E_Jet(JetCode),
    LaunchDate DATE,
    ReturnDate DATE
);
GO

-- Create ColonistJob Table
CREATE TABLE ColonistJob (
    MarsColonistID INT FOREIGN KEY REFERENCES Colonist(MarsColonistID),
    JobID INT FOREIGN KEY REFERENCES Job(JobID),
    PRIMARY KEY (MarsColonistID, JobID)
);
GO

-- Create ColonistTrip Table
CREATE TABLE ColonistTrip (
    MarsColonistID INT FOREIGN KEY REFERENCES Colonist(MarsColonistID),
    TripID INT FOREIGN KEY REFERENCES Trip(TripID),
    PRIMARY KEY (MarsColonistID, TripID)
);
GO

-- Insert into House
INSERT INTO House (LotNo, NoOfRooms, SquareFeet) 
VALUES
('LOT01', 3, 1200),
('LOT02', 4, 1500),
('LOT03', 2, 800),
('LOT04', 5, 2000),
('LOT05', 3, 1100);
GO

-- Insert into Job
INSERT INTO Job (JobID, JobName, JobDescription)
VALUES
(1, 'Construction', 'Building habitats and infrastructure'),
(2, 'Medical', 'Providing healthcare to colonists'),
(3, 'Security', 'Maintaining colony safety and order'),
(4, 'Botany', 'Managing agricultural food production'),
(5, 'Engineering', 'Maintaining mechanical and electrical systems');
GO

-- Insert into E_Jet
INSERT INTO E_Jet (JetCode, NoOfSeats, NuclearEnginePower, MadeYear, Weight, PowerSource, JetType)
VALUES
('EJ-101', 50, '500MW', 2035, 85000, 'Nuclear', 'Type A - Nuclear Only'),
('EJ-202', 75, '750MW', 2037, 92000, 'Hybrid', 'Type B - Nuclear/Hydro'),
('EJ-303', 25, '1GW', 2039, 78000, 'Hydro-Nuc', 'Type C - Hydro-Nuc'),
('EJ-404', 60, '600MW', 2036, 88000, 'Nuclear', 'Type A - Nuclear Only'),
('EJ-505', 40, '800MW', 2038, 81000, 'Hybrid', 'Type B - Nuclear/Hydro');
GO

-- Insert into Colonist
INSERT INTO Colonist (MarsColonistID, HouseLotNo, FirstName, MiddleName, LastName, DOB, Age, Qualification, EarthAddress, Gender, FamilyMembersCount, CivilStatus) 
VALUES
(1001, 'LOT01', 'John', 'A', 'Doe', '1990-05-15', 33, 'PhD Physics', '123 Earth St', 'Male', 2, 'Married'),
(1002, 'LOT02', 'Jane', 'B', 'Smith', '1985-10-22', 38, 'MSc Engineering', '456 Mars Ave', 'Female', 0, 'Single'),
(1003, 'LOT03', 'Alex', 'C', 'Johnson', '1995-02-08', 28, 'MD Medicine', '789 Galaxy Rd', 'Non-Binary', 3, 'Married'),
(1004, 'LOT04', 'Maria', 'D', 'Garcia', '1988-12-30', 35, 'BSc Botany', '101 Sun Blvd', 'Female', 1, 'Divorced'),
(1005, 'LOT05', 'David', 'E', 'Lee', '1992-07-04', 31, 'PhD Chemistry', '202 Moon Cir', 'Male', 0, 'Single');
GO

-- Insert into Dependent
INSERT INTO Dependent (DependentID, ColonistID, Name, DOB, Age, Gender, RelationshipToColonist) 
VALUES
(1, 1001, 'Alice Doe', '2015-03-10', 8, 'Female', 'Daughter'),
(2, 1001, 'Bob Doe', '2018-08-25', 5, 'Male', 'Son'),
(3, 1003, 'Charlie Johnson', '2020-01-12', 3, 'Male', 'Son'),
(4, 1003, 'Diana Johnson', '2022-05-19', 1, 'Female', 'Daughter'),
(5, 1004, 'Eve Garcia', '2010-11-05', 13, 'Female', 'Daughter');
GO

-- Insert into Pilot
INSERT INTO Pilot (PilotID, Name, Designation, Rank, SpaceHours, JetCode) 
VALUES
(2001, 'Commander Shepard', 'Senior Pilot', 'Commander', 5000, 'EJ-101'),
(2002, 'Major Tom', 'Test Pilot', 'Major', 3500, 'EJ-202'),
(2003, 'Ellen Ripley', 'Flight Specialist', 'Captain', 4200, 'EJ-303'),
(2004, 'Luke Skywalker', 'Junior Pilot', 'Lieutenant', 2000, 'EJ-404'),
(2005, 'Sarah Connor', 'Combat Pilot', 'Major', 4800, 'EJ-505');
GO

-- Insert into Trip
INSERT INTO Trip (TripID, JetCode, LaunchDate, ReturnDate) 
VALUES
(3001, 'EJ-101', '2040-01-10', '2040-06-15'),
(3002, 'EJ-202', '2040-02-15', '2040-07-20'),
(3003, 'EJ-303', '2040-03-20', '2040-08-25'),
(3004, 'EJ-404', '2040-04-25', '2040-09-30'),
(3005, 'EJ-505', '2040-05-30', '2040-11-05');
GO

-- Insert into ColonistJob
INSERT INTO ColonistJob (MarsColonistID, JobID) 
VALUES
(1001, 5),
(1002, 1),
(1003, 2),
(1004, 4),
(1005, 3);
GO

-- Insert into ColonistTrip
INSERT INTO ColonistTrip (MarsColonistID, TripID) 
VALUES
(1001, 3001),
(1002, 3002),
(1003, 3003),
(1004, 3004),
(1005, 3005);
GO

-- CLEANUP PHASE
USE master;
GO

-- Clean up existing logins
IF EXISTS (SELECT 1 FROM sys.server_principals WHERE name = 'user1')
    DROP LOGIN user1;
GO

USE ESpaceSolutions;
GO

-- Clean up existing database users
IF EXISTS (SELECT 1 FROM sys.database_principals WHERE name = 'user1')
    DROP USER user1;
GO

USE ESpaceSolutions;

CREATE LOGIN user1 WITH PASSWORD = 'User123';

USE ESpaceSolutions;
CREATE USER user1 FOR LOGIN user1;

SELECT name, type_desc FROM sys.database_principals;


USE ESpaceSolutions;

-- Grant full control to sa ( redundant if sa is already sysadmin, but for the assignment)
GRANT CONTROL ON DATABASE::ESpaceSolutions TO sa WITH GRANT OPTION;

--Grant SELECT permission to user1 on all tables
GRANT SELECT ON DATABASE:: ESpaceSolutions TO user1;

--Rollback demonstration

USE ESpaceSolutions;

EXECUTE AS USER = 'user1';
--Trying to delete a record
BEGIN TRY 
	BEGIN TRANSACTION;
	DELETE FROM Dependent WHERE ColonistID = 1001;
	COMMIT TRANSACTION;
END TRY
BEGIN CATCH
	PRINT 'Error Occured:' + ERROR_MESSAGE();
	ROLLBACK TRANSACTION;
END CATCH

--tring to delete a record as sa
USE ESpaceSolutions;
BEGIN TRANSACTION;

--Deleting depndents of the colonist
DELETE FROM Dependent WHERE ColonistID = 1001;

--checking if it is deleted
SELECT * FROM Dependent WHERE ColonistID = 1011;

--Rollingback to restore the row
ROLLBACK TRANSACTION;

--Verifying it is back
SELECT * FROM Dependent WHERE ColonistID = 1001;

-- Query 1: Colonists with their dependents count and house details
SELECT 
    c.MarsColonistID,
    c.FirstName + ' ' + c.LastName AS FullName,
    c.Gender,
    c.CivilStatus,
    h.LotNo AS HouseLot,
    h.NoOfRooms,
    h.SquareFeet,
    COUNT(d.DependentID) AS NumberOfDependents
FROM Colonist c
INNER JOIN House h ON c.HouseLotNo = h.LotNo
LEFT JOIN Dependent d ON c.MarsColonistID = d.ColonistID
GROUP BY 
    c.MarsColonistID, 
    c.FirstName, 
    c.LastName, 
    c.Gender, 
    c.CivilStatus,
    h.LotNo,
    h.NoOfRooms,
    h.SquareFeet
ORDER BY c.MarsColonistID;
GO

-- Query 2: Upcoming trips with jet details and passenger count
SELECT 
    t.TripID,
    j.JetCode,
    j.JetType,
    j.NoOfSeats,
    t.LaunchDate,
    t.ReturnDate,
    p.Name AS PilotName,
    p.Rank AS PilotRank,
    COUNT(ct.MarsColonistID) AS PassengersBooked,
    (j.NoOfSeats - COUNT(ct.MarsColonistID)) AS SeatsAvailable
FROM Trip t
INNER JOIN E_Jet j ON t.JetCode = j.JetCode
INNER JOIN Pilot p ON j.JetCode = p.JetCode
LEFT JOIN ColonistTrip ct ON t.TripID = ct.TripID
GROUP BY 
    t.TripID,
    j.JetCode,
    j.JetType,
    j.NoOfSeats,
    t.LaunchDate,
    t.ReturnDate,
    p.Name,
    p.Rank
ORDER BY t.LaunchDate;
GO

-- Query 3: Colonists with their job assignments and qualifications
SELECT 
    c.MarsColonistID,
    c.FirstName + ' ' + c.LastName AS FullName,
    c.Qualification AS ColonistQualification,
    j.JobName,
    j.JobDescription,
    c.EarthAddress,
    CASE 
        WHEN c.FamilyMembersCount > 0 THEN 'With Family'
        ELSE 'Single Colonist'
    END AS FamilyStatus
FROM Colonist c
INNER JOIN ColonistJob cj ON c.MarsColonistID = cj.MarsColonistID
INNER JOIN Job j ON cj.JobID = j.JobID
ORDER BY j.JobName, c.LastName;
GO