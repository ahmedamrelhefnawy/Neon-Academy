from django.http import HttpResponse
from django.shortcuts import redirect, render
from django.db import connection
from datetime import datetime

# Create your views here.
def load_object(request):
    pass


# Temp Functions
def document(request):
    return render(request, "course/student_course_page_document.html")

def video(request):
    return render(request, "course/student_course_page_video.html")

def exam(request):
    return render(request, "course/student_course_page_exam.html")

