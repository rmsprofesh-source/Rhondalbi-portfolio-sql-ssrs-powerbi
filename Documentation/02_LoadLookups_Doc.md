# Script 02 — Lookup Data Loading

## 📌 Purpose
Script 02 loads all **lookup tables** required by the HR Analytics dataset.  
These include standardized reference values such as:

- Departments  
- Job titles  
- Skill sets  
- Performance rating scales  
- Training types  
- Other controlled reference categories  

These values remain stable across every run and act as the foundation for employee generation and analytics.

---

## ⚙️ How It Works

Script 02 performs structured, deterministic loading of base reference values:

### **1️⃣ Standardized Lookup Inserts**
- Populates every lookup table with pre-defined values  
- Ensures consistency across departments, job titles, and skill categories  

---

### **2️⃣ Controlled Categories for HR Logic**
- Provides stable values used by Script 03 to assign:
  - Skills  
  - Training events  
  - Salary ranges  
  - Job titles and departments  

---

### **3️⃣ Establishes Dataset “Source of Truth”**
- These values are reused by all downstream scripts  
- Guarantees repeatable, reproducible results each time the database is rebuilt  

---

## 🚀 Role in the Workflow
Script 02 runs **after**:

1. **Script 01 — Schema Creation**

And **before**:

2. **Script 03 — Employee & HR Data Generation**

All downstream processes depend on these lookup tables to maintain consistent business logic and produce a realistic HR dataset.

---
