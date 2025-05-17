from django.urls import path
from . import views

urlpatterns = [
    path('', views.sign_in, name='sign_in'),
    path('teacher_sign_up/', views.teacher_sign_up, name='teacher_sign_up'),
    path('student_sign_up/', views.student_sign_up, name='student_sign_up'),
    path('teacher_complete_account/', views.teacher_complete_account, name='teacher_complete_account'),
    path('student_complete_account/', views.student_complete_account, name='student_complete_account'),
    path('update_profile', views.update_profile, name='update_profile'),
    path('forgot_password/', views.forgot_password, name='forgot_password'),
    path('reset_password/', views.reset_password, name='reset_password'),
    path('student_course_page_exam/', views.student_course_page_exam, name='student_course_page_exam'),
    path('student_course_page_document/', views.student_course_page_document, name='student_course_page_document'),
    path('student_course_page_video/', views.student_course_page_video, name='student_course_page_video'),
    path('teacher_course_page_exam/', views.teacher_course_page_exam, name='teacher_course_page_exam'),
    path('logout/', views.logout, name='logout'),
]