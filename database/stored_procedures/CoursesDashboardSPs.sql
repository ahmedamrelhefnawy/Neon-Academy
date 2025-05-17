--The most enrolled courses 
CREATE PROCEDURE get_top_10_best_sellers
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT TOP 10
            c.cid,
            c.cname,
            c.price,
            c.rating,
            COUNT(e.sid) AS enrollments
        FROM course c
        LEFT JOIN enroll e ON c.cid = e.cid
        GROUP BY c.cid, c.cname, c.price, c.rating
        ORDER BY enrollments DESC, c.rating DESC;

        RETURN 0; -- success
    END TRY
    BEGIN CATCH
        RETURN -1; -- failure
    END CATCH
END

go 

--search in course's and teacher's name filltered by (subject,ratting,acad-year,price)

CREATE PROCEDURE search_courses
    @key VARCHAR(50) = NULL,
    @subject VARCHAR(15) = NULL,
    @max_rate DECIMAL(3,1) = NULL,
    @min_rate DECIMAL(3,1) = NULL,
    @academic_year INT = NULL,
    @max_price DECIMAL(9,3) = NULL,
    @min_price DECIMAL(9,3) = NULL
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        SELECT 
            c.cid,
            c.cname,
            c.subject,
            c.rating,
            c.price,
            c.cyear AS academic_year,
            au.fname + ' ' + au.lname AS teacher_name
        FROM course c
        LEFT JOIN teacher t ON c.tid = t.tid
        LEFT JOIN app_user au ON t.tid = au.uid
        WHERE
            (
                (@key IS NULL) 
                OR (c.cname LIKE '%' + @key + '%') 
                OR (au.fname LIKE '%' + @key + '%') 
                OR (au.lname LIKE '%' + @key + '%')
            )
            AND
            (
                (@subject IS NULL) 
                OR (c.subject = @subject)
            )
            AND
            (
                (@max_rate IS NULL) 
                OR (c.rating <= @max_rate)
            )
            AND
            (
                (@min_rate IS NULL) 
                OR (c.rating >= @min_rate)
            )
            AND
            (
                (@academic_year IS NULL) 
                OR (c.cyear = @academic_year)
            )
            AND
            (
                (@max_price IS NULL) 
                OR (c.price <= @max_price)
            )
            AND
            (
                (@min_price IS NULL) 
                OR (c.price >= @min_price)
            )
        ORDER BY c.rating DESC, c.creation_date DESC;

        RETURN 0; -- success
    END TRY
    BEGIN CATCH
        RETURN -1; -- failure
    END CATCH
END
