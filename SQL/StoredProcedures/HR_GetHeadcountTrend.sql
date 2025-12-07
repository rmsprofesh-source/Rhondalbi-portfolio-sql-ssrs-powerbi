CREATE OR ALTER PROCEDURE HR.GetHeadcountTrend
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
    Headcount AS
    (
        SELECT
            M.MonthStart,
            COUNT(*) AS Headcount
        FROM Months M
        CROSS JOIN HR.Employees E
        WHERE E.HireDate <= EOMONTH(M.MonthStart)
          AND (E.TerminationDate IS NULL OR E.TerminationDate >= M.MonthStart)
        GROUP BY M.MonthStart
    )
    SELECT
        MonthStart,
        EOMONTH(MonthStart) AS MonthEnd,
        Headcount
    FROM Headcount
    ORDER BY MonthStart OPTION (MAXRECURSION 0);
END;
GO
