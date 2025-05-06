CREATE PROCEDURE signup_student
    @username VARCHAR(50),
    @password VARCHAR(50),
    @fname VARCHAR(20),
    @lname VARCHAR(20),
    @email VARCHAR(100),
    @dob DATE,
    @gender VARCHAR(7),
    @picture VARCHAR(100),
    @phone CHAR(11),
    @acad_year INT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert into app_user
        INSERT INTO app_user (username, password, fname, lname, email, dob, gender, picture, phone)
        VALUES (@username, @password, @fname, @lname, @email, @dob, @gender, @picture, @phone);

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
        RETURN -1; -- failure
    END CATCH
END

go

CREATE PROCEDURE signup_teacher
    @username VARCHAR(50),
    @password VARCHAR(50),
    @fname VARCHAR(20),
    @lname VARCHAR(20),
    @email VARCHAR(100),
    @dob DATE,
    @gender VARCHAR(7),
    @picture VARCHAR(100),
    @phone CHAR(11),
    @auth_doc VARCHAR(100),
    @rating DECIMAL(3,1)
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION;

        -- Insert into app_user
        INSERT INTO app_user (username, password, fname, lname, email, dob, gender, picture, phone)
        VALUES (@username, @password, @fname, @lname, @email, @dob, @gender, @picture, @phone);

        -- Get the newly inserted uid
        DECLARE @new_uid INT;
        SET @new_uid = SCOPE_IDENTITY();

        -- Insert into teacher
        INSERT INTO teacher (tid, auth_doc, rating)
        VALUES (@new_uid, @auth_doc, @rating);

        COMMIT TRANSACTION;

        RETURN 0; -- success
    END TRY
    BEGIN CATCH
        ROLLBACK TRANSACTION;
        RETURN -1; -- failure
    END CATCH
END

go 

--returns the uid (user id)
CREATE PROCEDURE login_user
    @username VARCHAR(50),
    @password VARCHAR(50),
    @uid INT OUTPUT
AS
BEGIN
    SET NOCOUNT ON;

    BEGIN TRY
        -- Check if user exists with given username and password
        SELECT @uid = uid
        FROM app_user
        WHERE username = @username AND password = @password;

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
