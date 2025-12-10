# Script 03 — Employee & HR Data Generation

## 📌 Purpose
Script 03 generates all **employees** and all **related HR activity**, creating a realistic but fully deterministic dataset.  
This includes job assignments, salary history, promotions, department transfers, skill assignments, training events, and performance appraisals.

This script is the heart of the TechCorp_HR_Analytics dataset.

---

## ⚙️ How It Works

Script 03 uses lookup tables and rule-based logic to construct complete HR activity timelines:

### **1️⃣ Employee Creation**
- Generates employees with deterministic hire dates  
- Assigns each employee an initial department and job title  

---

### **2️⃣ Salary Assignments**
- Sets starting salaries based on job title  
- Generates future salary changes using scheduled intervals  
- Ensures salary progression remains realistic and consistent  

---

### **3️⃣ Job History (Promotions & Moves)**
- Creates job history entries for:
  - Promotions  
  - Lateral transfers  
  - Department changes  
- Ensures chronological accuracy across all changes  

---

### **4️⃣ Skill Assignments**
- Attaches skill tags to each employee  
- Ensures a mix of skills suitable for analytics and filtering  

---

### **5️⃣ Training Events**
- Generates historical training participation  
- Assigns training types and completion dates  
- Supports training effectiveness analytics  

---

### **6️⃣ Performance Appraisals**
- Generates performance review scores over time  
- Produces realistic distributions suitable for dashboards  
- Supports KPI and HR trend analysis  

---

## 🚀 Role in the Workflow
Script 03 runs **after**:

1. **Script 01 — Schema Creation**  
2. **Script 02 — Lookup Data Loading**

Once Script 03 completes, the database becomes:

- Fully populated  
- Chronologically accurate  
- Ready for stored procedures, SSRS reports, and Power BI modeling  

This script transforms the database into a rich, analytics-ready HR environment.

---
