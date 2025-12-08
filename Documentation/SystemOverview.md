# HR Analytics Dataset — System Overview

This project is a complete HR Analytics environment built using a controlled, deterministic data-generation process.  
The SQL scripts in this repository create the database structure, load lookup values, generate all HR activity, and prepare the dataset for reporting in SSRS, Power BI, and SQL-based analysis.

---

## Purpose of the Dataset

The goal of this environment is to model the everyday questions HR teams answer:

- Hiring activity and onboarding trends  
- Department movement and job progression  
- Salary changes over time  
- Training activity and skill development  
- Turnover patterns and retention insights  
- Tenure distribution and employee lifecycle metrics  

The dataset is designed for BI demonstrations, dashboard creation, and interview-ready SQL examples.

---

## Deterministic, Repeatable Data

The entire dataset is **deterministic**, meaning:

- Every run produces the exact same results  
- Reviewers, recruiters, or hiring managers can reproduce it on their own machine  
- Scripts are safe to re-run without randomness or drift  

This makes the environment ideal for tutorials, demos, and proof-of-skill exercises.

---

## Schema Overview

The HR schema includes all the core elements of a real-world HR system:

- **Employees**  
- **Departments**  
- **Job titles & job history**  
- **Salary history**  
- **Training records**  
- **Skills and employee-skill assignments**  
- **Performance appraisals**

Each table is linked using proper keys and constraints to ensure referential integrity and realistic behavior.

---

## Lookup-Driven Design

Lookup tables are loaded before any employees are generated.  
These include:

- Departments  
- Job titles  
- Training types  
- Skill definitions  
- Rating scales  
- Miscellaneous reference values  

Because lookups are created first, all downstream data is clean, consistent, and validated.

---

## Script Workflow

### **Script 01 — CreateSchema**
Creates:

- All tables  
- Primary/foreign keys  
- Constraints  
- Relationships  
- Schemas  

This establishes the entire HR data model structure.

---

### **Script 02 — LoadLookups**
Loads the static lookup values that every other script depends on.

These remain consistent across all environments and runs.

---

### **Script 03 — GenerateEmployeesAndHistory**
Builds the main dataset:

- Employees  
- Hire dates  
- Job history  
- Salary movement  
- Training activity  
- Skill assignments  
- Appraisal history  

All data follows deterministic patterns to ensure predictable results.

---

### **Script 04 — AddTerminations**
Adds controlled termination events for ~15% of employees.

Rules include:

- Termination date = 7 days after last job change  
- If no job history exists, base date is HireDate  
- Termination dates never exceed today  
- Logic is deterministic and repeatable  

This script completes the employee lifecycle and unlocks turnover and retention analytics.

---

## Analytics Stored Procedures

The system includes four BI-focused stored procedures designed for dashboards and HR reporting:

### **HR.GetHeadcountTrend**
Returns month-by-month headcount using hire/termination logic.

### **HR.GetTurnoverMetrics**
Calculates monthly turnover:  
headcount at start of month, terminations, turnover rate.

### **HR.GetRetentionSummary**
Provides a one-row snapshot of retention vs. terminations.

### **HR.GetTenureMetricsSummary**
Returns:  
1. Employee-level tenure details  
2. High-level tenure KPI metrics  

These procedures provide everything needed for SSRS reports, Power BI models, and SQL query demos.

---

## Result

When these scripts and procedures are run in order, they produce a complete, production-style HR Analytics environment that demonstrates:

- Data modeling  
- ETL logic  
- Query development  
- Stored procedure design  
- BI reporting skills  
- Real-world HR metrics and KPIs  

This environment forms the foundation for your BI Developer portfolio.

