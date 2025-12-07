Stored Procedure: HR.GetHeadcountTrend  
Purpose

This stored procedure calculates the monthly headcount for the organization by determining how many employees were active during each month in the reporting timeline.

Headcount reflects all employees whose employment period overlaps a given month.  
It is used to support HR dashboards, staffing trend analysis, and workforce planning.

Business Rules

• The procedure generates a continuous list of months beginning at the earliest HireDate and ending at the current month.  
• An employee is counted as active for a month if:
  – HireDate ≤ MonthEnd  
  – AND (TerminationDate IS NULL OR TerminationDate ≥ MonthStart)  
• Headcount is calculated at the start of each month.  
• Results are deterministic and based entirely on existing HR.Employees data.

Month Boundaries

MonthStart = first day of the month  
MonthEnd = last day of the month (computed automatically)

Technical Logic Summary

1. Generate Month List (Months CTE)  
   Creates a chronological sequence of months from earliest employee HireDate through the current month.

2. Determine Active Employees (MonthlyData CTE)  
   Counts all employees whose hire/termination dates qualify them as active during each month.

3. Final Output  
   Returns the headcount for each month in order, producing a trend dataset suitable for reporting tools.

Output Columns  
Column            Description  
MonthStart        First day of the reporting month  
MonthEnd          Last day of the reporting month  
Headcount         Total number of active employees during the month  

Usage Example  
```sql
EXEC HR.GetHeadcountTrend;

