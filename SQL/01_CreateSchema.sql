/****************************************************************************************************
!! SCRIPT 01 – CREATE COMPLETE HR ANALYTICS DATABASE SCHEMA (BRUCE MODE ACTIVATED)
   Database: TechCorp_HR_Analytics
   Purpose : Drops + recreates the database, builds all tables, and adds all foreign keys.
   SAFE TO RE-RUN – FULL REBUILD EACH RUN
*****************************************************************************************************/

PRINT '========================';
PRINT 'SCRIPT 01 STARTING...';
PRINT 'Dropping database if it exists';
PRINT '========================';

----------------------------------------------------------------------------------------------------
-- 1. DROP DATABASE IF EXISTS
----------------------------------------------------------------------------------------------------
IF DB_ID('TechCorp_HR_Analytics') IS NOT NULL
BEGIN
    ALTER DATABASE TechCorp_HR_Analytics SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE TechCorp_HR_Analytics;
    PRINT 'Existing TechCorp_HR_Analytics database dropped.';
END;
GO

----------------------------------------------------------------------------------------------------
-- 2. CREATE DATABASE
----------------------------------------------------------------------------------------------------
CREATE DATABASE TechCorp_HR_Analytics;
GO
PRINT 'Database TechCorp_HR_Analytics created successfully.';

USE TechCorp_HR_Analytics;
GO

----------------------------------------------------------------------------------------------------
-- 3. CREATE HR SCHEMA
----------------------------------------------------------------------------------------------------
IF NOT EXISTS (SELECT 1 FROM sys.schemas WHERE name = 'HR')
BEGIN
    EXEC('CREATE SCHEMA HR;');
    PRINT 'HR schema created.';
END;
ELSE
    PRINT 'HR schema already exists.';

----------------------------------------------------------------------------------------------------
-- 4. CREATE TABLES
----------------------------------------------------------------------------------------------------
PRINT 'Creating tables...';

---------------------------------------------------------
-- Departments
---------------------------------------------------------
CREATE TABLE HR.Departments (
    DepartmentID INT IDENTITY(1,1) PRIMARY KEY,
    DepartmentName VARCHAR(100) NOT NULL UNIQUE
);
PRINT 'Table: HR.Departments created.';

---------------------------------------------------------
-- JobTitles
---------------------------------------------------------
CREATE TABLE HR.JobTitles (
    JobTitleID INT IDENTITY(1,1) PRIMARY KEY,
    JobTitle VARCHAR(150) NOT NULL UNIQUE
);
PRINT 'Table: HR.JobTitles created.';

---------------------------------------------------------
-- JobGrades
---------------------------------------------------------
CREATE TABLE HR.JobGrades (
    JobGradeID INT IDENTITY(1,1) PRIMARY KEY,
    GradeLevel INT NOT NULL,
    Description VARCHAR(200)
);
PRINT 'Table: HR.JobGrades created.';

---------------------------------------------------------
-- FirstNames
---------------------------------------------------------
CREATE TABLE HR.FirstNames (
    FirstNameID INT IDENTITY(1,1) PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL UNIQUE
);
PRINT 'Table: HR.FirstNames created.';

---------------------------------------------------------
-- LastNames
---------------------------------------------------------
CREATE TABLE HR.LastNames (
    LastNameID INT IDENTITY(1,1) PRIMARY KEY,
    LastName VARCHAR(100) NOT NULL UNIQUE
);
PRINT 'Table: HR.LastNames created.';

---------------------------------------------------------
-- Employees
---------------------------------------------------------
CREATE TABLE HR.Employees (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,
    FirstNameID INT NOT NULL,
    LastNameID INT NOT NULL,
    Gender CHAR(1) NOT NULL,
    JobTitleID INT NOT NULL,
    DepartmentID INT NOT NULL,
    HireDate DATE NOT NULL
);
PRINT 'Table: HR.Employees created.';

---------------------------------------------------------
-- Employee Compensation
---------------------------------------------------------
CREATE TABLE HR.EmployeeCompensation (
    CompensationID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    JobGradeID INT NOT NULL,
    EffectiveDate DATE NOT NULL,
    AnnualSalary DECIMAL(18,2) NOT NULL
);
PRINT 'Table: HR.EmployeeCompensation created.';

---------------------------------------------------------
-- Employee Hire History
---------------------------------------------------------
CREATE TABLE HR.EmployeeHireHistory (
    HireHistoryID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    OldDepartmentID INT NULL,
    NewDepartmentID INT NOT NULL,
    OldJobTitleID INT NULL,
    NewJobTitleID INT NOT NULL,
    ChangeDate DATE NOT NULL
);
PRINT 'Table: HR.EmployeeHireHistory created.';

---------------------------------------------------------
-- Appraisal Categories
---------------------------------------------------------
CREATE TABLE HR.AppraisalCategories (
    CategoryID INT IDENTITY(1,1) PRIMARY KEY,
    CategoryName VARCHAR(150) NOT NULL
);
PRINT 'Table: HR.AppraisalCategories created.';

---------------------------------------------------------
-- Employee Appraisals
---------------------------------------------------------
CREATE TABLE HR.EmployeeAppraisals (
    AppraisalID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    CategoryID INT NOT NULL,
    AppraisalDate DATE NOT NULL,
    Score INT NOT NULL CHECK (Score BETWEEN 1 AND 5),
    Comments VARCHAR(500)
);
PRINT 'Table: HR.EmployeeAppraisals created.';

