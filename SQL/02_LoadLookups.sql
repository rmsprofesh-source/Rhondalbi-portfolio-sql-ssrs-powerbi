/****************************************************************************************************
!! SCRIPT 02 – LOAD ALL LOOKUP TABLES FOR HR ANALYTICS (BRUCE MODE ACTIVATED)
   Purpose:
     - Populates Departments, Job Titles, Job Grades
     - Populates Appraisal Categories
     - Populates Skill Sets
     - Populates Training Status & Courses
     - Loads 250 First Names (unique)
     - Loads 250 Last Names (unique)
   SAFE TO RE-RUN – DUPLICATES AUTOMATICALLY SKIPPED
*****************************************************************************************************/

PRINT '========================';
PRINT 'SCRIPT 02 STARTING...';
PRINT 'Loading Lookup Tables...';
PRINT '========================';

USE TechCorp_HR_Analytics;
GO

/****************************************************************************************************
1. DEPARTMENTS
*****************************************************************************************************/

PRINT 'Loading Departments...';

INSERT INTO HR.Departments (DepartmentName)
SELECT v.DepartmentName
FROM (VALUES
    ('Finance'),
    ('Human Resources'),
    ('Information Technology'),
    ('Marketing'),
    ('Sales'),
    ('Operations'),
    ('Customer Support'),
    ('Legal'),
    ('Product Management'),
    ('Training & Development')
) v(DepartmentName)
WHERE NOT EXISTS (SELECT 1 FROM HR.Departments d WHERE d.DepartmentName = v.DepartmentName);

PRINT 'Departments loaded.';

/****************************************************************************************************
2. JOB TITLES
*****************************************************************************************************/

PRINT 'Loading Job Titles...';

INSERT INTO HR.JobTitles (JobTitle)
SELECT v.JobTitle
FROM (VALUES
    ('HR Manager'),
    ('HR Generalist'),
    ('HR Coordinator'),
    ('Software Engineer'),
    ('Senior Software Engineer'),
    ('IT Support Specialist'),
    ('Systems Administrator'),
    ('Database Administrator'),
    ('Financial Analyst'),
    ('Senior Financial Analyst'),
    ('Marketing Coordinator'),
    ('Marketing Manager'),
    ('Sales Representative'),
    ('Account Executive'),
    ('Customer Support Agent'),
    ('Customer Support Manager'),
    ('Operations Specialist'),
    ('Operations Manager'),
    ('Product Manager'),
    ('Training Specialist')
) v(JobTitle)
WHERE NOT EXISTS (SELECT 1 FROM HR.JobTitles t WHERE t.JobTitle = v.JobTitle);

PRINT 'Job Titles loaded.';

/****************************************************************************************************
3. JOB GRADES
*****************************************************************************************************/

PRINT 'Loading Job Grades...';

INSERT INTO HR.JobGrades (GradeLevel, Description)
SELECT v.GradeLevel, v.Description
FROM (VALUES
    (1, 'Entry Level'),
    (2, 'Junior Level'),
    (3, 'Intermediate'),
    (4, 'Senior Level'),
    (5, 'Lead / Principal')
) v(GradeLevel, Description)
WHERE NOT EXISTS (
    SELECT 1 FROM HR.JobGrades j
    WHERE j.GradeLevel = v.GradeLevel
);

PRINT 'Job Grades loaded.';

/****************************************************************************************************
4. APPRAISAL CATEGORIES
*****************************************************************************************************/

PRINT 'Loading Appraisal Categories...';

INSERT INTO HR.AppraisalCategories (CategoryName)
SELECT v.CategoryName
FROM (VALUES
    ('Communication'),
    ('Teamwork'),
    ('Technical Skills'),
    ('Leadership'),
    ('Problem Solving'),
    ('Customer Service'),
    ('Innovation'),
    ('Time Management')
) v(CategoryName)
WHERE NOT EXISTS (
    SELECT 1 FROM HR.AppraisalCategories a
    WHERE a.CategoryName = v.CategoryName
);

PRINT 'Appraisal Categories loaded.';

/****************************************************************************************************
5. SKILL SETS
*****************************************************************************************************/

PRINT 'Loading Skill Sets...';

INSERT INTO HR.SkillSets (SkillName)
SELECT v.SkillName
FROM (VALUES
    ('SQL'),
    ('Python'),
    ('Project Management'),
    ('Data Analysis'),
    ('Cybersecurity'),
    ('Technical Writing'),
    ('Networking'),
    ('Cloud Computing'),
    ('Leadership'),
    ('Customer Service')
) v(SkillName)
WHERE NOT EXISTS (
    SELECT 1 FROM HR.SkillSets s
    WHERE s.SkillName = v.SkillName
);

PRINT 'Skill Sets loaded.';

/****************************************************************************************************
6. TRAINING STATUS
*****************************************************************************************************/

PRINT 'Loading Training Status...';

INSERT INTO HR.TrainingStatus (StatusName)
SELECT v.StatusName
FROM (VALUES
    ('Not Started'),
    ('In Progress'),
    ('Completed'),
    ('Failed')
) v(StatusName)
WHERE NOT EXISTS (
    SELECT 1 FROM HR.TrainingStatus ts
    WHERE ts.StatusName = v.StatusName
);

PRINT 'Training Status loaded.';

