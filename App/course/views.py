from django.http import HttpResponse
from django.shortcuts import redirect, render
from django.db import connection
from . import db

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
                student_data = db.get_student_profile(request.session['uid'])
                if student_data['picture'] != None:
                    return redirect('dashboard/')
            
            else:
                del request.session['uid']
                del request.session['user_type']
                return redirect('sign_in')
            
        return view_func(request, *args, **kwargs)
    return _wrapped_view


# Create your views here.
@session_required
def load_course_page(request, course_id, obj_id):
    # Get course data
    course_data = db.get_course_details(course_id)
    
    # Get course sections
    sections = db.get_sections(course_id)
    if not sections:
        return HttpResponse("Error fetching sections.")
    
    # Get each section's objects
    for section in sections:
        section['objects'] = db.get_section_objs(section['secid'])
        if not section['objects']:
            return HttpResponse("Error fetching objects.")
    
    # Get finished objects
    finished_objects = db.get_finished_objects(request.session['uid'], course_id)
    
    # Make sidebar object (Sections, each section's objects)
    if obj_id == 0:
        obj_id = sections[0]['objects'][0]['oid'] if sections and sections[0]['objects'] else None
    
    side_bar = {
        'sections': sections,
        'selected_object': obj_id,
        'finished_objects': finished_objects,
    }
    
    # Get current object data
    current_object = db.get_full_object(obj_id)
    if not current_object:
        return HttpResponse("Error fetching current object.")

    return render(request, "course/course_page.html", {
        'course': course_data,
        'current_object': current_object,
        'side_bar': side_bar,
    })

@session_required
def download_file(request, file_id):
    # Get file data
    file_data = db.get_full_object(file_id)
    if not file_data:
        return HttpResponse("Error fetching file.")
    
    # Return the binary file content as a response
    response = HttpResponse(file_data['binary_file'], content_type='application/octet-stream')
    response['Content-Disposition'] = f'attachment; filename="{file_data["title"]}"'
    
    return response

# Temp Functions
def document(request):
    return render(request, "course/student_course_page_document.html")

def video(request):
    return render(request, "course/student_course_page_video.html")

def exam(request):
    return render(request, "course/student_course_page_exam.html")

