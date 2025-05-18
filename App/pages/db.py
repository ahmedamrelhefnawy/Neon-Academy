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
                DECLARE @user_type INT;
                EXEC authenticate_user %s, %s, @uid OUTPUT, @user_type OUTPUT;
                SELECT @uid AS uid, @user_type AS user_type;
            '''
            params = [email, password]
            cursor.execute(query, params)
            uid, user_type = cursor.fetchone()
            
            return uid, user_type
        
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

def get_student_profile(student_id):
    with connection.cursor() as cursor:
        try:
            sp_name = "GetStudentProfile"
            query = f'''EXEC {sp_name} %s'''
            params = [student_id]
            cursor.execute(query, params)
            student = cursor.fetchone()
            
            return student
        except Exception as e:
            print("Error while calling stored procedure: ", e)
            return False

def update_student_profile(
    student_id,
    fname,
    lname,
    email,
    phone,
    dob,
    picture,
    password,
):
    with connection.cursor() as cursor:
        try:
            sp_name = "UpdateStudentProfile"
            query = f'''
            declare @result int
            EXEC @result = {sp_name} %s, %s, %s, %s, %s, %s, %s, %s
            select @result
            '''
            params = [student_id, fname, lname, email, phone, dob, picture, password]
            cursor.execute(query, params)
            result = cursor.fetchone()
            
            return result
        except Exception as e:
            print("Error while calling stored procedure: ", e)
            return False

def get_top_courses():
    with connection.cursor() as cursor:
        try:
            sp_name = "get_top_10_rated_courses"
            query = f"EXEC {sp_name}"
            
            cursor.execute(query)
            result = cursor.fetchall()
            
            return result
        except Exception as e:
            print("Error while calling stored procedure: ", e)
            return False

def search_courses(
    key= None,
    subject= None,
    max_rate= None,
    min_rate= None,
    academic_year= None,
    max_price= None,
    min_price= None
):
    with connection.cursor() as cursor:
        try:
            sp_name = "search_courses"
            query = f"EXEC {sp_name} %s, %s, %s, %s, %s, %s, %s"
            params = [key ,subject ,max_rate ,min_rate ,academic_year ,max_price ,min_price]
            
            cursor.execute(query, params)
            result = cursor.fetchall()
            
            return result
        except Exception as e:
            print("Error while calling stored procedure: ", e)
            return False