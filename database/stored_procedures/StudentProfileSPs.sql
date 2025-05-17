CREATE PROCEDURE GetStudentAverageGradeBySubject
    @StudentId INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM student WHERE sid = @StudentId)
        BEGIN
            SELECT 
                c.subject,
                ISNULL(AVG(f.grade), 0) AS AverageGrade
            FROM 
                finish f
            INNER JOIN 
                object o ON f.oid = o.oid
            INNER JOIN 
                section s ON o.secid = s.secid
            INNER JOIN 
                course c ON s.cid = c.cid
            WHERE 
                f.sid = @StudentId
            GROUP BY 
                c.subject;

            RETURN 0;
        END
        ELSE
            RETURN -1;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END
go
CREATE PROCEDURE GetStudentRecentActivity
    @StudentId INT,
    @TopN INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM student WHERE sid = @StudentId)
        BEGIN
            SELECT TOP (@TopN)
                o.oid,
                o.title,
                o.type,
                f.grade,
                f.oid,
                o.creation_date
            FROM 
                finish f
            INNER JOIN 
                object o ON f.oid = o.oid
            WHERE 
                f.sid = @StudentId
            ORDER BY 
                o.creation_date DESC;

            RETURN 0;
        END
        ELSE
            RETURN -1;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END
go
CREATE PROCEDURE UpdateStudentProfile
    @StudentId INT,
    @Picture VARCHAR(100) = NULL,
    @Email VARCHAR(100) = NULL,
    @Phone VARCHAR(11) = NULL
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM student WHERE sid = @StudentId)
        BEGIN
            UPDATE app_user
            SET 
                picture = ISNULL(@Picture, picture),
                email = ISNULL(@Email, email),
                phone = ISNULL(@Phone, phone)
            WHERE uid = @StudentId;

            RETURN 0;
        END
        ELSE
            RETURN -1;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END
go
CREATE PROCEDURE GetStudentProfile
    @StudentId INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM student WHERE sid = @StudentId)
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
                s.acad_year
            FROM 
                app_user au
            INNER JOIN 
                student s ON au.uid = s.sid
            WHERE 
                s.sid = @StudentId;

            RETURN 0;
        END
        ELSE
            RETURN -1;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END
