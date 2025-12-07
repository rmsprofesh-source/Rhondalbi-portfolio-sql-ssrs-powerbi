04 — Add Terminations After Last Job Change
Purpose

This script assigns termination dates to approximately 15% of employees, ensuring terminations only occur after an employee’s final job change.
The goal is to support HR analytics by introducing realistic turnover behavior into the dataset while maintaining chronological accuracy.

Business Rules

Termination Eligibility
Employees are selected deterministically for termination using:

EmployeeID % 7 = 0


This produces ~15% terminations consistently on every run.

Last Job Change
The script determines the final “active date” for every employee:

If the employee has entries in HR.EmployeeHireHistory, use the latest ChangeDate.

If no history exists, default to the employee’s HireDate.

Termination Date Assignment
Each eligible employee receives:

TerminationDate = LastChangeDate + 7 days


Validation Rule
Termination dates cannot exceed the current date.
If a calculated date is in the future, it is adjusted to yesterday.

Deterministic Output
The logic ensures the same input dataset always produces the same terminations.

Technical Logic Summary

The script works in three stages:

1. Build LastChange CTE

Pulls each employee’s last known active date.

Uses MAX(ChangeDate) from EmployeeHireHistory.

Falls back to HireDate when needed.

2. Identify Terminated Employees

Filters to IDs where EmployeeID % 7 = 0.

Calculates a termination date 7 days after the final job change.

3. Update the Employees Table

Writes the TerminationDate into HR.Employees.

Ensures no termination date is greater than today.

Output

Updates roughly 15% of employees.

Populates HR.Employees.TerminationDate with chronologically valid values.

Supports downstream analytics for:

Turnover

Retention

Headcount movement

HR reporting accuracy
