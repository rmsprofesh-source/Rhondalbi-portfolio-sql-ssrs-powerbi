Stored Procedure: HR.GetTurnoverMetrics
Purpose

This stored procedure calculates monthly turnover metrics for the organization, including:

Headcount at the beginning of each month

Number of terminations during the month

Turnover rate (terminations ÷ starting headcount)

It is used to support HR dashboards, reports, and analytics on employee separation trends.

Business Rules

Headcount is measured at the start of each month.
Employees count as active if:

They were hired on or before the first day of the month

They were not terminated before that date

Terminations are counted only if:

TerminationDate ≥ MonthStart

TerminationDate < MonthStart + 1 month

Turnover Rate Formula

TurnoverRate = Terminations / HeadcountStart


If HeadcountStart = 0, turnover is returned as 0 to avoid division errors.

Month Boundaries

The procedure automatically generates a continuous month list from:

Earliest employee HireDate

To current month

Ensures no gaps in the trend.

Technical Logic Summary
1. Generate Month List (Months CTE)

Uses DATEFROMPARTS() to create the first day of every month from the earliest hire to today.

Ensures chronological order and full range for trend analysis.

2. Monthly Data (MonthlyData CTE)

Calculates:

HeadcountStart: Active employees at the month’s start

Terminations: Terminations occurring within the month

3. Final Output

Returns:

MonthStart

MonthEnd (computed for display)

HeadcountStart

Terminations

TurnoverRate

Ordered chronologically.

Output Columns
Column	Description
MonthStart	First day of the reporting month
MonthEnd	Last day of the reporting month
HeadcountStart	Employee count at the beginning of the month
Terminations	Number of terminations in the month
TurnoverRate	Terminations ÷ HeadcountStart
Usage Example
EXEC HR.GetTurnoverMetrics;

Dependencies

HR.Employees

HR.EmployeeHireHistory
(Used indirectly because termination logic respects job change chronology)
