CREATE PROCEDURE sp_teacher_view_student_grades
    @course_id INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT 
            f.sid,
            au.fname + ' ' + au.lname AS student_name,
            o.title,
            o.type,
            f.grade
        FROM 
            finish f
        JOIN 
            object o ON f.oid = o.oid
        JOIN 
            section s ON o.secid = s.secid
        JOIN 
            course c ON s.cid = c.cid
        JOIN 
            app_user au ON f.sid = au.uid
        WHERE 
            c.cid = @course_id;

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END;
go
CREATE PROCEDURE sp_teacher_view_enrolled_students
    @course_id INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT 
            s.sid,
            au.fname + ' ' + au.lname AS student_name,
            e.rating AS course_rating
        FROM 
            enroll e
        JOIN 
            student s ON e.sid = s.sid
        JOIN 
            app_user au ON s.sid = au.uid
        WHERE 
            e.cid = @course_id;

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END;
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
CREATE PROCEDURE sp_teacher_delete_object
    @object_id INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DELETE FROM object
        WHERE oid = @object_id;

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END;
go 
CREATE PROCEDURE sp_teacher_update_object
    @object_id INT,
    @new_title NVARCHAR(255),
    @new_type NVARCHAR(50),
    @new_description NVARCHAR(MAX)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        UPDATE object
        SET title = @new_title,
            type = @new_type,
            description = @new_description
        WHERE oid = @object_id;

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END;
go
CREATE PROCEDURE sp_teacher_add_object
    @section_id INT,
    @type VARCHAR(10),      -- 'exam' or 'assignment'
    @title VARCHAR(30),
    @description VARCHAR(150)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        INSERT INTO object (secid, type, title, description)
        VALUES (@section_id, @type, @title, @description);

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END;
go 
CREATE PROCEDURE sp_teacher_delete_section
    @section_id INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DELETE FROM section
        WHERE secid = @section_id;

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END;
go 
CREATE PROCEDURE sp_teacher_update_section
    @section_id INT,
    @new_sec_order INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        UPDATE section
        SET sec_order = @new_sec_order
        WHERE secid = @section_id;

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END;
go 
CREATE PROCEDURE sp_teacher_add_section
    @course_id INT,
    @sec_order INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        INSERT INTO section (cid, sec_order)
        VALUES (@course_id, @sec_order);

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END;
go 
CREATE PROCEDURE sp_teacher_delete_course
    @course_id INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        DELETE FROM course WHERE cid = @course_id;
        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END;
go 
CREATE PROCEDURE sp_teacher_update_course
    @course_id INT,
    @cname VARCHAR(30),
    @description VARCHAR(150),
    @price DECIMAL(9,3)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        UPDATE course
        SET 
            cname = @cname,
            description = @description,
            price = @price
        WHERE 
            cid = @course_id;

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END;
go
CREATE PROCEDURE sp_teacher_add_course
    @teacher_id INT,
    @cname VARCHAR(30),
    @description VARCHAR(150),
    @cyear INT,
    @semester VARCHAR(10),
    @subject VARCHAR(15),
    @price DECIMAL(9,3)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        INSERT INTO course (tid, cname, description, cyear, semester, subject, price)
        VALUES (@teacher_id, @cname, @description, @cyear, @semester, @subject, @price);

        RETURN 0;
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END;
go
CREATE PROCEDURE sp_get_teacher_courses
    @teacher_id INT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        SELECT 
            c.cid,
            c.cname,
            c.subject,
            c.cyear,
            c.semester,
            c.rating,
            c.price
        FROM 
            course c
        WHERE 
            c.tid = @teacher_id;

        RETURN 0; -- success
    END TRY
    BEGIN CATCH
        RETURN -1; -- failure
    END CATCH
END;
