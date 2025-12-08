# HR Analytics Dataset — System Overview

This project provides a complete HR Analytics environment that can be recreated using the included SQL scripts. Running these scripts in order sets up the database structure, loads the lookup values, and generates a consistent set of HR activity including employees, job changes, salaries, training records, skills, and performance reviews.

The output is **deterministic**—rebuilding the environment always produces the same dataset, making it straightforward to reset, validate, and work with across different machines.

---

## Purpose of the Dataset

The dataset models the core information found in many HR systems, including:

- Employee records  
- Departments and job titles  
- Job movement and promotions  
- Compensation changes  
- Training activity  
- Skill assignments  
- Performance evaluations  
- Termination and retention patterns  

It provides a reliable foundation for:

- SQL-based analytics  
- SSRS report development  
- Power BI modeling  
- BI practice and exploration  
- Trend and KPI analysis  

---

## Schema Overview

The database is organized into logical areas that reflect common HR domains.

### Core Entities
- Employees  
- Departments  
- Job titles  

### Activity & Historical Data
- Job change history  
- Salary history  
- Training completions  
- Employee skill assignments  
- Performance review entries  

### Lookup / Reference Tables
- Departments  
- Job title definitions  
- Skills  
- Training types  
- Rating scales  

Lookup values are loaded before generating employee activity to ensure consistent references across the system.

---

## Script Workflow

### **Script 01 — CreateSchema**
Creates the full database structure, including:
- Tables  
- Keys  
- Relationships  
- Constraints  
- Indexing  

This establishes the foundation for all other scripts.

---

### **Script 02 — LoadLookups**
Populates all lookup and reference tables with predefined data such as:
- Department names  
- Job titles  
- Skills  
- Rating scales  
- Training definitions  

These values support all subsequent HR activity.

---

### **Script 03 — GenerateEmployeesAndHistory**
Generates the complete HR activity layer, including:
- Employee records  
- Hire dates  
- Job progression  
- Salary changes  
- Assigned skills  
- Training events  
- Performance review data  

All values follow deterministic rules, ensuring the same dataset is produced every time the scripts are run.

---

### **Script 04 — AddTerminations**
Assigns termination dates based on consistent business rules:

- Terminations occur after each employee’s most recent job change  
- `TerminationDate = LastChangeDate + 7 days`  
- Approximately 15% of employees receive a termination date  
- The selection pattern is deterministic  

This script enables analysis related to turnover, tenure, and retention.

---

## Rebuilding the Database

To recreate the full HR Analytics environment, run the scripts in the following sequence:

1. **01_CreateSchema.sql**  
2. **02_LoadLookups.sql**  
3. **03_GenerateEmployeesAndHistory.sql**  
4. **04_AddTerminations.sql**

Running them in order will always produce the same, clean dataset.

---

## Intended Use

This dataset is well-suited for:

- HR reporting and analytics  
- SSRS paginated report development  
- Power BI dashboards and modeling  
- KPI and trend analysis  
- Exploratory SQL work  
- Learning and practicing BI concepts  

The structure reflects real-world HR systems, making it practical for hands-on analytics without relying on sensitive or proprietary organizational data.

---

## Notes

- All data is generated deterministically.  
- The environment can be rebuilt at any time simply by rerunning the scripts in order.  
- There are no external dependencies beyond SQL Server.  
