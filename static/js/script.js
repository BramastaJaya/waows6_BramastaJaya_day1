const API_BASE_URL = "http://127.0.0.1:5000/api/auth";


function togglePassword(inputId) {
    const passwordInput = document.getElementById(inputId);
    const toggleButton = passwordInput.nextElementSibling;
    const hideText = toggleButton.querySelector('.hide-text');

    if (passwordInput.type === 'password') {
        passwordInput.type = 'text';
        hideText.textContent = 'Show';
    } else {
        passwordInput.type = 'password';
        hideText.textContent = 'Hide';
    }
}


function validateEmail(email) {
    const re = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    return re.test(email);
}


function validatePassword(password) {
    return password.length >= 6;
}


async function handleLogin(e) {

    e.preventDefault();

    const email = document.getElementById('email').value.trim();
    const password = document.getElementById('password').value;

    if (!validateEmail(email)) {
        showError("Invalid email format, please insert valid email");
        return;
    }

    const loginData = {
        Email: email,
        Password: password
    };

    try {
        const response = await fetch(`${API_BASE_URL}/login`, {
            method: "POST",
            headers: {
                "Content-Type": "application/json"
            },
            body: JSON.stringify(loginData)
        });

        const data = await response.json();

        if (!response.ok || !data.success) {
            showError(data.error || "Login failed, try again");
            return;
        }

        localStorage.setItem("user", JSON.stringify(data));
        showSuccess("Login Successfull, Please wait...");

        setTimeout(() => {
            if (data.RoleId === 1) {
                window.location.href = "/admin";
            } else {
                window.location.href = "/admin/customers";
            }
        }, 1200);

    } catch (error) {
        showError("Error in server-side, please try again later");
        console.error("Login error: ", error);
    }
}


async function handleRegister(e) {
    e.preventDefault();

    
    const name = document.getElementById('profileName').value;
    const email = document.getElementById('registerEmail').value;
    const password = document.getElementById('registerPassword').value;
    const gender = document.querySelector('input[name="gender"]:checked')?.value;
    const month = document.getElementById('month').value;
    const day = document.getElementById('day').value;
    const year = document.getElementById('year').value;

    if (!validateEmail(email)) return showError("Invalid email");
    if (!validatePassword(password)) return showError("Weak password");
    if (!gender) return showError("Select gender");
    if (!month || !day || !year) return showError("Select full date");

    const registerData = {
        Name: name,
        Email: email,
        Password: password,
        Gender: gender,
        DateofBirth: `${year}-${month}-${day}`
    };

    try {
        const response = await fetch(`${API_BASE_URL}/register`, {
            method: "POST",
            headers: {"Content-Type": "application/json"},
            body: JSON.stringify(registerData)
        });

        const data = await response.json();

        if (!response.ok) return showError(data.error || "Register failed");

        showSuccess("Registration successful!");

        setTimeout(() => {
            window.location.href = "/auth/login";
        }, 1500);

    } catch (err) {
        showError("Backend error");
        console.error(err);
    }
}


function showError(message) {
    alert(message);
}

function showSuccess(message) {
    alert(message);
}

document.addEventListener("DOMContentLoaded", () => {
    const loginForm = document.getElementById("loginForm");
    if (loginForm) loginForm.addEventListener("submit", handleLogin);

    const registerForm = document.getElementById("registerForm");
    if (registerForm) registerForm.addEventListener("submit", handleRegister);
});
