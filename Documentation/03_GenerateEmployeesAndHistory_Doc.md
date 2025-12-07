# Script 03 — Employee & HR Data Generation

## What This Script Does
Script 03 generates all employees and all related HR activity. This includes job assignments, salary history, promotions, transfers, skill assignments, training participation, and performance appraisals. The data looks realistic but is fully deterministic.

## How It Works
The script uses lookup tables and rule-based logic to:

- Create employees with hire dates and job assignments  
- Assign salaries based on job title and generate future salary changes  
- Create job history for promotions and department moves  
- Attach skills to employees  
- Generate training events over time  
- Produce performance review scores  



## Role in the Workflow
This script runs last. It depends on the schema (Script 01) and the lookup values (Script 02). After it finishes, the database is fully populated and ready to use.

