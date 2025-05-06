--If -1, show "Username already taken" or "Wrong password"
CREATE PROCEDURE ChangeUsernameAndPassword
    @UserId INT,
    @NewUsername VARCHAR(50),
    @OldPassword VARCHAR(50),
    @NewPassword VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF NOT EXISTS (SELECT 1 FROM app_user WHERE uid = @UserId AND password = @OldPassword)
            RETURN -1; -- Wrong old password or user not found

        -- Check username uniqueness
        IF EXISTS (SELECT 1 FROM app_user WHERE username = @NewUsername AND uid <> @UserId)
            RETURN -1; -- Username already taken by another user

        UPDATE app_user
        SET 
            username = @NewUsername,
            password = @NewPassword
        WHERE uid = @UserId;

        RETURN 0; -- Success
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END
go
CREATE PROCEDURE ChangeUsername
    @UserId INT,
    @NewUsername VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        IF EXISTS (SELECT 1 FROM app_user WHERE uid = @UserId)
        BEGIN
            -- Check if new username already exists (must be unique)
            IF EXISTS (SELECT 1 FROM app_user WHERE username = @NewUsername)
                RETURN -1; -- Username already taken

            UPDATE app_user
            SET username = @NewUsername
            WHERE uid = @UserId;

            RETURN 0; -- Success
        END
        ELSE
            RETURN -1; -- User not found
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END
go
CREATE PROCEDURE ChangePassword
    @UserId INT,
    @OldPassword VARCHAR(50),
    @NewPassword VARCHAR(50)
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Verify user exists and old password matches
        IF EXISTS (SELECT 1 FROM app_user WHERE uid = @UserId AND password = @OldPassword)
        BEGIN
            UPDATE app_user
            SET password = @NewPassword
            WHERE uid = @UserId;

            RETURN 0; -- Success
        END
        ELSE
            RETURN -1; -- Wrong old password or user not found
    END TRY
    BEGIN CATCH
        RETURN -1;
    END CATCH
END
