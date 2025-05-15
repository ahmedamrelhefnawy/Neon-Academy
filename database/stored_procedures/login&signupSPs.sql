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
create PROCEDURE authenticate_user
    @email VARCHAR(100),
    @password VARCHAR(50),
    @uid INT OUTPUT
with encryption
AS
BEGIN
	-- Prevents extra messages like "N rows affected" from being returned. Cleaner output.
    SET NOCOUNT ON;

    BEGIN TRY
        -- Check if user exists with given username and password
        SELECT @uid = a.uid
        FROM app_user a
        WHERE a.email = @email AND a.password = @password;

        -- If no user found, set uid to -1
        IF @uid IS NULL
            SET @uid = -1;

        RETURN 0; -- success (even if wrong credentials, process is successful)
    END TRY
    BEGIN CATCH
        SET @uid = -1;
        RETURN -1; -- failure (error occurred)
    END CATCH
END