# HR Analytics Dataset — System Overview

This project provides a complete, **deterministic HR Analytics environment** that can be recreated using the included SQL scripts. Running the scripts in order sets up:

- The full database structure  
- All lookup and reference values  
- A complete set of HR activity data (employees, job changes, salaries, training, skills, performance reviews, and terminations)

Because the dataset is **fully deterministic**, rebuilding the environment always produces the same results — ideal for BI development, analytics, demos, and portfolio work.

---

## 🎯 Purpose of the Dataset

The dataset models the essential components found in real HR systems:

- Employee master records  
- Departments & job titles  
- Job movement and promotions  
- Salary changes  
- Skill assignments  
- Training activity  
- Performance evaluations  
- Termination and retention patterns  

This supports:

- SQL Server analytics  
- SSRS report development  
- Power BI dashboards  
- KPI & trend analysis  
- BI learning and exploration  
- Demonstrating real BI engineering skills  

---

## 🗂 Schema Overview

The database is structured into logical HR domains.

### **📌 Core Entities**
- Employees  
- Departments  
- JobTitles  

### **📌 Activity & Historical Data**
- JobChangeHistory  
- SalaryHistory  
- TrainingHistory  
- EmployeeSkills  
- PerformanceReviews  

### **📌 Lookup / Reference Tables**
- Departments  
- Job titles  
- Skills  
- Training types  
- Rating scales  

Lookup values are loaded first to ensure consistent references.

---

## ⚙️ Script Workflow

The HR Analytics environment is created by running four SQL scripts in sequence.

---

### **1️⃣ Script 01 — CreateSchema**
Creates the full HR database structure:

- Tables  
- Keys & relationships  
- Constraints  
- Indexes  

---

### **2️⃣ Script 02 — LoadLookups**
Loads all standardized lookup values:

- Department list  
- Job titles  
- Skills  
- Rating scales  
- Training definitions  

These serve as the “source-of-truth” used by later scripts.

---

### **3️⃣ Script 03 — GenerateEmployeesAndHistory**
Builds the complete HR activity layer:

- Employee records  
- Hire dates  
- Job progression  
- Salary history  
- Skill assignments  
- Training activity  
- Performance review records  

All values are generated deterministically.

---

### **4️⃣ Script 04 — AddTerminations**
Assigns termination dates based on business rules:

- Terminations occur **after each employee’s most recent job change**  
- `TerminationDate = LastChangeDate + 7 days`  
- ~15% of employees receive terminations  
- Selection pattern uses deterministic logic (`EmployeeID % 7 = 0`)  

Enables workforce analytics related to turnover, retention, and headcount movement.

---

## 🔁 Rebuilding the Database

Run the scripts in this order:

1. `01_CreateSchema.sql`  
2. `02_LoadLookups.sql`  
3. `03_GenerateEmployeesAndHistory.sql`  
4. `04_AddTerminations.sql`

Executing them in sequence always produces a clean, repeatable dataset.

---

## 📊 Intended Use

This dataset is ideal for:

- HR reporting and analytics  
- SSRS paginated reports  
- Power BI modeling  
- Exploratory SQL analysis  
- KPI dashboards (turnover, tenure, retention)  
- BI developer portfolio demonstrations  

The structure reflects real-world HR systems without using sensitive or proprietary data.

---

## 📝 Notes

- Data generation is fully deterministic  
- The database can be recreated at any time by rerunning the scripts  
- No external dependencies beyond SQL Server  

