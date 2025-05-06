CREATE PROCEDURE get_top_10_rated_courses
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT TOP 10
            cid,
            cname,
            rating,
            price,
            subject,
            semester,
            creation_date
        FROM course
        WHERE rating IS NOT NULL
        ORDER BY rating DESC, creation_date DESC;

        RETURN 0; -- success
    END TRY
    BEGIN CATCH
        RETURN -1; -- failure
    END CATCH
END
