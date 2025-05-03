// email checker
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
// email checker end

// Password Checker
const passwordInput = document.querySelector(".password");

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
    return hasLowercase && hasUppercase && hasNumber && hasSpecialCharacter;
}

passwordInput.addEventListener("input", passwordChecker);
// Password Checker end

// Sign In Form Validation
const signInForm = document.querySelector("form#signInForm");
const signInSubmitButton = document.querySelector(".sign-in-submit-btn");
const emailLabel = document.querySelector(".email-label");
const passwordLabel = document.querySelector(".password-label");

function validateSignInForm(event) {
    event.preventDefault();

    const isEmailValid = emailChecker();
    const isPasswordValid = passwordChecker();

    if (!isEmailValid) {
        emailLabel.classList.add("error");
    }
    else {
        emailLabel.classList.remove("error");
    }
    if (!isPasswordValid) {
        passwordLabel.classList.add("error");
    }  
    else {
        passwordLabel.classList.remove("error");
    }
    if (isEmailValid && isPasswordValid) {
        signInForm.submit();
    }
}

signInSubmitButton.addEventListener("click", validateSignInForm);
// Sign In Form Validation End