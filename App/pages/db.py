from django.db import connection
from datetime import datetime

def call_create_teacher_account_sp(fname, lname, email, dob, password, profilePicture, gender, phoneNumber):
    with connection.cursor() as cursor:
        try:
            sp_name = "create_teacher_account"
            query = f'''
            declare @result int
            EXEC @result = {sp_name} %s, %s, %s, %s, %s, %s, %s, %s
            select @result
            '''
            params = [fname, lname, email, dob, password, profilePicture, gender, phoneNumber]
            cursor.execute(query, params)
            result = cursor.fetchone()[0]
            if result == -1:
                return False
            else:
                return True
        except Exception as e:
            print("Error while calling stored procedure:", e)
            return False
        
def call_authenticate_user_sp(email, password):
    with connection.cursor() as cursor:
        try:
            sp_name = "authenticate_user"
            query = f"EXEC {sp_name} %s, %s, @uid OUTPUT;"
            query = '''
                DECLARE @uid INT;
                EXEC authenticate_user %s, %s, @uid OUTPUT;
                SELECT @uid;
            '''
            params = [email, password]
            cursor.execute(query, params)
            uid = cursor.fetchone()[0]
            if uid == -1:
                return False
            else:
                return True
        except Exception as e:
            print("Error while calling stored procedure:", e)
            return False
        
def call_create_student_account_sp(fname, lname, email, dob, password, gender, academicYear, phone_number):
    with connection.cursor() as cursor:
        try:
            sp_name = "create_student_account"
            query = f'''
            declare @result int
            EXEC @result = {sp_name} %s, %s, %s, %s, %s, %s, %s, %s
            select @result
            '''
            params = [fname, lname, email, dob, password, gender, academicYear, phone_number]
            cursor.execute(query, params)
            result = cursor.fetchone()[0]
            if result == -1:
                return False
            else:
                return True
        except Exception as e:
            print("Error while calling stored procedure: ", e)
            return False