# HR Analytics Dataset — System Overview

This project is a full HR Analytics environment built from three SQL scripts. Together, these scripts create the database structure, load all the standardized lookup values, and generate a complete set of HR activity: employees, job history, salary movement, training, skills, and performance reviews. 

## Purpose of the Dataset
This dataset models the everyday questions HR teams deal with — hiring trends, salary progression, department movement, performance outcomes, training activity, turnover, and skill distribution. 

## Deterministic Data
The data generation follows deterministic rules, which means the output is identical every time the scripts run. This makes the environment easy to reproduce, validate, and compare across machines or demo sessions. Anyone reviewing the project can run the same scripts and end up with the same dataset.

## Schema Overview
The schema includes all the core elements of a typical HR system:

- Employees  
- Departments  
- Job titles  
- Salary history  
- Job history  
- Training records  
- Skills and employee-skill assignments  
- Performance appraisals  



## Lookup-Driven Design
Lookup tables (departments, job titles, skills, training types, rating scales, etc.) are loaded before any employees are generated. 

## Script Workflow
### Script 01 — CreateSchema  
Builds all tables, keys, constraints, and relationships.

### Script 02 — LoadLookups  
Loads the static reference values the system depends on.

### Script 03 — GenerateEmployeesAndHistory  
Creates employees and generates all related HR activity using deterministic rules.

When run in order, these scripts produce a complete, ready-to-use HR Analytics database that works perfectly with SSRS, Power BI, and SQL query demos.

