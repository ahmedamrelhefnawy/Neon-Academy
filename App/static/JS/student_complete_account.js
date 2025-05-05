// Authentication File Name Viewer & Checker
const AuthenticationFileInput = document.getElementById("AuthenticationFile");
const customTextLabel = document.getElementById("custom-text");
const authenticationFileLabel = document.querySelector(".authentication-file-label");

AuthenticationFileInput.addEventListener("change", function () {
    if (AuthenticationFileInput.files.length > 0) {
        const file = AuthenticationFileInput.files[0];
        const fileName = file.name;
        const fileExtension = fileName.split(".").pop().toLowerCase();
        const allowedImageExtensions = ["jpg", "jpeg", "png"];

        if (allowedImageExtensions.includes(fileExtension)) {
            customTextLabel.innerHTML = fileName;
            authenticationFileLabel.classList.remove("error");
        } else {
            AuthenticationFileInput.value = ""; // Reset input
            customTextLabel.innerHTML = "Upload File";
            authenticationFileLabel.classList.add("error");
            alert("Only image files (JPEG, PNG) are allowed.");
        }
    } else {
        customTextLabel.innerHTML = "Upload File";
    }
});

function checkFileName() {
    const fileName = AuthenticationFileInput.value.split("\\").pop();
    const fileExtension = fileName.split(".").pop().toLowerCase();
    const allowedImageExtensions = ["jpg", "jpeg", "png"];

    return allowedImageExtensions.includes(fileExtension) && fileName !== "Upload File";
}
// Authentication File Name Viewer & Checker End

// Student Complete Account Form Validation
const form = document.querySelector("form#studentCompleteAccount");
const submitButton = document.querySelector(".student-complete-account-submit-btn");

function validateStudentCompleteAccountForm(event) {
    event.preventDefault();

    const isFileNameValid = checkFileName();

    if (!isFileNameValid) {
        authenticationFileLabel.classList.add("error");
        alert("Please upload a valid image file.");
    } else {
        authenticationFileLabel.classList.remove("error");
        form.submit();
    }
}

submitButton.addEventListener("click", validateStudentCompleteAccountForm);
