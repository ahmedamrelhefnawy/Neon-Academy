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
    @AuthDoc VARBINARY(max) = NULL,
    @Picture VARBINARY(max) = NULL,
    @Phone VARCHAR(11) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM teacher WHERE tid = @TeacherId)
        BEGIN
            -- Check file size for AuthDoc (if provided)
            IF @AuthDoc IS NOT NULL AND DATALENGTH(@AuthDoc) > 5242880
            BEGIN
                RETURN -1; -- AuthDoc too large
            END

            -- Check file size for Picture (if provided)
            IF @Picture IS NOT NULL AND DATALENGTH(@Picture) > 5242880
            BEGIN
                RETURN -1; -- Picture too large
            END

            -- Update teacher.auth_doc if valid
            IF @AuthDoc IS NOT NULL
            BEGIN
                UPDATE teacher
                SET auth_doc = @AuthDoc
                WHERE tid = @TeacherId;
            END

            -- Update app_user fields
            UPDATE app_user
            SET 
                picture = ISNULL(@Picture, picture),
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
