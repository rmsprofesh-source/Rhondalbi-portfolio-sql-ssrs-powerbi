# Stored Procedure: HR.GetTenureMetricsSummary

## 📌 Purpose
This procedure returns **two datasets** that support HR reporting, dashboards, and BI analytics:

1. **Employee-level tenure details** (one row per employee)  
2. **High-level tenure summary metrics** (one KPI row)

It is designed for SSRS, Power BI, Excel exports, and any BI environment needing both detail and KPIs.

---

## ⚙️ How the Procedure Works

### **1️⃣ Safety Cleanup**
Before executing, the procedure removes the temp table `#TenureData` if it already exists.  
This ensures a clean, error-free run.

---

### **2️⃣ Build the TenureData CTE**
A CTE assembles all fields required to calculate tenure.  
For each employee, it generates:

- **FullName** (First + Last)  
- **HireDate**  
- **EffectiveEndDate**  
  - TerminationDate (if terminated)  
  - Today’s date (if active)  
- **TenureYears** (decimal years, 2-decimal precision)  
- **IsActive flag** (1 = Active, 0 = Terminated)

This CTE becomes the core dataset for all downstream tenure reporting.

---

### **3️⃣ Save the CTE to a Temp Table**
The CTE is materialized into `#TenureData`.

Why?

- Prevents recalculating values  
- More stable for BI workloads  
- Allows multiple result sets (detail + summary)  
- Common best practice for SQL-based reporting

---

### **4️⃣ Dataset #1 — Employee-Level Tenure Detail**
This result set provides one row per employee.  
Fields include:

| Field | Meaning |
|-------|---------|
| **EmployeeID** | The employee’s ID |
| **FullName** | Human-readable combined name |
| **HireDate** | Original hire date |
| **EffectiveEndDate** | TerminationDate or Today |
| **TenureYears** | Tenure in decimal years |
| **EmployeeStatus** | “Active” or “Terminated” |

Rows are returned **sorted by longest tenure first**, which is ideal for reporting.

---

### **5️⃣ Dataset #2 — High-Level Summary Metrics**
This result set returns **one row** containing organization-level tenure KPIs:

| KPI | Description |
|------|-------------|
| **TotalEmployees** | Number of employees in dataset |
| **ActiveEmployees** | Count where still active |
| **TerminatedEmployees** | Count with a termination date |
| **AverageTenure** | Mean tenure across all employees |
| **MinTenure** | Shortest tenure |
| **MaxTenure** | Longest tenure |

These are perfect for dashboard tiles, scorecards, and summary visuals.

---

## 🧹 Cleanup
After returning both datasets, the procedure drops `#TenureData`.  
This prevents tempdb clutter and ensures future runs start clean.

---

## 📌 When to Use This Procedure
Use this procedure when you need:

- Detailed employee-level tenure reporting  
- KPI-level tenure metrics  
- Datasets for SSRS tables, Power BI visuals, or Excel  
- Workforce analytics related to longevity & employee lifecycle  

It is optimized for repeatable BI reporting.

---

## ▶️ Usage Example

sql
EXEC HR.GetTenureMetricsSummary;

This returns two result sets:

    Employee-level tenure details

    One-row summary of tenure KPIs

🔗 Dependencies

This procedure relies on the following tables:

    HR.Employees

    HR.FirstNames

    HR.LastNames

It also expects termination dates to be assigned via Script 04 — Add Terminations.
📝 Notes

    Tenure calculations are consistent for both active and terminated employees.

    Today’s date is used for active employees to maintain accurate tenure.

    All results are deterministic (same inputs → same outputs).
