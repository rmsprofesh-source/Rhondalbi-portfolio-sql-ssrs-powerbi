# SQL Scripts  
This folder contains **all SQL scripts required to build the TechCorp HR Analytics database from scratch**.  
The structure and scripts here demonstrate full-cycle database engineering — from schema creation to synthetic data generation to stored-procedure development.

---

## 📁 What’s Included in This Folder

### **1️⃣ Schema Creation Scripts**
Scripts that build the entire database structure, including:
- Core HR tables (Employees, Departments, JobHistory, Salaries, Training, Performance, etc.)
- Primary and foreign key constraints  
- Lookup tables  
- Indexes for performance  

**Files:**
- `01_CreateSchema.sql`

---

### **2️⃣ Lookup Seed Data**
Scripts that load deterministic reference data such as:
- Departments  
- Job Titles  
- Training Status  
- Skills  

**Files:**
- `02_LoadLookups.sql`

---

### **3️⃣ Synthetic Employee + History Generation**
Scripts that automatically create **realistic employee records** and all associated historical datasets, including:
- Employee master records  
- Deterministic hire dates  
- Salary progression  
- Job title changes  
- Training & skills assignment  

**Files:**
- `03_GenerateEmployeesAndHistory.sql`

---

### **4️⃣ Termination Logic**
Script that generates:
- Proper termination dates  
- Updated employee status (Active / Terminated)  
- EffectiveEndDate logic used in all SSRS reports  

**Files:**
- `04_AddTerminations.sql`

---

## 🧠 Purpose of These Scripts
These SQL scripts demonstrate your ability to:

- Build a complete relational database system  
- Generate deterministic synthetic HR data for analytics  
- Prepare datasets for SSRS and Power BI reporting  
- Automate data loading in repeatable, professional workflows  
- Deliver a fully reproducible database that employers can run locally  

---

## 📌 Stored Procedures
Stored procedures used by reports and analytics are located in:

➡ `/SQL/StoredProcedures/`

These include:
- Headcount trends  
- Retention metrics  
- Tenure calculations  
- Summary-level reporting datasets  

Each procedure is documented in the **Documentation** folder.

---

## 🚀 Developer Note
Anyone cloning this repo can build the entire HR Analytics database by running the scripts in numerical order:

01_CreateSchema.sql
02_LoadLookups.sql
03_GenerateEmployeesAndHistory.sql
04_AddTerminations.sql


This ensures a clean, fully reproducible database environment for testing SQL, SSRS, or Power BI solutions.

---
