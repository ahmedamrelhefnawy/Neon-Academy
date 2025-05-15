--Teacher personal details
create procedure teacherPersonalDetails
as 
begin
	select tid , username, password, fname, lname, email, picture , dob, gender, phone
	from teacher, app_user
	where tid = uid
end
go 
--We should specify the number of reviews to show by bassing @TopN input
CREATE PROCEDURE GetTeacherRecentReviews
    @TeacherId INT,
    @TopN INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM teacher WHERE tid = @TeacherId)
        BEGIN
            SELECT TOP (@TopN)
                r.rid,
                r.content,
                r.rating,
                r.rdate,
                au.fname + ' ' + au.lname AS StudentName
            FROM 
                review r
            INNER JOIN 
                student s ON r.sid = s.sid
            INNER JOIN 
                app_user au ON s.sid = au.uid
            INNER JOIN 
                course c ON r.cid = c.cid
            WHERE 
                c.tid = @TeacherId
            ORDER BY 
                r.rdate DESC;

            RETURN 0; -- success
        END
        ELSE
        BEGIN
            RETURN -1; -- teacher not found
        END
    END TRY
    BEGIN CATCH
        RETURN -1; -- error
    END CATCH
END
go
CREATE PROCEDURE GetTeacherTotalStudents
    @TeacherId INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM teacher WHERE tid = @TeacherId)
        BEGIN
            SELECT 
                COUNT(DISTINCT e.sid) AS TotalStudents
            FROM 
                enroll e
            INNER JOIN 
                course c ON e.cid = c.cid
            WHERE 
                c.tid = @TeacherId;

            RETURN 0; -- success
        END
        ELSE
        BEGIN
            RETURN -1; -- teacher not found
        END
    END TRY
    BEGIN CATCH
        RETURN -1; -- error
    END CATCH
END
go
CREATE PROCEDURE GetTeacherTopRatedCourse
    @TeacherId INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM teacher WHERE tid = @TeacherId)
        BEGIN
            SELECT TOP 1
                c.cid,
                c.cname,
                c.rating
            FROM 
                course c
            WHERE 
                c.tid = @TeacherId
            ORDER BY 
                c.rating DESC, c.creation_date DESC;

            RETURN 0; -- success
        END
        ELSE
        BEGIN
            RETURN -1; -- teacher not found
        END
    END TRY
    BEGIN CATCH
        RETURN -1; -- error
    END CATCH
END
go
CREATE PROCEDURE GetTeacherRatingSummary
    @TeacherId INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM teacher WHERE tid = @TeacherId)
        BEGIN
            SELECT 
                ISNULL(AVG(c.rating), 0) AS AverageCourseRating
            FROM 
                course c
            WHERE 
                c.tid = @TeacherId;

            RETURN 0; -- success
        END
        ELSE
        BEGIN
            RETURN -1; -- teacher not found
        END
    END TRY
    BEGIN CATCH
        RETURN -1; -- error
    END CATCH
END
go
CREATE PROCEDURE UpdateTeacherProfile
    @TeacherId INT,
    @AuthDoc VARCHAR(100) = NULL,
    @Picture VARCHAR(100) = NULL,
    @Email VARCHAR(100) = NULL,
    @Phone VARCHAR(11) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM teacher WHERE tid = @TeacherId)
        BEGIN
            -- Update teacher.auth_doc if provided
            IF @AuthDoc IS NOT NULL
            BEGIN
                UPDATE teacher
                SET auth_doc = @AuthDoc
                WHERE tid = @TeacherId;
            END

            -- Update app_user fields if provided
            UPDATE app_user
            SET 
                picture = ISNULL(@Picture, picture),
                email = ISNULL(@Email, email),
                phone = ISNULL(@Phone, phone)
            WHERE uid = @TeacherId;

            RETURN 0; -- success
        END
        ELSE
        BEGIN
            RETURN -1; -- teacher not found
        END
    END TRY
    BEGIN CATCH
        RETURN -1; -- error
    END CATCH
END
go
CREATE PROCEDURE GetTeacherProfile
    @TeacherId INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM teacher WHERE tid = @TeacherId)
        BEGIN
            SELECT 
                au.uid,
                au.username,
                au.fname,
                au.lname,
                au.email,
                au.dob,
                au.gender,
                au.picture,
                au.phone,
                t.auth_doc,
                t.rating
            FROM 
                app_user au
            INNER JOIN 
                teacher t ON au.uid = t.tid
            WHERE 
                t.tid = @TeacherId;

            RETURN 0; -- success
        END
        ELSE
        BEGIN
            RETURN -1; -- teacher not found
        END
    END TRY
    BEGIN CATCH
        RETURN -1; -- any error
    END CATCH
END
