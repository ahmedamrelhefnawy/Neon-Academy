CREATE PROCEDURE SubmitReview
    @cid INT,
    @sid INT,
    @rating DECIMAL(3,1),
    @content VARCHAR(150)
AS
BEGIN
    BEGIN TRY
        INSERT INTO review (cid, sid, rating, content)
        VALUES (@cid, @sid, @rating, @content);

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END
go
CREATE PROCEDURE RemoveEnrollment
    @sid INT,
    @cid INT
AS
BEGIN
    BEGIN TRY
        DELETE FROM enroll
        WHERE sid = @sid AND cid = @cid;

        RETURN 0; -- success
    END TRY
    BEGIN CATCH
        RETURN -1; -- failure
    END CATCH
END
GO
CREATE PROCEDURE EnrollInCourse
    @sid INT,
    @cid INT
AS
BEGIN
    BEGIN TRY
        INSERT INTO enroll (sid, cid, rating)
        VALUES (@sid, @cid, NULL);

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END
go
CREATE PROCEDURE MarkObjectAsFinished
    @sid INT,
    @oid INT,
    @grade DECIMAL(3,1)
AS
BEGIN
    BEGIN TRY
        INSERT INTO finish (sid, oid, grade)
        VALUES (@sid, @oid, @grade);

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END
go
CREATE PROCEDURE FinishedObjects
    @sid INT,
    @cid INT
AS
BEGIN
    SET NOCOUNT ON;

    -- Check if student exists and is enrolled in the course
    IF NOT EXISTS (
        SELECT 1 
        FROM student s
        JOIN enroll e ON s.sid = e.sid
        WHERE s.sid = @sid AND e.cid = @cid
    )
    BEGIN
        RETURN -1;
    END

    -- Get all finished objects in the specified course
    SELECT o.oid, o.title, o.type, o.description, f.grade
    FROM finish f
    JOIN object o ON f.oid = o.oid
    JOIN section s ON o.secid = s.secid
    JOIN course c ON s.cid = c.cid
    WHERE f.sid = @sid AND c.cid = @cid;

    RETURN 0;
END;
go
CREATE PROCEDURE IsObjectFinished
    @sid INT,
    @oid INT,
    @isFinished INT OUTPUT  -- 0 = finished, -1 = not finished
AS
BEGIN
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM finish WHERE sid = @sid AND oid = @oid)
            SET @isFinished = 0;   -- Finished
        ELSE
            SET @isFinished = -1;  -- Not finished

        RETURN 0; -- success
    END TRY
    BEGIN CATCH
        RETURN -1; -- failure
    END CATCH
END
go
CREATE PROCEDURE GetStudentFinishedObjects
    @sid INT
AS
BEGIN
    BEGIN TRY
        SELECT f.oid, o.title, o.type, f.grade
        FROM finish f
        INNER JOIN object o ON f.oid = o.oid
        WHERE f.sid = @sid;

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END
go
CREATE PROCEDURE GetObjectsBySection
    @secid INT
AS
BEGIN
    BEGIN TRY
        SELECT
            oid,
            secid,
            type,
            title,
            description,
            creation_date,
            weight,
            o_order
        FROM object
        WHERE secid = @secid
        ORDER BY o_order ASC;

        RETURN 0; -- success
    END TRY
    BEGIN CATCH
        RETURN -1; -- failure
    END CATCH
END
GO
CREATE PROCEDURE GetSectionsByCourse
    @cid INT
AS
BEGIN
    BEGIN TRY
        SELECT
            secid,
            cid,
            sec_order
        FROM section
        WHERE cid = @cid
        ORDER BY sec_order ASC;

        RETURN 0; -- success
    END TRY
    BEGIN CATCH
        RETURN -1; -- failure
    END CATCH
END
GO
CREATE PROCEDURE GetCourseDetails
    @cid INT
AS
BEGIN
    BEGIN TRY
        SELECT
            c.cid,
            c.cname,
            c.description,
            c.cyear,
            c.semester,
            c.creation_date,
            c.rating,
            c.subject,
            c.price,
            t.tid,
            u.fname + ' ' + u.lname AS teacher_name
        FROM course c
        LEFT JOIN teacher t ON c.tid = t.tid
        LEFT JOIN app_user u ON t.tid = u.uid
        WHERE c.cid = @cid;

        RETURN 0; -- success
    END TRY
    BEGIN CATCH
        RETURN -1; -- failure
    END CATCH
END
GO
CREATE PROCEDURE GetStudentEnrolledCourses
    @sid INT
AS
BEGIN
    BEGIN TRY
        SELECT c.cid, c.cname, c.description, c.cyear, c.semester, c.subject, c.price, e.rating AS student_rating
        FROM enroll e
        INNER JOIN course c ON e.cid = c.cid
        WHERE e.sid = @sid;

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END
go
CREATE PROCEDURE GetCourseContentWithFinishStatus
    @cid INT,
    @sid INT
AS
BEGIN
    SET NOCOUNT ON;
		--Return Sections and Objects with Finished Flag
    SELECT 
        s.secid,
        o.oid,
        o.title,
        CASE 
            WHEN f.oid IS NOT NULL THEN 1
            ELSE 0
        END AS finished_flag
    FROM section s
    JOIN object o ON s.secid = o.secid
    LEFT JOIN finish f ON o.oid = f.oid AND f.sid = @sid
    WHERE s.cid = @cid
    ORDER BY s.sec_order, o.o_order;
END;