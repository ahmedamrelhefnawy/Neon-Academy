// Authentication File Name Viewer & Checker
const AuthenticationFileInput = document.getElementById("AuthenticationFile");
const customTextLabel = document.getElementById("custom-text");

AuthenticationFileInput.addEventListener("change", function() {
    if (AuthenticationFileInput.files.length > 0) {
        customTextLabel.innerHTML = AuthenticationFileInput.files[0].name;
    } else {
        customTextLabel.innerHTML = "Upload File";
    }
});

function checkFileName() {
    const fileName = AuthenticationFileInput.value.split("\\").pop();
    const fileExtension = fileName.split(".").pop().toLowerCase();
    const allowedExtensions = ["pdf", "doc", "docx"];

    if (allowedExtensions.includes(fileExtension) && fileName !== "Upload File") {
        return true;
    } else {
        return false;
    }
}
// Authentication File Name Viewer & Checker End

// Teacher Complete Account Form Validation
const form = document.querySelector("form#teacherCompleteAccount");
const submitButton = document.querySelector(".teacher-complete-account-submit-btn");
const authenticationFileLabel = document.querySelector(".authentication-file-label");

function validateTeacherCompleteAccountForm(event) {
    event.preventDefault();

    const isFileNameValid = checkFileName();

    if (!isFileNameValid) {
        authenticationFileLabel.classList.add("error");
    }  
    else {
        authenticationFileLabel.classList.remove("error");
        form.submit();
    }
}

submitButton.addEventListener("click", validateTeacherCompleteAccountForm);
// Teacher Complete Account Form Validation End