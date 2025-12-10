# Stored Procedures  
This folder contains all **production-style stored procedures** used by the TechCorp HR Analytics SQL Server database.  
Each procedure powers one or more SSRS reports or future Power BI dashboards.

These procedures showcase real BI engineering skills including data shaping, business logic, KPI calculation, and repeatable dataset creation.

---

## 📁 Stored Procedures Included

### **1️⃣ HR.GetHeadcountTrend**
**Purpose:**  
Generates monthly employee headcount over time.

**Key Features:**  
- Counts active employees per month  
- Supports workforce planning & attrition tracking  
- Ideal for line charts in SSRS/Power BI  

---

### **2️⃣ HR.GetRetentionMetrics**
**Purpose:**  
Provides turnover and retention KPIs.

**Key Features:**  
- Total terminations  
- Retention rates  
- Differentiates voluntary vs. involuntary (if added in future)  
- Useful for HR KPI dashboards  

---

### **3️⃣ HR.GetRetentionSummary**
**Purpose:**  
Returns snapshot-level retention metrics by date.

**Key Features:**  
- Summary KPIs for executive reporting  
- Clean structure used for SSRS summary tables  

---

### **4️⃣ HR.GetTenureMetricsSummary**
**Purpose:**  
Returns **employee-level tenure details**, including:
- Hire date  
- Effective end date  
- Tenure in years (2-decimal precision)  
- Employment status (Active/Terminated)

**Key Features:**  
- Powers the SSRS Employee Tenure Detail Report  
- Business-ready logic for calculating tenure consistently  
- Handles active vs. terminated employees differently and correctly  

---

## 🧠 How These Procedures Work
Each procedure includes:
- Deterministic logic so results always match synthetic dataset  
- Business rules that mirror real HR analytics environments  
- Clean SELECT statements optimized for SSRS datasets  
- Joins written for readability and maintainability  

---

## 📄 Documentation
Detailed explanations for each procedure — including diagrams, field descriptions, and example result sets — are located in:  

➡ `/Documentation/StoredProcedures/`

These documents explain:
- Purpose  
- Business logic  
- How KPIs are calculated  
- Example outputs  

---

## 🚀 Developer Note
All stored procedures are deployed under the `HR` schema to maintain a clean, enterprise-style structure.

HR.GetHeadcountTrend
HR.GetRetentionMetrics
HR.GetRetentionSummary
HR.GetTenureMetricsSummary


These procedures deliver consistent, analytics-ready datasets for SSRS and future Power BI dashboards.

---

