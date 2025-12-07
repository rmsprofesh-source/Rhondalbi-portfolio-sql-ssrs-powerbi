/****************************************************************************************************
!! SCRIPT 03 – GENERATE EMPLOYEES + FULL HR HISTORY (FINAL BRUCE MODE)
   Purpose:
     - Deterministic 15,000 employees
     - Annual compensation history (HireDate → 2024)
     - Appraisals (1 per category per year)
     - Skills (3 per employee)
     - Training enrollments
   SAFE TO RE-RUN – FULL WIPE EACH EXECUTION
*****************************************************************************************************/

USE TechCorp_HR_Analytics;
PRINT '========================';
PRINT 'SCRIPT 03 STARTING...';
PRINT '========================';
GO

/****************************************************************************************************
1. CLEAN EMPLOYEE-RELATED TABLES (IN CORRECT FK ORDER)
*****************************************************************************************************/

PRINT 'Clearing dependent tables...';

DELETE FROM HR.TrainingEnrollments;
DELETE FROM HR.EmployeeSkills;
DELETE FROM HR.EmployeeAppraisals;
DELETE FROM HR.EmployeeCompensation;
DELETE FROM HR.EmployeeHireHistory;
DELETE FROM HR.Employees;

PRINT 'All dependent tables cleared.';

/****************************************************************************************************
2. LOAD LOOKUP COUNTS
*****************************************************************************************************/

DECLARE 
    @FirstNameCount INT = (SELECT COUNT(*) FROM HR.FirstNames),
    @LastNameCount  INT = (SELECT COUNT(*) FROM HR.LastNames),
    @DeptCount      INT = (SELECT COUNT(*) FROM HR.Departments),
    @JobTitleCount  INT = (SELECT COUNT(*) FROM HR.JobTitles),
    @JobGradeCount  INT = (SELECT COUNT(*) FROM HR.JobGrades),
    @CategoryCount  INT = (SELECT COUNT(*) FROM HR.AppraisalCategories),
    @SkillCount     INT = (SELECT COUNT(*) FROM HR.SkillSets),
    @CourseCount    INT = (SELECT COUNT(*) FROM HR.TrainingCourses),
    @StatusCount    INT = (SELECT COUNT(*) FROM HR.TrainingStatus);

DECLARE 
    @Today DATE = CAST(GETDATE() AS DATE),
    @EndYear INT = 2024;

PRINT 'Lookup counts loaded.';

/****************************************************************************************************
3. GENERATE 15,000 DETERMINISTIC EMPLOYEES
*****************************************************************************************************/

PRINT 'Generating 15,000 employees...';

;WITH N AS (
    SELECT TOP (15000) ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS RowNum
    FROM sys.objects a CROSS JOIN sys.objects b
)
INSERT INTO HR.Employees (FirstNameID, LastNameID, Gender, JobTitleID, DepartmentID, HireDate)
SELECT
    ((n.RowNum - 1) % @FirstNameCount) + 1 AS FirstNameID,
    ((n.RowNum - 1) % @LastNameCount) + 1  AS LastNameID,
    CASE WHEN n.RowNum % 2 = 0 THEN 'M' ELSE 'F' END AS Gender,
    ((n.RowNum - 1) % @JobTitleCount) + 1 AS JobTitleID,
    ((n.RowNum - 1) % @DeptCount) + 1     AS DepartmentID,
    DATEADD(DAY, -(n.RowNum % 5500), @Today) AS HireDate  -- deterministic, past 15 years
FROM N n;

PRINT 'Employees inserted.';

/****************************************************************************************************
4. HIRE HISTORY
*****************************************************************************************************/

PRINT 'Inserting initial hire history...';

INSERT INTO HR.EmployeeHireHistory
    (EmployeeID, OldDepartmentID, NewDepartmentID, OldJobTitleID, NewJobTitleID, ChangeDate)
SELECT
    e.EmployeeID,
    NULL AS OldDepartmentID,
    e.DepartmentID AS NewDepartmentID,
    NULL AS OldJobTitleID,
    e.JobTitleID AS NewJobTitleID,
    e.HireDate
FROM HR.Employees e;

PRINT 'Hire history inserted.';

/****************************************************************************************************
5. COMPENSATION: ANNUAL RECORDS FROM HIREDATE → 2024
*****************************************************************************************************/

