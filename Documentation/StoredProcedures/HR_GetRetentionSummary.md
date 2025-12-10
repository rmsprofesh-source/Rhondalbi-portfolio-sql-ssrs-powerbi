# Stored Procedure: HR.GetRetentionSummary

## 📌 Purpose
This stored procedure calculates **overall employee retention statistics** for the organization.  
It summarizes:

- Total workforce size  
- How many employees remain active  
- How many employees have been terminated  
- The overall retention rate  

This procedure powers **executive dashboards, HR scorecards, and workforce stability reporting**.

---

## 🧠 Business Rules

- **TotalEmployees** = all rows in `HR.Employees`  
- **ActiveEmployees** = employees with `TerminationDate IS NULL`  
- **TerminatedEmployees** = employees with any non-NULL `TerminationDate`  
- **RetentionRate** = ActiveEmployees ÷ TotalEmployees  
- All values are computed **at execution time** for real-time reporting  

---

## ⚙️ Technical Logic Summary

### **1️⃣ Count Total Employees**
Retrieves the total number of employees from `HR.Employees`.

### **2️⃣ Count Active Employees**
Employees with no termination date (`TerminationDate IS NULL`) are considered active.

### **3️⃣ Count Terminated Employees**
Any employee with a non-NULL termination date is marked as terminated.

### **4️⃣ Calculate Retention Rate**
`RetentionRate = ActiveEmployees / TotalEmployees`  
Returned as a decimal formatted to two places.

### **5️⃣ Final Output**
Procedure returns **one row** containing all summary metrics — perfect for dashboards.

---

## 📤 Output Columns

| Column                | Description                                                |
|----------------------|------------------------------------------------------------|
| **TotalEmployees**      | Total number of employees in the system                  |
| **ActiveEmployees**     | Employees still active (`TerminationDate IS NULL`)        |
| **TerminatedEmployees** | Employees no longer active                                |
| **RetentionRate**       | Percentage of employees retained (Active ÷ Total)         |

---

## ▶️ Usage Example

```sql
EXEC HR.GetRetentionSummary;
