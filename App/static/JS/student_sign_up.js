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
        return true;
    }
    else {
        return false;
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

// Academic Year Selector
window.addEventListener("DOMContentLoaded", function () {
    const academicYearSelect = document.getElementById("academicYear");

    if (academicYearSelect) {
        populateAcademicYears();
    }

    function populateAcademicYears() {
        academicYearSelect.innerHTML = "";
        const years = [
            { label: "Year 1", value: "1" },
            { label: "Year 2", value: "2" },
            { label: "Year 3", value: "3" }
        ];
        years.forEach(year => {
            const option = document.createElement("option");
            option.value = year.value;
            option.textContent = year.label;
            academicYearSelect.appendChild(option);
        });
    }
});
// Academic Year Selector End

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
    if(password === passwordConfirmation && passwordConfirmation !== "") {
        return true;
    }
    else {
        return false;
    }
}
// Password Confirmation Checker End

// Student Sign Up Form Validation
const form = document.querySelector("form#studentSignupForm");
const submitButton = document.querySelector(".student-sign-up-submit-btn");
const firstNameLabel = document.querySelector(".first-name-label");
const lastNameLabel = document.querySelector(".last-name-label");
const emailLabel = document.querySelector(".email-label");
const phoneLabel = document.querySelector(".phone-label");
const passwordLabel = document.querySelector(".password-label");
const passwordConfirmationLabel = document.querySelector(".password-confirmation-label");

function validateStudentSignUpForm(event) {
    event.preventDefault();

    const isEmailValid = isValidEmail();
    const isFirstNameValid = isValidFirstName();
    const isLastNameValid = isValidLastName();
    const isPhoneNumberValid = isValidPhoneNumber();
    const isPasswordValid = passwordChecker();
    const isPasswordConfirmationValid = passwordConfirmationChecker();

    if (!isEmailValid) {
        emailLabel.classList.add("error");
    }
    else {
        emailLabel.classList.remove("error");
    }
    if (!isFirstNameValid) {
        firstNameLabel.classList.add("error");
    }
    else {
        firstNameLabel.classList.remove("error");
    }
    if (!isLastNameValid) {
        lastNameLabel.classList.add("error");
    }
    else {
        lastNameLabel.classList.remove("error");
    }
    if (!isPhoneNumberValid) {
        phoneLabel.classList.add("error");
    }  
    else {
        phoneLabel.classList.remove("error");
    }
    if (!isPasswordValid && passwordInput.value == "") {
        passwordLabel.classList.add("error");
    }  
    else {
        passwordLabel.classList.remove("error");
    }
    if (!isPasswordConfirmationValid) {
        passwordConfirmationLabel.classList.add("error");
    }  
    else {
        passwordConfirmationLabel.classList.remove("error");
    }
    if (isEmailValid && isFirstNameValid && isLastNameValid && isPhoneNumberValid && isPasswordValid && isPasswordConfirmationValid) {
        form.submit();
    }
}

submitButton.addEventListener("click", validateStudentSignUpForm);
// Student Sign Up Form Validation End