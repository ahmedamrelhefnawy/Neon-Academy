document.addEventListener('DOMContentLoaded', function() {
    // Common functionality for all course page components
    
    // Toggle section content visibility only when clicking the arrow icon
    const arrowIcons = document.querySelectorAll('.section-header .arrow-icon');
    arrowIcons.forEach(icon => {
        icon.addEventListener('click', (e) => {
            e.stopPropagation(); 
            const parentSection = icon.closest('.section');
            parentSection.classList.toggle('open');
        });
    });

    // Make all sections open by default
    const allSections = document.querySelectorAll('.section');
    allSections.forEach(section => {
        section.classList.add('open');
    });

    // Video-specific functionality
    function initVideoComponent() {
        const videoContainer = document.querySelector('.video-placeholder');
        if (videoContainer) {
            // Video player initialization code here if needed
            console.log('Video component initialized');
        }
    }

    // Document-specific functionality
    function initDocumentComponent() {
        const downloadBtn = document.querySelector('.download-btn');
        if (downloadBtn) {
            downloadBtn.addEventListener('click', function() {
                // The download URL should come from the data-url attribute
                const fileUrl = downloadBtn.getAttribute('data-url');
                const fileName = downloadBtn.getAttribute('data-filename') || 'document.pdf';
                
                if (fileUrl) {
                    const link = document.createElement('a');
                    link.href = fileUrl;
                    link.download = fileName;
                    link.click();
                }
            });
        }
    }

    // Exam-specific functionality
    function initExamComponent() {
        const submitButton = document.querySelector('.submit-btn');
        if (submitButton) {
            submitButton.addEventListener('click', submitExercise);
        }

        // Highlight selected MCQ option using class (for checkboxes)
        const mcqInputs = document.querySelectorAll('.mcq-options input[type="checkbox"]');
        mcqInputs.forEach(input => {
            input.addEventListener('change', () => {
                if (input.checked) {
                    input.parentElement.classList.add('selected');
                } else {
                    input.parentElement.classList.remove('selected');
                }
            });
        });
    }

    // Submit exam answers
    function submitExercise() {
        // Collect all answers
        const answers = {};
        const questionInputs = document.querySelectorAll('input[name^="question_"]');
        
        questionInputs.forEach(input => {
            const questionId = input.name.replace('question_', '');
            
            if (input.type === 'checkbox' && input.checked) {
                if (!answers[questionId]) {
                    answers[questionId] = [];
                }
                answers[questionId].push(input.value);
            } else if (input.type === 'text') {
                answers[questionId] = input.value;
            }
        });
        
        // Here you would normally send the answers to the server
        console.log('Submitting answers:', answers);
        alert("Your answers have been submitted successfully!");
        
        // Example of AJAX submission:
        /*
        fetch('/api/submit-exam', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json',
                'X-CSRFToken': getCsrfToken() // You'd need to implement this function
            },
            body: JSON.stringify({
                examId: document.querySelector('[data-exam-id]').dataset.examId,
                answers: answers
            })
        })
        .then(response => response.json())
        .then(data => {
            if (data.success) {
                alert("Your answers have been submitted successfully!");
            } else {
                alert("There was an error submitting your answers. Please try again.");
            }
        });
        */
    }

    // Initialize components based on what's present in the DOM
    initVideoComponent();
    initDocumentComponent();
    initExamComponent();
});
