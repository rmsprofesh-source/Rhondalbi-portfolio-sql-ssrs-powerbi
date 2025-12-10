# Script 01 — Database & Schema Creation

## 📌 Purpose
Script 01 creates the **TechCorp_HR_Analytics database** and defines the **entire relational schema**.  
It builds all core HR tables, including:

- Employees  
- Departments  
- Job Titles  
- Salary History  
- Job History  
- Skills & EmployeeSkills  
- Training & EmployeeTraining  
- Performance Appraisals  

It also establishes all **primary keys**, **foreign keys**, and **table relationships** required for analytics, reporting, and downstream data generation.

---

## ⚙️ How It Works

### **1️⃣ Creates the Database & HR Schema**
- Initializes the SQL Server database  
- Creates the `HR` schema to store all objects cleanly  

---

### **2️⃣ Builds All Core Tables**
Defines each table with:

- Proper data types  
- Primary keys  
- Default constraints  
- Audit fields where applicable  

---

### **3️⃣ Defines Relationships (Foreign Keys)**
- Enforces referential integrity  
- Links employees to job titles, departments, training, skills, and salary history  
- Ensures clean, analytics-ready joins for SSRS and Power BI  

---

## 🚀 Role in the Workflow
This script **must run first**.

All other scripts depend on the objects defined here:

1. **Script 02** loads lookup values  
2. **Script 03** generates employees & HR history  
3. **Script 04** applies termination logic  

Without Script 01, no structure exists for the HR Analytics dataset.

---
