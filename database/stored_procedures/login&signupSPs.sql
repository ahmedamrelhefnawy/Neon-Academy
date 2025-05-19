create PROCEDURE create_teacher_account
    @fname VARCHAR(20),
    @lname VARCHAR(20),
    @email VARCHAR(100),
    @dob DATE,
    @password VARCHAR(50),
    @picture varbinary(MAX),
    @gender VARCHAR(7),
    @phone CHAR(11)
with encryption
AS
BEGIN
	-- Prevents extra messages like "N rows affected" from being returned. Cleaner output.
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert into app_user
        INSERT INTO app_user (fname, lname, email, password, dob, gender, phone, picture)
		VALUES (@fname, @lname, @email, @password, @dob, @gender, @phone, @picture);

        -- Get the newly inserted uid
        DECLARE @new_uid INT;
        SET @new_uid = SCOPE_IDENTITY();

		-- insert into teacher table
		INSERT INTO teacher (tid, auth_doc, rating)
		VALUES (@new_uid, null, null);

        COMMIT TRANSACTION;

        RETURN 0; -- success
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        RETURN -1; -- failure (error occurred)
    END CATCH
END

go

create PROCEDURE create_student_account
    @fname VARCHAR(20),
    @lname VARCHAR(20),
    @email VARCHAR(100),
    @dob DATE,
    @password VARCHAR(50),
    @gender VARCHAR(7),
    @acad_year VARCHAR(50),
    @phone CHAR(11)
with encryption
AS
BEGIN
	-- Prevents extra messages like "N rows affected" from being returned. Cleaner output.
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert into app_user
		INSERT INTO app_user (fname, lname, email, dob, password, gender, phone)
		VALUES (@fname, @lname, @email, @dob, @password, @gender, @phone);

        -- Get the newly inserted uid
        DECLARE @new_uid INT;
        SET @new_uid = SCOPE_IDENTITY();

        -- Insert into student
        INSERT INTO student (sid, acad_year)
        VALUES (@new_uid, @acad_year);

        COMMIT TRANSACTION;

        RETURN 0; -- success
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        RETURN -1; -- failure (error occurred)
    END CATCH
END

go 

--returns the uid (user id)
CREATE PROCEDURE authenticate_user
    @email VARCHAR(100),
    @password VARCHAR(50),
    @uid INT OUTPUT,
    @user_type INT OUTPUT  -- 0 = student, 1 = teacher, -1 = not found
AS
BEGIN
    SET NOCOUNT ON;

    SELECT @uid = uid
    FROM app_user
    WHERE email = @email AND password = @password;

    IF @uid IS NULL
    BEGIN
        SET @user_type = -1;
        RETURN;
    END

    IF EXISTS (SELECT 1 FROM student WHERE sid = @uid)
    BEGIN
        SET @user_type = 0;
    END
    ELSE IF EXISTS (SELECT 1 FROM teacher WHERE tid = @uid)
    BEGIN
        SET @user_type = 1;
    END
    ELSE
    BEGIN
        SET @user_type = -1;
    END
END;
go

CREATE PROCEDURE add_student_photo
    @sid INT,
    @photo VARBINARY(MAX)
AS
BEGIN
    SET NOCOUNT ON;

    UPDATE app_user
    SET picture = @photo
    WHERE uid = @sid;

    RETURN 0;
END