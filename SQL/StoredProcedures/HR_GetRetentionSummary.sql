CREATE OR ALTER PROCEDURE HR.GetRetentionSummary
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE
        @TotalEmployees INT,
        @StillActive INT,
        @Terminated INT;

    SELECT @TotalEmployees = COUNT(*)
    FROM HR.Employees;

    SELECT @StillActive = COUNT(*)
    FROM HR.Employees
    WHERE TerminationDate IS NULL;

    SELECT @Terminated = COUNT(*)
    FROM HR.Employees
    WHERE TerminationDate IS NOT NULL;

    SELECT
        @TotalEmployees AS TotalEmployees,
        @StillActive AS ActiveEmployees,
        @Terminated AS TerminatedEmployees,
        CAST(@StillActive * 1.0 / @TotalEmployees AS DECIMAL(5,2)) AS RetentionRate
    ;
END;
GO
