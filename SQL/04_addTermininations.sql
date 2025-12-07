-----------------------------------------------------------------------------------
-- Script 04: Generate Termination Dates After Last Job Change
-- Author: Mo (HR Analytics Portfolio Project)
--
-- Purpose:
--   Assign termination dates to ~15% of employees ONLY AFTER their last job change.
--   Last job change is defined as:
--       - The most recent ChangeDate in HR.EmployeeHireHistory, OR
--       - HireDate if no job history exists.
--
--   TerminationDate = LastJobChangeDate + 7 days.
--   Approximately 15% of employees (EmployeeID % 7 = 0) are selected.
--   All logic is deterministic — same results every run.
-----------------------------------------------------------------------------------

PRINT 'Starting termination generation (after last job change)...';


-----------------------------------------------------------------------------------
-- 1. Build LastChange CTE
--    For each employee:
--        - Latest ChangeDate from EmployeeHireHistory
--        - If none exists, fallback to HireDate
-----------------------------------------------------------------------------------

;WITH LastChange AS
(
    SELECT
        e.EmployeeID,
        e.HireDate,
        LastChangeDate =
            ISNULL(
                (
                    SELECT MAX(h.ChangeDate)
                    FROM HR.EmployeeHireHistory h
                    WHERE h.EmployeeID = e.EmployeeID
                ),
                e.HireDate
            )
    FROM HR.Employees e
),


-----------------------------------------------------------------------------------
-- 2. Select ~15% of employees deterministically:
--       EmployeeID % 7 = 0
-----------------------------------------------------------------------------------
TerminatedEmployees AS
(
    SELECT
        lc.EmployeeID,
        lc.LastChangeDate,
        TerminationDate = DATEADD(DAY, 7, lc.LastChangeDate)
    FROM LastChange lc
    WHERE lc.EmployeeID % 7 = 0
)

-----------------------------------------------------------------------------------
-- 3. Apply Termination Dates
--    Ensure termination never exceeds today's date
-----------------------------------------------------------------------------------
UPDATE e
SET e.TerminationDate =
    CASE
        WHEN t.TerminationDate > CAST(GETDATE() AS DATE)
            THEN DATEADD(DAY, -1, CAST(GETDATE() AS DATE))
        ELSE t.TerminationDate
    END
FROM HR.Employees e
INNER JOIN TerminatedEmployees t
    ON e.EmployeeID = t.EmployeeID;


PRINT 'Termination generation complete.';
-----------------------------------------------------------------------------------
