from django.http import HttpResponse
from django.shortcuts import redirect, render
from django.db import connection
from datetime import datetime
from . import db
from django.http import HttpResponse
from django.shortcuts import redirect, render
from django.db import connection
from datetime import datetime
from . import db

# Create your views here.
def teacher_sign_up(request):
    if 'uid' in request.session and 'user_type' in request.session:
        return redirect('teacher_complete_account')
    
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

    if 'uid' in request.session and 'user_type' in request.session:
        return redirect('teacher_complete_account')
    
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
    if 'uid' in request.session and 'user_type' in request.session:
        if request.session['user_type'] == 'teacher':
            return redirect('teacher_complete_account')
        
        if request.session['user_type'] == 'student':
            # TODO: Put Courses landing page here
            return redirect('student_complete_account')
        else:
            del request.session['uid']
            del request.session['user_type']
            
            return redirect('sign_in')
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')
        
        uid, user_type = db.call_authenticate_user_sp(email, password)

        if user_type == -1:
            return render(request, 'pages/sign_in.html', {'email': email, 'password': password, 'error': "Error in email or password"})
        
        # Save user data
        types = ['student', 'teacher']
        request.session['uid'] = uid
        request.session['user_type'] = types[user_type]

        return redirect('student_complete_account')
    
    return render(request, 'pages/sign_in.html')

def sign_in(request):
    if 'uid' in request.session and 'user_type' in request.session:
        if request.session['user_type'] == 'teacher':
            return redirect('teacher_complete_account')
        
        if request.session['user_type'] == 'student':
            # TODO: Put Courses landing page here
            return redirect('student_complete_account')
        else:
            del request.session['uid']
            del request.session['user_type']
            
            return redirect('sign_in')
    if request.method == 'POST':
        email = request.POST.get('email')
        password = request.POST.get('password')
        
        uid, user_type = db.call_authenticate_user_sp(email, password)

        if user_type == -1:
            return render(request, 'pages/sign_in.html', {'email': email, 'password': password, 'error': "Error in email or password"})
        
        # Save user data
        types = ['student', 'teacher']
        request.session['uid'] = uid
        request.session['user_type'] = types[user_type]

        return redirect('student_complete_account')
    
    return render(request, 'pages/sign_in.html')

def student_sign_up(request):
    if 'uid' in request.session and 'user_type' in request.session:
        return redirect('student_complete_account')
    
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

    if 'uid' in request.session and 'user_type' in request.session:
        return redirect('student_complete_account')
    
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

def update_profile(request):
    return render(request, 'pages/update_profile.html')

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

def logout(request):
    if 'uid' in request.session and 'user_type' in request.session:
        del request.session['uid']
        del request.session['user_type']
    
    return redirect('sign_in')
