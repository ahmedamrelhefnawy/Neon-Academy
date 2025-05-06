// Password Checker
const passwordInput = document.querySelector(".new-password-input");
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
const passwordConfirmationInput = document.querySelector(".repeat-password-input");

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
const form = document.querySelector("form#resetPasswordForm");
const submitButton = document.querySelector(".reset-password-submit-btn");
const passwordLabel = document.querySelector(".new-password-label");
const passwordConfirmationLabel = document.querySelector(".repeat-password-label");

function validateResetPasswordForm(event) {
    event.preventDefault();

    const isPasswordValid = passwordChecker();
    const isPasswordConfirmationValid = passwordConfirmationChecker();

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
    if (isPasswordValid && isPasswordConfirmationValid) {
        form.submit();
    }
}

submitButton.addEventListener("click", validateResetPasswordForm);
// Teacher Sign Up Form Validation End