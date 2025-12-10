# 📊 Stored Procedure: HR.GetTurnoverMetrics

## 📌 Purpose
This stored procedure calculates **monthly turnover metrics**, including:

- Headcount at the beginning of each month  
- Number of terminations occurring during the month  
- Turnover rate (terminations ÷ starting headcount)

These metrics support HR dashboards, turnover analytics, and workforce trend reporting.

---

## 📘 Business Rules

### 🔢 Headcount Rules
An employee counts as active at the month’s start if:

- They were hired **on or before** the first day of the month  
- They were **not terminated** before that date  

### ❌ Termination Rules
A termination belongs to a month if:

- `TerminationDate >= MonthStart`  
- `TerminationDate < MonthStart + 1 month`

### 📉 Turnover Rate Formula

TurnoverRate = Terminations / HeadcountStart


If `HeadcountStart = 0`, turnover is returned as **0** (prevents divide-by-zero errors).

### 📅 Month Boundaries
The procedure auto-generates a continuous month list from:

- Earliest employee HireDate → **current month**

Ensures no gaps in the turnover trend.

---

## ⚙️ Technical Logic Summary

### **1️⃣ Generate Month List (Months CTE)**
- Uses `DATEFROMPARTS()` to create the first day of each month  
- Builds a complete chronological sequence  
- Ensures full date coverage for long-range reporting  

---

### **2️⃣ Monthly Data (MonthlyData CTE)**
Calculates two core metrics:

- **HeadcountStart** — number of active employees at month start  
- **Terminations** — termination events during the month  

These metrics form the inputs for turnover calculations.

---

### **3️⃣ Final Output**
Returns a clean month-by-month turnover summary:

- **MonthStart**  
- **MonthEnd**  
- **HeadcountStart**  
- **Terminations**  
- **TurnoverRate**  

Results are always sorted chronologically (oldest → newest).

---

## 📄 Output Columns

| Column | Description |
|--------|-------------|
| **MonthStart** | First day of the reporting month |
| **MonthEnd** | Last day of the reporting month |
| **HeadcountStart** | Employee count at month start |
| **Terminations** | Terminations during the month |
| **TurnoverRate** | Terminations ÷ HeadcountStart |

---

## ▶️ Usage Example
```sql
EXEC HR.GetTurnoverMetrics;

🔗 Dependencies

This procedure relies on:

    HR.Employees

    HR.EmployeeHireHistory (indirectly—termination logic respects job change chronology)


---

