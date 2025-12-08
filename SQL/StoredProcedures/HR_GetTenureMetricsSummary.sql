ALTER PROCEDURE HR.GetTenureMetricsSummary
AS
BEGIN
    -------------------------------------------------------------------
    -- Purpose:
    --      Returns two datasets:
    --          (1) Employee-level tenure details
    --          (2) High-level tenure summary metrics
    --
    -- Notes:
    --      - Uses a CTE to build base tenure data
    --      - Loads CTE into a temp table for reuse (cleaner & reliable)
    --      - Ideal for SSRS / Power BI / HR Analytics reporting
    -------------------------------------------------------------------

    SET NOCOUNT ON;

    -------------------------------------------------------------------
    -- 0. Safety Cleanup: Remove temp table if left from previous run
    -------------------------------------------------------------------
    IF OBJECT_ID('tempdb..#TenureData') IS NOT NULL
        DROP TABLE #TenureData;

    -------------------------------------------------------------------
    -- 1. Build TenureData (CTE)
    --    This CTE calculates:
    --        - FullName (First + Last)
    --        - EffectiveEndDate (TerminationDate OR today)
    --        - TenureYears (in decimal years)
    --        - Active Status Flag (1 = Active, 0 = Terminated)
    --
    --    This dataset becomes the foundation for ALL tenure reporting.
    -------------------------------------------------------------------
    ;WITH TenureData AS
    (
        SELECT
            E.EmployeeID,
            CONCAT(F.FirstName, ' ', L.LastName) AS FullName,
            E.HireDate,

            -- Use today's date for active employees, otherwise TerminationDate
            CASE
                WHEN E.TerminationDate IS NULL THEN GETDATE()
                ELSE E.TerminationDate
            END AS EffectiveEndDate,

            -- Calculate tenure in years (to 2 decimal places)
            CAST(
                DATEDIFF(
                    DAY,
                    E.HireDate,
                    CASE WHEN E.TerminationDate IS NULL THEN GETDATE()
                         ELSE E.TerminationDate END
                ) / 365.0
            AS DECIMAL(10,2)) AS TenureYears,

            -- Active = 1, Terminated = 0
            CASE WHEN E.TerminationDate IS NULL THEN 1 ELSE 0 END AS IsActive

        FROM HR.Employees E
        INNER JOIN HR.FirstNames F ON E.FirstNameID = F.FirstNameID
        INNER JOIN HR.LastNames  L ON E.LastNameID  = L.LastNameID
    )

    -------------------------------------------------------------------
    -- 2. Materialize CTE into a Temp Table
    --    Why?
    --        - Allows multiple SELECTs
    --        - Cleaner than reusing the CTE
    --        - Extremely stable for SSRS / Power BI
    -------------------------------------------------------------------
    SELECT *
    INTO #TenureData
    FROM TenureData;

    -------------------------------------------------------------------
    -- 3. Dataset #1: Employee-Level Tenure Detail
    --    Used for detailed HR reporting, tables, exports, and drilldowns.
    -------------------------------------------------------------------
    SELECT
        EmployeeID,
        FullName,
        HireDate,
        EffectiveEndDate,
        TenureYears,
        CASE WHEN IsActive = 1 THEN 'Active' ELSE 'Terminated' END AS EmployeeStatus
    FROM #TenureData
    ORDER BY TenureYears DESC;

    -------------------------------------------------------------------
    -- 4. Dataset #2: High-Level Summary Metrics
    --    Used for dashboards, KPIs, scorecards, and executive summaries.
    -------------------------------------------------------------------
    SELECT
        COUNT(*) AS TotalEmployees,
        SUM(CASE WHEN IsActive = 1 THEN 1 ELSE 0 END) AS ActiveEmployees,
        SUM(CASE WHEN IsActive = 0 THEN 1 ELSE 0 END) AS TerminatedEmployees,
        AVG(TenureYears) AS AverageTenure,
        MIN(TenureYears) AS MinTenure,
        MAX(TenureYears) AS MaxTenure
    FROM #TenureData;

    -------------------------------------------------------------------
    -- 5. Cleanup (Good Practice)
    -------------------------------------------------------------------
    IF OBJECT_ID('tempdb..#TenureData') IS NOT NULL
        DROP TABLE #TenureData;

END;
GO
