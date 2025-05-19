from django.db import connection

def get_sections(course_id):
    with connection.cursor() as cursor:
        try:
            sp_name = "GetSectionsByCourse"
            query = f"EXEC {sp_name} %s"
            
            params = [course_id]
            cursor.execute(query, params)
            
            columns = [col[0] for col in cursor.description]
            result = [dict(zip(columns, row)) for row in cursor.fetchall()]

            return result

        except Exception as e:
            print("Error while calling stored procedure:", e)
            return False

def get_section_objs(sec_id):
    with connection.cursor() as cursor:
        try:
            sp_name = "GetObjectsBySection"
            query = f"EXEC {sp_name} %s"

            params = [sec_id]
            cursor.execute(query, params)
            
            columns = [col[0] for col in cursor.description]
            result = [dict(zip(columns, row)) for row in cursor.fetchall()]
            
            return result

        except Exception as e:
            print("Error while calling stored procedure:", e)
            return False

def get_finished_objects(student_id, course_id):
    with connection.cursor() as cursor:
        try:
            sp_name = "FinishedObjects"
            query = f"EXEC {sp_name} %s, %s"

            params = [student_id, course_id]
            cursor.execute(query, params)
            
            columns = [col[0] for col in cursor.description]
            result = [dict(zip(columns, row)) for row in cursor.fetchall()]
            
            return result

        except Exception as e:
            print("Error while calling stored procedure:", e)
            return False

def submit_review(cid, sid, rating, content):
    with connection.cursor() as cursor:
        try:
            sp_name = "SubmitReview"
            query = f"EXEC {sp_name} %s, %s, %s, %s"
            params = [cid, sid, rating, content]
            cursor.execute(query, params)
            return cursor.fetchone()[0] if cursor.description else 0
        except Exception as e:
            print("Error while calling stored procedure:", e)
            return -1

def remove_enrollment(sid, cid):
    with connection.cursor() as cursor:
        try:
            sp_name = "RemoveEnrollment"
            query = f"EXEC {sp_name} %s, %s"
            params = [sid, cid]
            cursor.execute(query, params)
            return cursor.fetchone()[0] if cursor.description else 0
        except Exception as e:
            print("Error while calling stored procedure:", e)
            return -1

def enroll_in_course(sid, cid):
    with connection.cursor() as cursor:
        try:
            sp_name = "EnrollInCourse"
            query = f"EXEC {sp_name} %s, %s"
            params = [sid, cid]
            cursor.execute(query, params)
            return cursor.fetchone()[0] if cursor.description else 0
        except Exception as e:
            print("Error while calling stored procedure:", e)
            return -1

def mark_object_as_finished(sid, oid, grade):
    with connection.cursor() as cursor:
        try:
            sp_name = "MarkObjectAsFinished"
            query = f"EXEC {sp_name} %s, %s, %s"
            params = [sid, oid, grade]
            cursor.execute(query, params)
            return cursor.fetchone()[0] if cursor.description else 0
        except Exception as e:
            print("Error while calling stored procedure:", e)
            return -1

def is_object_finished(sid, oid):
    with connection.cursor() as cursor:
        try:
            sp_name = "IsObjectFinished"
            # OUTPUT parameters are not directly supported, so use a workaround
            cursor.execute("DECLARE @isFinished INT; EXEC IsObjectFinished %s, %s, @isFinished OUTPUT; SELECT @isFinished;", [sid, oid])
            result = cursor.fetchone()
            return result[0] if result else None
        except Exception as e:
            print("Error while calling stored procedure:", e)
            return None

def get_student_finished_objects(sid):
    with connection.cursor() as cursor:
        try:
            sp_name = "GetStudentFinishedObjects"
            query = f"EXEC {sp_name} %s"
            params = [sid]
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            result = [dict(zip(columns, row)) for row in cursor.fetchall()]
            return result
        except Exception as e:
            print("Error while calling stored procedure:", e)
            return False

def get_course_details(cid):
    with connection.cursor() as cursor:
        try:
            sp_name = "GetCourseDetails"
            query = f"EXEC {sp_name} %s"
            params = [cid]
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            result = [dict(zip(columns, row)) for row in cursor.fetchall()]
            return result[0] if result else None
        except Exception as e:
            print("Error while calling stored procedure:", e)
            return None

def get_student_enrolled_courses(sid):
    with connection.cursor() as cursor:
        try:
            sp_name = "GetStudentEnrolledCourses"
            query = f"EXEC {sp_name} %s"
            params = [sid]
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            result = [dict(zip(columns, row)) for row in cursor.fetchall()]
            return result
        except Exception as e:
            print("Error while calling stored procedure:", e)
            return False

def get_course_content_with_finish_status(cid, sid):
    with connection.cursor() as cursor:
        try:
            sp_name = "GetCourseContentWithFinishStatus"
            query = f"EXEC {sp_name} %s, %s"
            params = [cid, sid]
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            result = [dict(zip(columns, row)) for row in cursor.fetchall()]
            return result
        except Exception as e:
            print("Error while calling stored procedure:", e)
            return False

def get_full_object(oid):
    with connection.cursor() as cursor:
        try:
            sp_name = "GetObjectById"
            query = f"EXEC {sp_name} %s"
            params = [oid]
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            result = dict(zip(columns, cursor.fetchone()))
            
            return result
        
        except Exception as e:
            print("Error while calling stored procedure:", e)
            return None
def get_exam_questions(eid):
    with connection.cursor() as cursor:
        try:
            sp_name = "GetExamQuestions"
            query = f"EXEC {sp_name} %s"
            params = [eid]
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            result = [dict(zip(columns, row)) for row in cursor.fetchall()]
            return result
        except Exception as e:
            print("Error while calling stored procedure:", e)
            return False

def get_mcq_details(qid):
    with connection.cursor() as cursor:
        try:
            sp_name = "GetMCQDetails"
            query = f"EXEC {sp_name} %s"
            params = [qid]
            cursor.execute(query, params)
            columns = [col[0] for col in cursor.description]
            result = [dict(zip(columns, row)) for row in cursor.fetchall()]
            return result[0] if result else None
        except Exception as e:
            print("Error while calling stored procedure:", e)
            return None
