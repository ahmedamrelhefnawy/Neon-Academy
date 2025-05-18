from django.http import HttpResponse
from django.shortcuts import redirect, render
from django.db import connection
from datetime import datetime
from . import db
from functools import wraps

def session_required(view_func):
    def _wrapped_view(request, *args, **kwargs):
        if 'uid' not in request.session or 'user_type' not in request.session:
            return redirect('sign_in')
        return view_func(request, *args, **kwargs)
    return _wrapped_view

def session_exists(view_func):
    def _wrapped_view(request, *args, **kwargs):
        if 'uid' in request.session and 'user_type' in request.session:
            if request.session['user_type'] == 'teacher':
                return redirect('teacher_complete_account')
            elif request.session['user_type'] == 'student':
                return redirect('student_complete_account')
            else:
                del request.session['uid']
                del request.session['user_type']
                return redirect('sign_in')
            
        return view_func(request, *args, **kwargs)
    return _wrapped_view

# Create your views here.
@session_exists
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

@session_exists
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


@session_exists
def sign_in(request):
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

@session_required
def teacher_complete_account(request):
    return render(request, 'pages/teacher_complete_account.html')

@session_required
def student_complete_account(request):
    return render(request, 'pages/student_complete_account.html')

@session_required
def update_profile(request):
    if request.session['user_type'] == 'teacher':
        pass
    elif request.session['user_type'] == 'student':
        student_data = db.get_student_profile(request.session['uid'])
        student_data = {
            'uid': student_data[0],
            'fname': student_data[1],
            'lname': student_data[2],
            'email': student_data[3],
            'dob': student_data[4],
            'picture': student_data[6],
            'phone': student_data[7],
            'academic_year': student_data[8],
            'password': student_data[9],
        }
        
        if request.method == 'POST':
            try:
                student_data['fname'] = request.POST.get('firstName')
                student_data['lname'] = request.POST.get('lastName')
                student_data['email'] = request.POST.get('email')
                student_data['phone'] = request.POST.get('phoneNumber')

                day = request.POST.get('day')
                month = request.POST.get('month')
                year = request.POST.get('year')
                
                if day and month and year:
                    student_data['dob'] = datetime(year=int(year), month=int(month), day=int(day))
                
                password = request.POST.get('password')
                confirm_password = request.POST.get('confirmPassword')
                
                if password and password != student_data['password']:
                    if password != confirm_password:
                        return render(request, 'pages/update_profile.html', {'error': "Passwords do not match", 'student_data': student_data})
                    else:
                        student_data['password'] = password

                result = db.update_student_profile(student_id=student_data['uid'],
                                                fname=student_data['fname'],
                                                lname=student_data['lname'],
                                                email=student_data['email'],
                                                dob=student_data['dob'],
                                                phone=student_data['phone'],
                                                picture=request.FILES.get('profilePicture'),
                                                password=student_data['password'],
                )
                if result == -1:
                    return render(request, 'pages/update_profile.html', {'error': "Picture too large", 'student_data': student_data})
                elif result == -2:
                    return render(request, 'pages/update_profile.html', {'error': "Student not found", 'student_data': student_data})
                elif result == 0:
                    return render(request, 'pages/update_profile.html', {'success': "Profile updated successfully", 'student_data': student_data})
                else:
                    return render(request, 'pages/update_profile.html', {'error': "Error updating profile", 'student_data': student_data})
            except Exception as e:
                print("Error while updating profile:", e)
                return render(request, 'pages/update_profile.html', {'error': f"Error updating profile: {e}", 'student_data': student_data})
            
        return render(request, 'pages/update_profile.html', {'student_data': student_data})

@session_exists
def forgot_password(request):
    return render(request, 'pages/forgot_password.html')

@session_exists
def reset_password(request):
    return render(request, 'pages/reset_password.html')

@session_required
def logout(request):
    if 'uid' in request.session and 'user_type' in request.session:
        del request.session['uid']
        del request.session['user_type']
    
    return redirect('sign_in')
