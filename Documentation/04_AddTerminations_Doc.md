# Script 04 — Add Terminations After Last Job Change

## 📌 Purpose
This script assigns termination dates to approximately **15% of employees**, ensuring terminations only occur **after an employee’s final job change**.  
The goal is to introduce realistic turnover behavior into the dataset while maintaining strict chronological accuracy for TechCorp_HR_Analytics analytics.

---

## 🧩 Business Rules

### **1️⃣ Termination Eligibility**
Employees are selected deterministically using:  

EmployeeID % 7 = 0

This produces **~15% terminations** consistently on every run.

---

### **2️⃣ Final Active Date (Last Job Change)**
The script determines the employee’s final active date:

- If the employee has entries in **HR.EmployeeJobHistory**, use the **latest ChangeDate**.  
- If no history exists, default to the **HireDate**.

This ensures every employee has a valid timeline anchor before termination.

---

### **3️⃣ Termination Date Assignment**
Each eligible employee receives:

- **TerminationDate = LastChangeDate + 7 days**

This ensures separation occurs *after* the final position change.

---

### **4️⃣ Validation Rule**
Termination dates **cannot exceed the current date**.

- If the calculated date is in the future → it is adjusted to **yesterday**.

---

### **5️⃣ Deterministic Output**
The procedure always produces the **same terminations for the same dataset**, ensuring reproducibility across environments.

---

## ⚙️ Technical Logic Summary

The script operates in **three stages**:

### **Stage 1 — Build LastChange CTE**
Determines each employee’s last known active date:

- `MAX(ChangeDate)` from EmployeeJobHistory  
- Falls back to HireDate if no history exists  

---

### **Stage 2 — Identify Terminated Employees**
- Filters employees meeting the deterministic rule (`EmployeeID % 7 = 0`)  
- Calculates TerminationDate = LastChangeDate + 7 days  

---

### **Stage 3 — Update HR.Employees**
- Writes TerminationDate into the Employees table  
- Ensures no termination date is later than today  

---

## 📤 Output

This script:

- Updates **~15% of employees**  
- Populates `HR.Employees.TerminationDate` with chronologically correct values  
- Supports downstream analytics for:
  - Turnover  
  - Retention  
  - Headcount movement  
  - HR reporting accuracy  
