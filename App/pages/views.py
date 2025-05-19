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

def require_no_session(view_func):
    def _wrapped_view(request, *args, **kwargs):
        if 'uid' in request.session and 'user_type' in request.session:
            if request.session['user_type'] == 'teacher':
                return redirect('teacher_complete_account')
            
            elif request.session['user_type'] == 'student':
                return redirect('dashboard/')
            
            else:
                del request.session['uid']
                del request.session['user_type']
                return redirect('sign_in')
            
        return view_func(request, *args, **kwargs)
    return _wrapped_view

# Create your views here.
@require_no_session
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

@require_no_session
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
            uid, user_type = db.call_authenticate_user_sp(email, password)
            # Save user data
            types = ['student', 'teacher']
            request.session['uid'] = uid
            request.session['user_type'] = types[user_type]
            
            # Redirect to the complete account page
            return redirect('student_complete_account')

    return render(request, 'pages/student_sign_up.html')


@require_no_session
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

        return redirect('dashboard/') #TODO: Replace with My Courses page
    
    return render(request, 'pages/sign_in.html')

@session_required
def teacher_complete_account(request):
    return render(request, 'pages/teacher_complete_account.html')

@session_required
def student_complete_account(request):
    if request.method == 'POST':
        print(request.POST)
        picture = request.POST.get('AuthenticationFile')
        picture = b'picture'
        
        if picture and db.add_student_photo(request.session['uid'], picture):
            # Redirect to the dashboard or any other page
            return redirect('courses_dashboard')
    return render(request, 'pages/student_complete_account.html')

@session_required
def update_profile(request):
    if request.session['user_type'] == 'teacher':
        pass
    elif request.session['user_type'] == 'student':
        student_data = db.get_student_profile(request.session['uid'])
        print(student_data)
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

@require_no_session
def forgot_password(request):
    return render(request, 'pages/forgot_password.html')

@require_no_session
def reset_password(request):
    return render(request, 'pages/reset_password.html')

@session_required
def logout(request):
    if 'uid' in request.session and 'user_type' in request.session:
        del request.session['uid']
        del request.session['user_type']
    
    return redirect('sign_in')

@session_required
def courses_dashboard(request):
    """
    View for the courses dashboard page with filtering and search functionality
    """
    
    search_query = request.GET.get('search', '')
    sort_by = request.GET.get('sort', '')
    academic_year = request.GET.get('year', '')
    subject = request.GET.get('subject', None)
    min_price = request.GET.get('min_price', '')
    max_price = request.GET.get('max_price', '')
    
    # Get the best sellers courses
    best_sellers = db.get_top_courses()
    
    # Set up filters for the search_courses stored procedure
    min_rate = None
    max_rate = None
    
    # Apply sorting logic
    if sort_by == 'rating-high':
        min_rate = 0
        max_rate = 10
    elif sort_by == 'rating-low':
        min_rate = 0
        max_rate = 10
        # We'll need to reverse the result later
    
    # Convert academic year to int if provided
    acad_year = int(academic_year) if academic_year and academic_year.isdigit() else None
    
    # Convert price filters to decimal if provided
    min_price_val = float(min_price) if min_price and min_price.replace('.', '', 1).isdigit() else None
    max_price_val = float(max_price) if max_price and max_price.replace('.', '', 1).isdigit() else None
    
    courses = db.search_courses(search_query, subject, max_rate, min_rate, acad_year, max_price_val, min_price_val)        
    
    # Apply additional sorting if needed
    if sort_by == 'rating-low':
        courses = courses[::-1]  # Reverse the list for rating low to high
    elif sort_by == 'price-high' and courses:
        courses.sort(key=lambda x: x['price'] if x['price'] is not None else 0, reverse=True)
    elif sort_by == 'price-low' and courses:
        courses.sort(key=lambda x: x['price'] if x['price'] is not None else 0)
    elif sort_by == 'newest' and courses:
        # This would require creation_date in the result, 
        # which might need a modification of the stored procedure
        pass
    context = {
        'best_sellers': best_sellers,
        'courses': courses,
        'search_query': search_query,
        'sort_by': sort_by,
        'academic_year': academic_year,
        'subject': subject,
        'min_price': min_price,
        'max_price': max_price
    }
    
    return render(request, 'pages/courses_dashboard.html', context)

def enroll_course(request, course_id):
    """
    View for enrolling in a course
    """
    if request.method == 'POST':
        student_id = request.session['uid']
        result = db.enroll_course(student_id, course_id)
        
        if result:
            return redirect('course')
        else:
            return HttpResponse("Error enrolling in course")
    
    return HttpResponse("Invalid request method")