from django.http import HttpResponse
from django.shortcuts import redirect, render
from django.db import connection
from datetime import datetime

# Create your views here.

def load_object(request, course_id, obj_id):
    if 'uid' not in request.session or 'user_type' not in request.session:
        return redirect('sign_in')
    pass


# Temp Functions
def document(request):
    return render(request, "course/student_course_page_document.html")

def video(request):
    return render(request, "course/student_course_page_video.html")

def exam(request):
    return render(request, "course/student_course_page_exam.html")

