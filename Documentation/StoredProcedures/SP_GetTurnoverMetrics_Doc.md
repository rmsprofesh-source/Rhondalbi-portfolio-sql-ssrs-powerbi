# Stored Procedure: HR.GetTurnoverMetrics

## Purpose
This stored procedure calculates **monthly turnover metrics** for the organization, including:

- Headcount at the beginning of each month  
- Number of terminations during the month  
- Turnover rate (terminations ÷ starting headcount)

It is used to support HR dashboards, workforce trend analysis, and separation reporting.

---

## Business Rules

### Headcount Rules
An employee is counted in **HeadcountStart** if:

- They were hired on or before the first day of the month  
- They were not terminated before that date  

### Termination Rules
A termination is counted for a given month if:

- `TerminationDate >= MonthStart`  
- `TerminationDate < MonthStart + 1 month`

### Turnover Rate Formula

TurnoverRate = Terminations / HeadcountStart


If `HeadcountStart = 0`, turnover is returned as **0** to avoid division errors.

### Month Boundaries
The procedure automatically builds a complete, gap-free list of months from:

- The earliest employee HireDate  
- Through the current month  

---

## Technical Logic Summary

### 1. Generate Month List (Months CTE)
- Uses `DATEFROMPARTS()` to create the first day of each month.
- Builds a continuous sequence from earliest hire to today.
- Ensures proper chronological ordering.

---

### 2. Monthly Data (MonthlyData CTE)
Calculates monthly metrics:

- **HeadcountStart** — number of active employees at the start of the month  
- **Terminations** — number of terminations occurring during the month  

These values form the basis of the turnover calculation.

---

### 3. Final Output
The final query returns one row per month, containing:

- `MonthStart` — first calendar day of the month  
- `MonthEnd` — last calendar day (computed)  
- `HeadcountStart`  
- `Terminations`  
- `TurnoverRate`  

Results are ordered chronologically from oldest to newest month.

---

## Output Columns

| Column          | Description                                      |
|-----------------|--------------------------------------------------|
| **MonthStart**      | First day of the reporting month               |
| **MonthEnd**        | Last day of the reporting month                |
| **HeadcountStart**  | Employee count at beginning of the month       |
| **Terminations**    | Number of terminations during the month        |
| **TurnoverRate**    | Terminations ÷ HeadcountStart                  |

---

## Usage Example
```sql
EXEC HR.GetTurnoverMetrics;

Dependencies

This procedure relies on:

    HR.Employees

    HR.EmployeeHireHistory (indirectly for chronological correctness)
