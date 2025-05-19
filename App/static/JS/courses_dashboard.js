// Courses Dashboard JavaScript

document.addEventListener('DOMContentLoaded', function() {
    // Function to get URL parameters
    function getUrlParameter(name) {
        name = name.replace(/[\[]/, '\\[').replace(/[\]]/, '\\]');
        const regex = new RegExp('[\\?&]' + name + '=([^&#]*)');
        const results = regex.exec(location.search);
        return results === null ? '' : decodeURIComponent(results[1].replace(/\+/g, ' '));
    }
    
    // Slider functionality
    const coursesCards = document.querySelector('.courses-cards');
    const prevBtn = document.querySelector('.slider-prev');
    const nextBtn = document.querySelector('.slider-next');
    const cardWidth = 270; // Card width + gap
    
    // Prevent errors if slider elements don't exist
    if (prevBtn && nextBtn && coursesCards) {
        // Slider arrows functionality
        prevBtn.addEventListener('click', () => {
            coursesCards.scrollBy({ left: -cardWidth * 3, behavior: 'smooth' });
        });
        
        nextBtn.addEventListener('click', () => {
            coursesCards.scrollBy({ left: cardWidth * 3, behavior: 'smooth' });
        });
    }
    
    // Filter functionality
    const searchInput = document.getElementById('searchInput');
    const sortSelect = document.getElementById('sortOption');
    const academicYearSelect = document.getElementById('academicYearOption');
    const subjectSelect = document.getElementById('subjectSelect');
    const minPriceInput = document.getElementById('minPrice');
    const maxPriceInput = document.getElementById('maxPrice');
    const resetBtn = document.getElementById('resetFilters');
    const searchBtn = document.querySelector('.search-btn');
    
    // Populate filter fields with URL parameters (if they exist)
    if (searchInput) searchInput.value = getUrlParameter('search');
    
    if (sortSelect) {
        const sortValue = getUrlParameter('sort');
        if (sortValue) {
            // Find and select the option with matching value
            for (let i = 0; i < sortSelect.options.length; i++) {
                if (sortSelect.options[i].value === sortValue) {
                    sortSelect.selectedIndex = i;
                    break;
                }
            }
        }
    }
    
    if (academicYearSelect) {
        const yearValue = getUrlParameter('year');
        if (yearValue) {
            // Find and select the option with matching value
            for (let i = 0; i < academicYearSelect.options.length; i++) {
                if (academicYearSelect.options[i].value === yearValue) {
                    academicYearSelect.selectedIndex = i;
                    break;
                }
            }
        }
    }
    
    if (subjectSelect) {
        const subjectValue = getUrlParameter('subject');
        if (subjectValue) {
            // Find and select the option with matching value
            for (let i = 0; i < subjectSelect.options.length; i++) {
                if (subjectSelect.options[i].value === subjectValue) {
                    subjectSelect.selectedIndex = i;
                    break;
                }
            }
        }
    }
    
    if (minPriceInput) minPriceInput.value = getUrlParameter('min_price');
    if (maxPriceInput) maxPriceInput.value = getUrlParameter('max_price');
    
    // Apply filters function
    function applyFilters() {
        // Get filter values
        const searchTerm = searchInput.value.trim().toLowerCase();
        const sortBy = sortSelect.value;
        const academicYear = academicYearSelect.value;
        
        // Get selected subject
        const subject = subjectSelect.value;
        
        const minPrice = minPriceInput.value ? parseFloat(minPriceInput.value) : null;
        const maxPrice = maxPriceInput.value ? parseFloat(maxPriceInput.value) : null;
        
        // Here you would typically make an AJAX call to the backend with these filters
        // For demo purposes, we'll just log them
        // console.log({
        //     searchTerm,
        //     sortBy,
        //     academicYear,
        //     subject,
        //     minPrice,
        //     maxPrice
        // });
        
        // In a real implementation, you'd send these parameters to the server
        // and reload the courses based on the response
        // For now, let's simulate a form submission
        const form = document.createElement('form');
        form.method = 'GET';
        form.action = window.location.href;
        
        // Add form fields for each filter
        if (searchTerm) {
            const searchField = document.createElement('input');
            searchField.type = 'hidden';
            searchField.name = 'search';
            searchField.value = searchTerm;
            form.appendChild(searchField);
        }
        
        if (sortBy) {
            const sortField = document.createElement('input');
            sortField.type = 'hidden';
            sortField.name = 'sort';
            sortField.value = sortBy;
            form.appendChild(sortField);
        }
        
        if (academicYear) {
            const yearField = document.createElement('input');
            yearField.type = 'hidden';
            yearField.name = 'year';
            yearField.value = academicYear;
            form.appendChild(yearField);
        }
        
        if (subject) {
            const subjectField = document.createElement('input');
            subjectField.type = 'hidden';
            subjectField.name = 'subject';
            subjectField.value = subject;
            form.appendChild(subjectField);
        }
        
        if (minPrice !== null) {
            const minField = document.createElement('input');
            minField.type = 'hidden';
            minField.name = 'min_price';
            minField.value = minPrice;
            form.appendChild(minField);
        }
        
        if (maxPrice !== null) {
            const maxField = document.createElement('input');
            maxField.type = 'hidden';
            maxField.name = 'max_price';
            maxField.value = maxPrice;
            form.appendChild(maxField);
        }
        
        // Submit the form
        document.body.appendChild(form);
        form.submit();
    }
    
    // Event listeners for filter changes
    if (searchBtn) {
        searchBtn.addEventListener('click', applyFilters);
    }
    
    // Add event listeners for dropdown filters to apply filters on change
    if (sortSelect) {
        sortSelect.addEventListener('change', applyFilters);
    }
    
    if (academicYearSelect) {
        academicYearSelect.addEventListener('change', applyFilters);
    }
    
    if (subjectSelect) {
        subjectSelect.addEventListener('change', applyFilters);
    }
    
    // For price inputs, apply filters when user presses Enter
    if (minPriceInput) {
        minPriceInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault(); // Prevent form submission
                applyFilters(); // Apply filters directly
            }
        });
    }
    
    if (maxPriceInput) {
        maxPriceInput.addEventListener('keypress', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault(); // Prevent form submission
                applyFilters(); // Apply filters directly
            }
        });
    }
    
    // Allow only numbers in price inputs
    function allowOnlyNumbers(input) {
        input.addEventListener('input', function() {
            this.value = this.value.replace(/[^0-9.]/g, '');
        });
    }
    
    if (minPriceInput) allowOnlyNumbers(minPriceInput);
    if (maxPriceInput) allowOnlyNumbers(maxPriceInput);
    
    // Reset filters
    if (resetBtn) {
        resetBtn.addEventListener('click', function() {
            // Reset all form fields
            if (searchInput) searchInput.value = '';
            if (sortSelect) sortSelect.selectedIndex = 0;
            if (academicYearSelect) academicYearSelect.selectedIndex = 0;
            if (subjectSelect) subjectSelect.selectedIndex = 0;
            
            if (minPriceInput) minPriceInput.value = '';
            if (maxPriceInput) maxPriceInput.value = '';
            
            // Apply filters with reset values
            applyFilters();
        });
    }
});
