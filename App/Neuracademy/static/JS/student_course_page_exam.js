// Submit button action
function submitExercise() {
    alert("Your answers have been submitted successfully!");
}

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
