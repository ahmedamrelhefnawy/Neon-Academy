from django.urls import path
from . import views

urlpatterns = [
    path('course/<int:course_id>/<int:obj_id>', views.load_object, name='course'),
    path('document', views.document, name='document'),
    path('video', views.video, name='video'),
    path('exam', views.exam, name='exam'),
]
