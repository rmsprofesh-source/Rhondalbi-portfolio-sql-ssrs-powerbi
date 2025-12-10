# Stored Procedure: HR.GetHeadcountTrend

## 📌 Purpose
This stored procedure calculates the **monthly headcount** for the organization by determining how many employees were active during each month in the reporting timeline.

Headcount includes **all employees whose employment period overlaps a given month**.  
It supports:

- HR dashboards  
- Workforce planning  
- Staffing trend analysis  
- Executive reporting  

---

## 🧠 Business Rules

An employee is considered **active** for a reporting month if:

- **HireDate ≤ MonthEnd**  
- **AND (TerminationDate IS NULL OR TerminationDate ≥ MonthStart)**  

Additional rules:

- The procedure generates a **continuous list of months** from the earliest HireDate through the current month.  
- Headcount is calculated at the **start of each month**.  
- Output is fully **deterministic**, based on the existing HR.Employees table.

---

## 📅 Month Boundaries

| Boundary      | Definition                       |
|---------------|-----------------------------------|
| **MonthStart** | First day of the month           |
| **MonthEnd**   | Last day of the month (calculated)|

---

## ⚙️ Technical Logic Summary

### **1️⃣ Generate Month List (Months CTE)**
Creates a chronological sequence of reporting months beginning at the earliest employee HireDate and ending at the current month.

### **2️⃣ Determine Active Employees (MonthlyData CTE)**
Counts all employees who qualify as active during each month based on hire and termination dates.

### **3️⃣ Final Output**
Returns one row per month with:

- Start date  
- End date  
- Active employee headcount  

This produces a clean trend dataset ideal for SSRS, Power BI, and time-series analytics.

---

## 📤 Output Columns

| Column       | Description                                      |
|--------------|--------------------------------------------------|
| **MonthStart** | First day of the reporting month                |
| **MonthEnd**   | Last day of the reporting month                 |
| **Headcount**  | Total number of active employees in that month  |

---

## ▶️ Usage Example

```sql
EXEC HR.GetHeadcountTrend;
