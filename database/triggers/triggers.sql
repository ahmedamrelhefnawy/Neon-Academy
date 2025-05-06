CREATE TRIGGER trg_UpdateCourseRatingAfterReview
ON review
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;

    DECLARE @cid INT;

    SELECT TOP 1 @cid = cid FROM inserted;

    UPDATE course
    SET rating = (
        SELECT AVG(rating * 1.0)
        FROM review
        WHERE cid = @cid
    )
    WHERE cid = @cid;
END

Go

CREATE TRIGGER trg_UpdateTeacherRatingAfterCourseUpdate
ON course
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;

    -- Only update when the rating field is updated
    IF UPDATE(rating)
    BEGIN
        DECLARE @tid INT;

        SELECT TOP 1 @tid = tid
        FROM inserted;

        UPDATE teacher
        SET rating = (
            SELECT AVG(rating * 1.0)
            FROM course
            WHERE tid = @tid
        )
        WHERE tid = @tid;
    END
END

Go

CREATE TRIGGER trg_prevent_double_enroll
ON enroll
INSTEAD OF INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1
        FROM enroll e
        JOIN inserted i ON e.sid = i.sid AND e.cid = i.cid
    )
    BEGIN
        THROW 50002, 'Student is already enrolled in this course.', 1;
    END
    ELSE
    BEGIN
        INSERT INTO enroll (sid, cid, rating)
        SELECT sid, cid, rating FROM inserted;
    END
END;
