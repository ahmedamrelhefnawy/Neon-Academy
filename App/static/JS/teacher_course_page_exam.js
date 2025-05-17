// Make section open
const allSections = document.querySelectorAll('.section');
allSections.forEach(section => {
    section.classList.add('open');
});
// Toggle section content visibility
const sections = document.querySelectorAll('.section-header');
sections.forEach(header => {
header.addEventListener('click', () => {
    const parent = header.parentElement;
    parent.classList.toggle('open');
});
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

