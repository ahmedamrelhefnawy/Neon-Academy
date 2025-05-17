// Email Address Checker
const emailInput = document.getElementById("emailAddress");
const emailAddressLabel = document.querySelector(".email-address-label");

emailInput.addEventListener("change", isValidEmail);

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
// Email Address Checker End

// Forgot Password Form Validation
const form = document.querySelector("form#forgotPasswordForm");
const submitButton = document.querySelector(".forgot-password-submit-btn");

function forgotPasswordForm(event) {
    event.preventDefault();

    const isEmailValid = isValidEmail();

    if (!isEmailValid) {
        emailAddressLabel.classList.add("error");
    }  
    else {
        emailAddressLabel.classList.remove("error");
        form.submit();
    }
}

submitButton.addEventListener("click", forgotPasswordForm);
// Forgot Password Form Validation End