---------------------------------------------------------
-- Skill Sets
---------------------------------------------------------
CREATE TABLE HR.SkillSets (
    SkillID INT IDENTITY(1,1) PRIMARY KEY,
    SkillName VARCHAR(150) NOT NULL UNIQUE
);
PRINT 'Table: HR.SkillSets created.';

---------------------------------------------------------
-- Employee Skills
---------------------------------------------------------
CREATE TABLE HR.EmployeeSkills (
    EmployeeSkillID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    SkillID INT NOT NULL,
    ProficiencyLevel INT NOT NULL CHECK (ProficiencyLevel BETWEEN 1 AND 5)
);
PRINT 'Table: HR.EmployeeSkills created.';

---------------------------------------------------------
-- Training Status
---------------------------------------------------------
CREATE TABLE HR.TrainingStatus (
    StatusID INT IDENTITY(1,1) PRIMARY KEY,
    StatusName VARCHAR(50) NOT NULL UNIQUE
);
PRINT 'Table: HR.TrainingStatus created.';

---------------------------------------------------------
-- Training Courses
---------------------------------------------------------
CREATE TABLE HR.TrainingCourses (
    CourseID INT IDENTITY(1,1) PRIMARY KEY,
    CourseName VARCHAR(200) NOT NULL,
    DefaultStatusID INT NOT NULL
);
PRINT 'Table: HR.TrainingCourses created.';

---------------------------------------------------------
-- Training Enrollments
---------------------------------------------------------
CREATE TABLE HR.TrainingEnrollments (
    EnrollmentID INT IDENTITY(1,1) PRIMARY KEY,
    EmployeeID INT NOT NULL,
    CourseID INT NOT NULL,
    StatusID INT NOT NULL,
    EnrollmentDate DATE NOT NULL
);
PRINT 'Table: HR.TrainingEnrollments created.';

----------------------------------------------------------------------------------------------------
-- 5. FOREIGN KEYS
----------------------------------------------------------------------------------------------------
PRINT 'Adding foreign keys...';

ALTER TABLE HR.Employees
ADD CONSTRAINT FK_Emp_First FOREIGN KEY (FirstNameID) REFERENCES HR.FirstNames(FirstNameID),
    CONSTRAINT FK_Emp_Last FOREIGN KEY (LastNameID) REFERENCES HR.LastNames(LastNameID),
    CONSTRAINT FK_Emp_Job FOREIGN KEY (JobTitleID) REFERENCES HR.JobTitles(JobTitleID),
    CONSTRAINT FK_Emp_Dept FOREIGN KEY (DepartmentID) REFERENCES HR.Departments(DepartmentID);

ALTER TABLE HR.EmployeeCompensation
ADD CONSTRAINT FK_Comp_Emp FOREIGN KEY (EmployeeID) REFERENCES HR.Employees(EmployeeID),
    CONSTRAINT FK_Comp_Grade FOREIGN KEY (JobGradeID) REFERENCES HR.JobGrades(JobGradeID);

ALTER TABLE HR.EmployeeHireHistory
ADD CONSTRAINT FK_Hire_Emp FOREIGN KEY (EmployeeID) REFERENCES HR.Employees(EmployeeID),
    CONSTRAINT FK_Hire_OldDept FOREIGN KEY (OldDepartmentID) REFERENCES HR.Departments(DepartmentID),
    CONSTRAINT FK_Hire_NewDept FOREIGN KEY (NewDepartmentID) REFERENCES HR.Departments(DepartmentID),
    CONSTRAINT FK_Hire_OldJob FOREIGN KEY (OldJobTitleID) REFERENCES HR.JobTitles(JobTitleID),
    CONSTRAINT FK_Hire_NewJob FOREIGN KEY (NewJobTitleID) REFERENCES HR.JobTitles(JobTitleID);

ALTER TABLE HR.EmployeeAppraisals
ADD CONSTRAINT FK_App_Emp FOREIGN KEY (EmployeeID) REFERENCES HR.Employees(EmployeeID),
    CONSTRAINT FK_App_Cat FOREIGN KEY (CategoryID) REFERENCES HR.AppraisalCategories(CategoryID);

ALTER TABLE HR.EmployeeSkills
ADD CONSTRAINT FK_Skill_Emp FOREIGN KEY (EmployeeID) REFERENCES HR.Employees(EmployeeID),
    CONSTRAINT FK_Skill_Set FOREIGN KEY (SkillID) REFERENCES HR.SkillSets(SkillID);

ALTER TABLE HR.TrainingCourses
ADD CONSTRAINT FK_Course_Status FOREIGN KEY (DefaultStatusID) REFERENCES HR.TrainingStatus(StatusID);

ALTER TABLE HR.TrainingEnrollments
ADD CONSTRAINT FK_Enroll_Emp FOREIGN KEY (EmployeeID) REFERENCES HR.Employees(EmployeeID),
    CONSTRAINT FK_Enroll_Course FOREIGN KEY (CourseID) REFERENCES HR.TrainingCourses(CourseID),
    CONSTRAINT FK_Enroll_Status FOREIGN KEY (StatusID) REFERENCES HR.TrainingStatus(StatusID);

PRINT 'All foreign keys added successfully.';

----------------------------------------------------------------------------------------------------
-- END OF SCRIPT
----------------------------------------------------------------------------------------------------
PRINT 'SCRIPT 01 COMPLETED SUCCESSFULLY – DATABASE AND SCHEMA READY.';

