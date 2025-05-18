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
    @sid INT,
    @FName VARCHAR(20) = NULL,
    @LName VARCHAR(20) = NULL,
    @Email VARCHAR(100) = NULL,
    @Phone VARCHAR(11) = NULL,
    @DOB DATE = NULL,
    @Picture VARBINARY(MAX) = NULL,
    @Password VARCHAR(50) = NULL
AS
BEGIN
    -- Ensure the SID exists and is a student
    IF NOT EXISTS (
        SELECT 1
        FROM student s
        JOIN app_user u ON s.sid = u.uid
        WHERE s.sid = @sid
    )
    BEGIN
        RETURN -2; -- Student not found
    END

    -- Check file size for Picture (if provided)
    IF @Picture IS NOT NULL AND DATALENGTH(@Picture) > 5242880
    BEGIN
        RETURN -1; -- Picture too large
    END

    -- Update each field only if it's provided
    UPDATE app_user
    SET
        email = ISNULL(@Email, email),
        phone = ISNULL(@Phone, phone),
        fname = ISNULL(@FName, fname),
        lname = ISNULL(@LName, lname),
        dob = ISNULL(@DOB, dob),
        picture = CASE 
                     WHEN @Picture IS NOT NULL THEN @Picture 
                     ELSE picture 
                 END,
        password = ISNULL(@Password, password)
    WHERE uid = @sid;

    RETURN 0; -- Success
END;
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
                s.acad_year,
                au.password
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