PRINT 'Generating annual compensation history...';

DECLARE @BaseSalary MONEY = 48000;

;WITH Emp AS (
    SELECT 
        e.EmployeeID,
        YEAR(e.HireDate) AS StartYear,
        e.HireDate
    FROM HR.Employees e
),
Years AS (
    SELECT EmployeeID, StartYear AS [Year]
    FROM Emp
    UNION ALL
    SELECT y.EmployeeID, y.[Year] + 1
    FROM Years y
    JOIN Emp e ON y.EmployeeID = e.EmployeeID
    WHERE y.[Year] + 1 <= @EndYear
)
INSERT INTO HR.EmployeeCompensation (EmployeeID, JobGradeID, EffectiveDate, AnnualSalary)
SELECT
    y.EmployeeID,
    ((y.[Year] - e.StartYear) % @JobGradeCount) + 1 AS JobGradeID,
    DATEFROMPARTS(y.[Year], 1, 1) AS EffectiveDate,
    @BaseSalary + ((y.[Year] - e.StartYear) * 2500) AS AnnualSalary
FROM Years y
JOIN Emp e ON y.EmployeeID = e.EmployeeID
OPTION (MAXRECURSION 32767);

PRINT 'Compensation history generated.';

/****************************************************************************************************
6. APPRAISALS: 1 PER CATEGORY PER YEAR (HireDate → 2024)
*****************************************************************************************************/

PRINT 'Generating appraisals...';

;WITH EY AS (
    SELECT 
        e.EmployeeID,
        YEAR(e.HireDate) AS StartYear
    FROM HR.Employees e
),
Years AS (
    SELECT EmployeeID, StartYear AS [Year]
    FROM EY
    UNION ALL
    SELECT y.EmployeeID, y.[Year] + 1
    FROM Years y
    JOIN EY e ON e.EmployeeID = y.EmployeeID
    WHERE y.[Year] + 1 <= @EndYear
)
INSERT INTO HR.EmployeeAppraisals (EmployeeID, CategoryID, AppraisalDate, Score, Comments)
SELECT
    y.EmployeeID,
    c.CategoryID,
    DATEFROMPARTS(y.[Year], 12, 31) AS AppraisalDate,
    ((y.EmployeeID + y.[Year] + c.CategoryID) % 5) + 1 AS Score,
    'Annual deterministic appraisal'
FROM Years y
CROSS JOIN HR.AppraisalCategories c
OPTION (MAXRECURSION 32767);

PRINT 'Appraisals generated.';

/****************************************************************************************************
7. SKILLS – ASSIGN 3 SKILLS PER EMPLOYEE
*****************************************************************************************************/

PRINT 'Assigning employee skills...';

INSERT INTO HR.EmployeeSkills (EmployeeID, SkillID, ProficiencyLevel)
SELECT
    e.EmployeeID,
    ((e.EmployeeID + s.SkillID) % @SkillCount) + 1 AS SkillID,
    ((e.EmployeeID + s.SkillID) % 5) + 1 AS ProficiencyLevel
FROM HR.Employees e
CROSS JOIN (SELECT TOP 3 SkillID FROM HR.SkillSets ORDER BY SkillID) s;

PRINT 'Employee skills assigned.';

/****************************************************************************************************
8. TRAINING ENROLLMENTS – 1 PER EMPLOYEE
*****************************************************************************************************/

PRINT 'Generating training enrollments...';

INSERT INTO HR.TrainingEnrollments (EmployeeID, CourseID, StatusID, EnrollmentDate)
SELECT
    e.EmployeeID,
    ((e.EmployeeID + DAY(e.HireDate)) % @CourseCount) + 1 AS CourseID,
    ((e.EmployeeID + MONTH(e.HireDate)) % @StatusCount) + 1 AS StatusID,
    DATEADD(YEAR, (YEAR(@EndYear) - YEAR(e.HireDate)) / 2, e.HireDate)
FROM HR.Employees e;

PRINT 'Training enrollments generated.';

/****************************************************************************************************
DONE
*****************************************************************************************************/

PRINT '========================';
PRINT 'SCRIPT 03 COMPLETED SUCCESSFULLY!';
PRINT 'FULL ENTERPRISE HR DATASET GENERATED.';
PRINT '========================';
GO

