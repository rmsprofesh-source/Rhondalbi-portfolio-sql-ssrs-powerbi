Stored Procedure: HR.GetRetentionSummary  
Purpose

This stored procedure calculates overall employee retention statistics for the organization.  
It summarizes the total workforce, how many employees remain active, how many have been terminated, and the overall retention rate.

This procedure is used to power executive dashboards, HR scorecards, and high-level workforce stability reporting.

Business Rules

• TotalEmployees includes every record in HR.Employees  
• ActiveEmployees are employees with TerminationDate IS NULL  
• TerminatedEmployees are those with any non-NULL TerminationDate  
• RetentionRate = ActiveEmployees ÷ TotalEmployees  
• All values are computed at the moment the procedure is executed

Technical Logic Summary

1. Count Total Employees  
   Retrieves the total number of employee records from HR.Employees.

2. Count Active Employees  
   Employees with no termination date are considered currently active.

3. Count Terminated Employees  
   Any non-NULL TerminationDate qualifies an employee as terminated.

4. Calculate Retention Rate  
   RetentionRate = ActiveEmployees / TotalEmployees  
   Returned as a decimal formatted to two places.

5. Final Output  
   Returns a single row with four values for quick dashboard consumption.

Output Columns  
Column                Description  
TotalEmployees        Total number of employees in the system  
ActiveEmployees       Employees still active (TerminationDate IS NULL)  
TerminatedEmployees   Employees no longer active  
RetentionRate         Percentage of employees retained (Active ÷ Total)

Usage Example  
```sql
EXEC HR.GetRetentionSummary;

