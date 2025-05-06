// Password Checker
const passwordInput = document.querySelector(".password");
const dotSpan = document.querySelectorAll(".hollow-dot, .solid-dot");

const specialCharacters = "!@#$%^&*()_+[]{}|;:,.<>?".split('');
const lowercaseLetters = "abcdefghijklmnopqrstuvwxyz".split('');
const uppercaseLetters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ".split('');
const numbers = "0123456789".split('');


function passwordChecker() {
    let password = passwordInput.value,
        hasUppercase = false,
        hasLowercase = false,
        hasNumber = false,
        hasSpecialCharacter = false;
    password.split('').forEach(character => {
        if(lowercaseLetters.includes(character)) {
            hasLowercase = true;
        }
        else if(uppercaseLetters.includes(character)) {
            hasUppercase = true;
        }
        else if(numbers.includes(character)) {
            hasNumber = true;
        }
        else if(specialCharacters.includes(character)) {
            hasSpecialCharacter = true;
        }
    });
    if(hasLowercase && hasUppercase) {
        dotSpan[0].classList.add("solid-dot");
        dotSpan[0].classList.remove("hollow-dot");
    }
    else {
        dotSpan[0].classList.remove("solid-dot");
        dotSpan[0].classList.add("hollow-dot");
    }
    if(hasSpecialCharacter) {
        dotSpan[1].classList.add("solid-dot");
        dotSpan[1].classList.remove("hollow-dot");
    }
    else {
        dotSpan[1].classList.remove("solid-dot");
        dotSpan[1].classList.add("hollow-dot");
    }
    if(hasNumber) {
        dotSpan[2].classList.add("solid-dot");
        dotSpan[2].classList.remove("hollow-dot");
    }
    else {
        dotSpan[2].classList.remove("solid-dot");
        dotSpan[2].classList.add("hollow-dot");
    }
    return hasLowercase && hasUppercase && hasNumber && hasSpecialCharacter;
}

passwordInput.addEventListener("input", passwordChecker);
// Password Checker End

// Email Checker
const emailInput = document.querySelector(".email");

function isValidEmail() {
    const emailRegex = /^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$/;
    let email = emailInput.value;
    if(emailRegex.test(email)) {
        return true;
    }
    else {
        return false;
    }
}

emailInput.addEventListener("input", isValidEmail);
// Email Checker End

// First Name Checker
const firstNameInput = document.querySelector(".first-name");
const firstNameRegex = /^[a-zA-Z]+$/;

function isValidFirstName() {
    let firstName = firstNameInput.value;
    if(firstNameRegex.test(firstName)) {
        return true;
    }
    else {
        return false;
    }
}

firstNameInput.addEventListener("input", isValidFirstName);
// First Name Checker End

// Last Name Checker
const lastNameInput = document.querySelector(".last-name");
const lastNameRegex = /^[a-zA-Z]+$/;

function isValidLastName() {
    let lastName = lastNameInput.value;
    if(lastNameRegex.test(lastName)) {
        console.log("Valid Last Name");
    }
    else {
        console.log("Invalid Last Name");
    }
}

lastNameInput.addEventListener("input", isValidLastName);
// Last Name Checker End

// Date of Birth Selector
window.onload = function() {
    const daySelect = document.getElementById("day");
    const monthSelect = document.getElementById("month");
    const yearSelect = document.getElementById("year");

    populateYears();

    monthSelect.addEventListener("change", updateDays);
    yearSelect.addEventListener("change", updateDays);

    updateDays();

    function populateYears() {
        const currentYear = new Date().getFullYear();
        const startYear = currentYear - 100;
        const endYear = currentYear;

        yearSelect.innerHTML = '';

        for (let i = startYear; i <= endYear; i++) {
            const option = document.createElement("option");
            option.value = i;
            option.textContent = i;
            yearSelect.appendChild(option);
        }
    }

    function updateDays() {
        const selectedMonth = parseInt(monthSelect.value);
        const selectedYear = parseInt(yearSelect.value);

        daySelect.innerHTML = '';

        if (selectedMonth && selectedYear) {
            const daysInMonth = getDaysInMonth(selectedYear, selectedMonth);

            for (let i = 1; i <= daysInMonth; i++) {
                const option = document.createElement("option");
                option.value = i;
                option.textContent = i;
                daySelect.appendChild(option);
            }
        }
    }

    function getDaysInMonth(year, month) {
        return new Date(year, month, 0).getDate();
    }
};
// Date of Birth Selector End

// Phone Number Checker (Egypt Only for now)
const phoneInput = document.querySelector(".phone-number");
const phoneRegex = /^01[0-2,5]\d{8}$/;

function isValidPhoneNumber() {
    let phoneNumber = phoneInput.value;
    if(phoneRegex.test(phoneNumber)) {
        return true;
    }
    else {
        return false;
    }
}
// Phone Number Checker End

// Password Confirmation Checker
const passwordConfirmationInput = document.querySelector(".password-confirmation");

function passwordConfirmationChecker() {
    let password = passwordInput.value,
        passwordConfirmation = passwordConfirmationInput.value;
    if(password === passwordConfirmation) {
        return true;
    }
    else {
        return false;
    }
}
// Password Confirmation Checker End

// Profile Picture File Name Viewer
const profilePictureInput = document.getElementById("profilePicture");
const customTextLabel = document.getElementById("custom-text");

profilePictureInput.addEventListener("change", function() {
    if (profilePictureInput.files.length > 0) {
        customTextLabel.innerHTML = profilePictureInput.files[0].name;
    } else {
        customTextLabel.innerHTML = "Upload File";
    }
});
// Profile Picture File Name Viewer End

// Form Validation
// const form = document.querySelector("form");
// const submitButton = document.querySelector(".submit-button");
// const errorMessage = document.querySelector(".error-message");
// const successMessage = document.querySelector(".success-message");

// function validateForm(event) {
//     event.preventDefault();

//     const isEmailValid = isValidEmail();
//     const isFirstNameValid = isValidFirstName();
//     const isLastNameValid = isValidLastName();
//     const isPhoneNumberValid = isValidPhoneNumber();
//     const isPasswordValid = passwordChecker();
//     const isPasswordConfirmationValid = passwordConfirmationChecker();

//     if (!isEmailValid) {
//         alert("Please enter a valid email address.");
//     }
//     if (!isFirstNameValid) {
//         alert("Please enter a valid first name.");
//     }
//     if (!isLastNameValid) {
//         alert("Please enter a valid last name.");
//     }
//     if (!isPhoneNumberValid) {
//         alert("Please enter a valid phone number.");
//     }
//     if (!isPasswordValid) {
//         alert("Please enter a valid password.");
//     }
//     if (!isPasswordConfirmationValid) {
//         alert("Password confirmation does not match.");
//     }
//     if (isEmailValid && isFirstNameValid && isLastNameValid && isPhoneNumberValid && isPasswordValid && isPasswordConfirmationValid) {
//         form.submit();
//     }
// }

// submitButton.addEventListener("click", validateForm);
// Form Validation End