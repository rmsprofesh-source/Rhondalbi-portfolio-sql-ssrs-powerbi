# Project Documentation

This folder contains all written documentation for the HR Analytics portfolio project.  
It includes system overviews, script explanations, data-model notes, and stored-procedure reference materials.

The documentation is organized into the following sections:

---

## 📁 StoredProcedures

Contains detailed documentation for each analytics stored procedure, including:

- **HR.GetHeadcountTrend** — Monthly headcount analysis  
- **HR.GetTurnoverMetrics** — Turnover and separation metrics  
- **HR.GetRetentionSummary** — Retention snapshot (active vs. terminated)  
- **HR.GetTenureMetricsSummary** — Employee-level tenure details + summary KPIs  

Each file explains purpose, business logic, field descriptions, and usage examples.

---

## 📁 System Overview

Provides a high-level explanation of:

- The overall HR Analytics dataset  
- Deterministic data-generation design  
- Schema layout (employees, job history, salaries, training, etc.)  
- The full workflow of Scripts 01–04  
- How the system supports BI tools like SSRS and Power BI  

This document is the starting point for anyone reviewing the project.

---

## 📁 Script Documentation

Documentation for the major SQL scripts that build and populate the database:

- **01_CreateSchema_Doc.md**  
- **02_LoadLookups_Doc.md**  
- **03_GenerateEmployeesAndHistory_Doc.md**  
- **04_AddTerminations_Doc.md**  

Each file describes the purpose of the script, how data is generated, and the rules used to create a deterministic HR dataset.

---

## Purpose of This Folder

This directory acts as the **reference library** for the entire BI portfolio project.  
Anyone reading the project — including recruiters or hiring managers — can use these documents to understand:

- How the database was built  
- How data is generated  
- How HR-level metrics are calculated  
- How the stored procedures support BI reporting  

The documentation is designed to be clear, repeatable, and professional, reflecting real enterprise analytics practices.