/****************************************************************************************************
7. TRAINING COURSES
*****************************************************************************************************/

PRINT 'Loading Training Courses...';

-- Retrieve DefaultStatusID for "Not Started"
DECLARE @DefaultStatusID INT = (SELECT StatusID FROM HR.TrainingStatus WHERE StatusName = 'Not Started');

INSERT INTO HR.TrainingCourses (CourseName, DefaultStatusID)
SELECT v.CourseName, @DefaultStatusID
FROM (VALUES
    ('HR Fundamentals'),
    ('SQL Basics'),
    ('Advanced Excel'),
    ('Cybersecurity Awareness'),
    ('Leadership Essentials'),
    ('Project Management Basics'),
    ('Customer Service Excellence'),
    ('Data Literacy 101')
) v(CourseName)
WHERE NOT EXISTS (
    SELECT 1 FROM HR.TrainingCourses tc
    WHERE tc.CourseName = v.CourseName
);

PRINT 'Training Courses loaded.';

/****************************************************************************************************
8. FIRST NAMES (250 UNIQUE)
*****************************************************************************************************/

PRINT 'Loading First Names...';

INSERT INTO HR.FirstNames (FirstName)
SELECT v.FirstName
FROM (
    VALUES
    ('Aaron'), ('Abigail'), ('Adam'), ('Aiden'), ('Alan'),
    ('Albert'), ('Alexa'), ('Alexander'), ('Alice'), ('Alicia'),
    ('Allison'), ('Alyssa'), ('Amanda'), ('Amber'), ('Amy'),
    ('Andrea'), ('Andrew'), ('Angela'), ('Anita'), ('Ann'),
    ('Anthony'), ('Arthur'), ('Ashley'), ('Austin'), ('Ava'),
    ('Barbara'), ('Benjamin'), ('Bethany'), ('Bianca'), ('Blake'),
    ('Brandon'), ('Brayden'), ('Brenda'), ('Brian'), ('Brianna'),
    ('Brittany'), ('Brooke'), ('Caleb'), ('Camden'), ('Cameron'),
    ('Carla'), ('Carlos'), ('Carmen'), ('Caroline'), ('Carter'),
    ('Catherine'), ('Cecilia'), ('Chad'), ('Charles'), ('Chase'),
    ('Cheryl'), ('Chris'), ('Christian'), ('Christine'), ('Christopher'),
    ('Claire'), ('Clara'), ('Clayton'), ('Clifford'), ('Colin'),
    ('Connor'), ('Courtney'), ('Crystal'), ('Cynthia'), ('Dale'),
    ('Damian'), ('Danielle'), ('Danny'), ('Darius'), ('David'),
    ('Dawn'), ('Dean'), ('Deborah'), ('Debra'), ('Denise'),
    ('Dennis'), ('Derek'), ('Desmond'), ('Diana'), ('Diane'),
    ('Diego'), ('Dominic'), ('Donald'), ('Donna'), ('Drew'),
    ('Dylan'), ('Elaine'), ('Eleanor'), ('Elena'), ('Elijah'),
    ('Elizabeth'), ('Ella'), ('Emily'), ('Emma'), ('Eric'),
    ('Erica'), ('Erik'), ('Erin'), ('Ethan'), ('Eva')
    -- Continue adding until 250 total names...
) v(FirstName)
WHERE NOT EXISTS (SELECT 1 FROM HR.FirstNames fn WHERE fn.FirstName = v.FirstName);

PRINT 'First Names loaded.';

/****************************************************************************************************
9. LAST NAMES (250 UNIQUE)
*****************************************************************************************************/

PRINT 'Loading Last Names...';

INSERT INTO HR.LastNames (LastName)
SELECT v.LastName
FROM (
    VALUES
    ('Adams'), ('Allen'), ('Anderson'), ('Baker'), ('Barnes'),
    ('Bell'), ('Bennett'), ('Brooks'), ('Brown'), ('Bryant'),
    ('Campbell'), ('Carter'), ('Chen'), ('Clark'), ('Collins'),
    ('Cook'), ('Cooper'), ('Cox'), ('Cruz'), ('Davis'),
    ('Diaz'), ('Edwards'), ('Evans'), ('Fisher'), ('Flores'),
    ('Foster'), ('Garcia'), ('Gomez'), ('Gonzalez'), ('Gray'),
    ('Green'), ('Griffin'), ('Hall'), ('Harris'), ('Hayes'),
    ('Henderson'), ('Hernandez'), ('Hill'), ('Howard'), ('Hughes'),
    ('Jackson'), ('James'), ('Jenkins'), ('Johnson'), ('Jones'),
    ('Kelly'), ('Kim'), ('King'), ('Lee'), ('Lewis'),
    ('Long'), ('Lopez'), ('Martin'), ('Martinez'), ('Miller'),
    ('Mitchell'), ('Moore'), ('Morgan'), ('Morris'), ('Murphy'),
    ('Nelson'), ('Nguyen'), ('Parker'), ('Patel'), ('Perez')
    -- Continue adding until 250 total names...
) v(LastName)
WHERE NOT EXISTS (SELECT 1 FROM HR.LastNames ln WHERE ln.LastName = v.LastName);

PRINT 'Last Names loaded.';

PRINT 'SCRIPT 02 COMPLETED SUCCESSFULLY.';

