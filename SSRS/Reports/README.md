# SSRS HR Analytics Reports

This folder contains SQL Server Reporting Services (SSRS) report files and supporting assets for the **TechCorp HR Analytics Platform**.  
These reports are powered by the HR Analytics SQL Server database and stored procedures developed for employee headcount, tenure, and retention analysis.

---

## 📊 Employee Tenure Detail Report

**Report File:** `RPT_HR_TenureSummary.rdl`  
**Preview:**  
![Employee Tenure Report](EmployeeTenureReport.png)

### ✔️ Purpose
The Employee Tenure Detail Report provides HR and leadership with a clear view of:
- Individual employee tenure (in years)
- Hire and termination timelines
- Employment status (Active vs. Terminated)
- Sorting and filtering by tenure and employee status

This report supports workforce planning, headcount tracking, and historical trend analysis.

---

## 🛠 Data Source
This report is powered by the stored procedure:

HR.GetTenureMetricsSummary


### The procedure calculates:
- Tenure in years (2-decimal precision)
- Employment status
- Effective end dates for both active and terminated staff

All underlying logic is implemented in T-SQL and included in the `/SQL/StoredProcedures/` directory of this repository.

---

## 🧱 Report Features
- Parameterized filtering (Active, Terminated, All Employees)
- Sorting by tenure, hire date, or name
- Clean enterprise-style layout
- Export support for PDF, Excel, and CSV
- Built and deployed using **SSRS 2022**

---

## 📂 File Structure

SSRS/
└── Reports/
├── RPT_HR_TenureSummary.rdl # Report design file
├── EmployeeTenureReport.png # Preview screenshot
└── README.md # Documentation for this folder


---

## ✨ Created By
**Rhondal S.**  
BI Developer • SQL Server • SSRS • Power BI  
