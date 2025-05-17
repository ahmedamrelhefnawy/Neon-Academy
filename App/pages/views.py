from django.http import HttpResponse
from django.shortcuts import redirect, render
from django.db import connection
from datetime import datetime
from . import db

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

        if db.call_create_teacher_account_sp(first_name, last_name, email, dob, password, profile_picture_binary, gender, phone_number):
            return redirect('teacher_complete_account')

    return render(request, 'pages/teacher_sign_up.html')

def sign_in(request):
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')

        if db.call_authenticate_user_sp(email, password):
            return HttpResponse("Signed in successfully!")
        
    return render(request, 'pages/sign_in.html')

def student_sign_up(request):
    if request.method == 'POST':
        first_name = request.POST.get('firstName')
        last_name = request.POST.get('lastName')
        email = request.POST.get('email')
        day = request.POST.get('day')
        month = request.POST.get('month')
        year = request.POST.get('year')
        dob = datetime(year=int(year), month=int(month), day=int(day))
        password = request.POST.get('password')
        gender = request.POST.get('gender')
        academic_year = request.POST.get('academicYear')
        phone_number = request.POST.get('phoneNumber')

        if db.call_create_student_account_sp(first_name, last_name, email, dob, password, gender, academic_year, phone_number):
            return redirect('student_complete_account')

    return render(request, 'pages/student_sign_up.html')

def teacher_complete_account(request):
    return render(request, 'pages/teacher_complete_account.html')

def student_complete_account(request):
    return render(request, 'pages/student_complete_account.html')

def forgot_password(request):
    return render(request, 'pages/forgot_password.html')

def reset_password(request):
    return render(request, 'pages/reset_password.html')

def student_course_page_exam(request):
    return render(request, 'pages/student_course_page_exam.html')

def student_course_page_document(request):
    return render(request, 'pages/student_course_page_document.html')

def student_course_page_video(request):
    return render(request, 'pages/student_course_page_video.html')

def teacher_course_page_exam(request):
    return render(request, 'pages/teacher_course_page_exam.html')
