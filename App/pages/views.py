from django.http import HttpResponse
from django.shortcuts import redirect, render
from django.db import connection
from django.contrib import messages
from datetime import datetime

# Helper functions
def call_create_teacher_account_sp(fname, lname, email, dob, password, profilePicture, gender, phoneNumber):
    with connection.cursor() as cursor:
        try:
            sp_name = "create_teacher_account"
            query = f"EXEC {sp_name} %s, %s, %s, %s, %s, %s, %s, %s"
            params = [fname, lname, email, dob, password, profilePicture, gender, phoneNumber]
            cursor.execute(query, params)
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

# Create your views here.
def teacher_sign_up(request):
    if request.method == 'POST':
        first_name = request.POST.get('firstName')
        last_name = request.POST.get('lastName')
        email = request.POST.get('email')
        password = request.POST.get('password')
        gender = request.POST.get('gender')
        phone_number = request.POST.get('phoneNumber')
        day = request.POST.get('day')
        month = request.POST.get('month')
        year = request.POST.get('year')
        dob = datetime(year=int(year), month=int(month), day=int(day))

        profile_picture = request.FILES.get('profilePicture')
        profile_picture_binary = profile_picture.read()

        if call_create_teacher_account_sp(first_name, last_name, email, dob, password, profile_picture_binary, gender, phone_number):
            return redirect('teacher_complete_account')

    return render(request, 'pages/teacher_sign_up.html')

def sign_in(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')

        if call_authenticate_user_sp(email, password):
            return HttpResponse("Signed in successfully!")
        
    return render(request, 'pages/sign_in.html')

def student_sign_up(request):
    return render(request, 'pages/student_sign_up.html')

def teacher_complete_account(request):
    return render(request, 'pages/teacher_complete_account.html')

def student_complete_account(request):
    return render(request, 'pages/student_complete_account.html')

def forgot_password(request):
    return render(request, 'pages/forgot_password.html')

def reset_password(request):
    return render(request, 'pages/reset_password.html')