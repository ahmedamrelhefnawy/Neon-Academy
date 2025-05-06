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

// Teacher Sign Up Form Validation
const form = document.querySelector("form#teacherSignupForm");
const submitButton = document.querySelector(".teacher-sign-up-submit-btn");
const firstNameLabel = document.querySelector(".first-name-label");
const lastNameLabel = document.querySelector(".last-name-label");
const emailLabel = document.querySelector(".email-label");
const phoneLabel = document.querySelector(".phone-label");
const profilePictureLabel = document.querySelector(".profile-picture-label");
const passwordLabel = document.querySelector(".password-label");
const passwordConfirmationLabel = document.querySelector(".password-confirmation-label");

function validateTeacherSignUpForm(event) {
    event.preventDefault();

    const isEmailValid = isValidEmail();
    const isFirstNameValid = isValidFirstName();
    const isLastNameValid = isValidLastName();
    const isPhoneNumberValid = isValidPhoneNumber();
    const isPasswordValid = passwordChecker();
    const isPasswordConfirmationValid = passwordConfirmationChecker();
    const isFileNameValid = checkFileName();

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
    if (!isFileNameValid) {
        profilePictureLabel.classList.add("error");
    }  
    else {
        profilePictureLabel.classList.remove("error");
    }
    if (!isPasswordValid) {
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
    if (isEmailValid && isFirstNameValid && isLastNameValid && isPhoneNumberValid && isPasswordValid && isPasswordConfirmationValid && isFileNameValid) {
        form.submit();
    }
}

submitButton.addEventListener("click", validateTeacherSignUpForm);
// Teacher Sign Up Form Validation End