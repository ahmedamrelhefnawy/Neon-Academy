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
// Add functionality to download the file when the button is clicked
document.querySelector('.download-btn').addEventListener('click', function() {
    const link = document.createElement('a');
    link.href = 'path/to/your/file.pdf'; // Put the path to your file here
    link.download = 'filename.pdf'; // Name of the file to be downloaded
    link.click();
});
