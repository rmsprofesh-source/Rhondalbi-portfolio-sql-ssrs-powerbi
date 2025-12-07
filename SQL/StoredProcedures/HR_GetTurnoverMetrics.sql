CREATE OR ALTER PROCEDURE HR.GetTurnoverMetrics
AS
BEGIN
    SET NOCOUNT ON;

    ;WITH Months AS
    (
        SELECT DATEFROMPARTS(YEAR(MIN(HireDate)), MONTH(MIN(HireDate)), 1) AS MonthStart
        FROM HR.Employees

        UNION ALL

        SELECT DATEADD(MONTH, 1, MonthStart)
        FROM Months
        WHERE MonthStart < DATEFROMPARTS(YEAR(GETDATE()), MONTH(GETDATE()), 1)
    ),
    MonthlyData AS
    (
        SELECT
            M.MonthStart,

            -- Headcount at start of month
            (
                SELECT COUNT(*)
                FROM HR.Employees E
                WHERE E.HireDate <= M.MonthStart
                  AND (E.TerminationDate IS NULL OR E.TerminationDate >= M.MonthStart)
            ) AS HeadcountStart,

            -- Terminations in the month
            (
                SELECT COUNT(*)
                FROM HR.Employees E
                WHERE E.TerminationDate >= M.MonthStart
                  AND E.TerminationDate < DATEADD(MONTH, 1, M.MonthStart)
            ) AS Terminations
        FROM Months M
    )
    SELECT
        MonthStart,
        EOMONTH(MonthStart) AS MonthEnd,
        HeadcountStart,
        Terminations,
        CASE
            WHEN HeadcountStart = 0 THEN 0
            ELSE CAST(Terminations AS FLOAT) / HeadcountStart
        END AS TurnoverRate
    FROM MonthlyData
    ORDER BY MonthStart OPTION (MAXRECURSION 0);

END;
GO
