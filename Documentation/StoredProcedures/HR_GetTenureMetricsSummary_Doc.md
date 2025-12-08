# Stored Procedure: HR.GetTenureMetricsSummary

## Purpose
This procedure returns two datasets that support HR reporting, dashboards, and general analytics work.  
The first dataset is a row-by-row list of employee tenure details, and the second provides a quick summary view with counts and tenure statistics.  
It is designed to be easy to use in SSRS, Power BI, or any BI environment that needs both detail and KPI-level data.

---

## How the procedure works

### 1. Safety Cleanup  
Before anything runs, the procedure removes a temp table named `#TenureData` if it happens to be left behind from a previous run.  
This avoids errors and ensures every execution starts clean.

---

### 2. Build the TenureData CTE  
A CTE is used to assemble all the fields needed to calculate tenure.  
For each employee, it creates a single row with:

- Full name (first + last)  
- HireDate  
- Effective end date  
  - TerminationDate if they’ve left  
  - Today’s date if they’re still active  
- Tenure in decimal years  
- A simple Active/Terminated flag  

This CTE becomes the core dataset for all tenure reporting.

---

### 3. Store the CTE in a Temp Table  
The contents of the CTE are saved into `#TenureData`.  
Using a temp table makes the procedure more stable, prevents re-running calculations, and allows the procedure to return multiple result sets without complications.  
It’s a common pattern in BI-style SQL.

---

### 4. Dataset #1 — Employee-Level Tenure Detail  
The first result set gives one row per employee.  
Instead of listing it in a table, here’s what each field means in normal language:

- **EmployeeID** — The employee number.  
- **FullName** — Combined first and last name so it’s easy to read.  
- **HireDate** — When the person started working.  
- **EffectiveEndDate** — Today’s date if they’re active, or their TerminationDate if they’re not.  
- **TenureYears** — How long they’ve been with the organization, in years (decimal format).  
- **EmployeeStatus** — A simple label showing whether the person is Active or Terminated.

The output is sorted by longest tenure first, which is generally more useful for reporting.

---

### 5. Dataset #2 — High-Level Summary Metrics  
The second dataset returns only one row and provides a quick snapshot of the organization’s overall tenure distribution.  
Here’s what the fields represent:

- **TotalEmployees** — How many employees are in the dataset.  
- **ActiveEmployees** — The number of people still working here.  
- **TerminatedEmployees** — How many have a termination date.  
- **AverageTenure** — The average tenure across all employees.  
- **MinTenure** — The shortest tenure anyone has.  
- **MaxTenure** — The longest tenure found.

This is the set of values you'd usually feed into KPI tiles or the top section of a dashboard.

---

## Cleanup  
After both datasets are returned, the procedure drops the temp table it created.  
This is just good housekeeping and prevents clutter in tempdb.

---

## When to use this procedure  
Use this procedure when you need:

- A clear list of tenure for each employee  
- A simple, reliable source for tenure-based KPIs  
- Data for an SSRS table, a Power BI visual, or an Excel export  
- HR dashboards or scorecards that include tenure metrics  

It’s structured for BI workloads and repeatable reporting.

---

## Usage Example

```sql
EXEC HR.GetTenureMetricsSummary;

This returns two result sets:

    Employee-level tenure details

    A one-row summary of tenure metrics

Dependencies

This procedure depends on the following tables:

    HR.Employees

    HR.FirstNames

    HR.LastNames

It also assumes termination dates were assigned by your termination script (Script 04).
Notes

    Tenure calculation is consistent across active and terminated employees.

    Today’s date is used as the end date for still-active employees so tenure remains accurate.

    Outputs are deterministic 

