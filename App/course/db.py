from django.db import connection

def get_sections(course_id):
    with connection.cursor() as cursor:
        try:
            sp_name = "GetSectionsByCourse"
            query = f"EXEC {sp_name} %s"
            
            params = [course_id]
            cursor.execute(query, params)
            result = cursor.fetchall()
            
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
            result = cursor.fetchall()
            
            return result

        except Exception as e:
            print("Error while calling stored procedure:", e)
            return False

def get_finished_objects(student_id, course_id):
    with connection.cursor() as cursor:
        try:
            sp_name = "FinishedObjects"
            query = f"EXEC {sp_name} %s"

            params = [student_id]
            cursor.execute(query, params)
            result = cursor.fetchall()
            
            return result

        except Exception as e:
            print("Error while calling stored procedure:", e)
            return False