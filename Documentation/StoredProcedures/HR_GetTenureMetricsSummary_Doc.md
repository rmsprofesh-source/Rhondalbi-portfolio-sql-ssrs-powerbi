# Stored Procedure: HR.GetTenureMetricsSummary

## 📌 Purpose
This procedure returns **two datasets** that support HR reporting, dashboards, and BI analytics:

1. **Employee-level tenure details** (one row per employee)  
2. **High-level tenure summary metrics** (one KPI row)

It is designed for SSRS, Power BI, Excel exports, and any BI environment needing both detail and KPIs.

---

## ⚙️ How the Procedure Works

### 1️⃣ Safety Cleanup
Before executing, the procedure removes the temp table `#TenureData` if it already exists.  
This ensures a clean, error-free run.

---

### 2️⃣ Build the TenureData CTE
A CTE assembles all fields required to calculate tenure.  
For each employee, it generates:

- **FullName** (First + Last)  
- **HireDate**  
- **EffectiveEndDate**  
  - TerminationDate (if terminated)  
  - Today’s date (if active)  
- **TenureYears** (decimal years, 2-decimal precision)  
- **IsActive flag** (Active vs Terminated)

This CTE becomes the core dataset for all downstream tenure reporting.

---

### 3️⃣ Save the CTE to a Temp Table
The CTE is materialized into `#TenureData`.

Benefits:

- Prevents recalculating values  
- More stable for BI workloads  
- Enables returning multiple result sets  
- Follows common best practices for reporting procedures

---

### 4️⃣ Dataset #1 — Employee-Level Tenure Detail
This result set provides one row per employee.

**Fields returned:**

- EmployeeID  
- FullName  
- HireDate  
- EffectiveEndDate  
- TenureYears  
- EmployeeStatus  

Data is sorted by **longest tenure first**, which is optimal for reporting.

---

### 5️⃣ Dataset #2 — High-Level Summary Metrics
This result set returns **a single KPI row** with:

- **TotalEmployees** — number of employees  
- **ActiveEmployees** — employees still active  
- **TerminatedEmployees** — employees with a termination date  
- **AverageTenure** — average tenure across all employees  
- **MinTenure** — smallest tenure  
- **MaxTenure** — largest tenure  

Ideal for dashboard tiles and executive reports.

---

## 🧹 Cleanup
After returning both datasets, the procedure drops `#TenureData` to prevent tempdb clutter.

---

## 📌 When to Use This Procedure
Use this procedure when you need:

- Employee-level tenure reporting  
- KPI-level tenure metrics  
- SSRS datasets, Power BI visuals, or Excel exports  
- Workforce longevity insights  

It is optimized for repeatable BI reporting.

---

## ▶️ Usage Example
`EXEC HR.GetTenureMetricsSummary;`

This returns two result sets:

1. Employee-level tenure details  
2. One-row summary of tenure KPIs  

---

## 🔗 Dependencies
This procedure relies on:

- HR.Employees  
- HR.FirstNames  
- HR.LastNames  

Termination dates are supplied by **Script 04 — Add Terminations**.

---

## 📝 Notes
- Tenure logic is consistent for active and terminated employees.  
- Today’s date is used for active employees to maintain accurate tenure.  
- The output is deterministic (same input → same output).
