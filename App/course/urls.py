from django.urls import path
from . import views

urlpatterns = [
    path('<int:course_id>/<int:obj_id>', views.load_course_page, name='course'),
    path('download/<int:file_id>', views.download_file, name='download_file'),
    path('document/', views.document, name='document'),
    path('video/', views.video, name='video'),
    path('exam/', views.exam, name='exam'),
]