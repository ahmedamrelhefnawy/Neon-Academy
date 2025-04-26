from django.contrib import admin
from django.urls import path, include
from . import views

urlpatterns = [
    path('', views.sign_in, name='sign_in'),
    path('teacher_sign_up', views.teacher_sign_up, name='teacher_sign_up'),
    path('teacher_complete_account', views.teacher_complete_account, name='teacher_complete_account')
]