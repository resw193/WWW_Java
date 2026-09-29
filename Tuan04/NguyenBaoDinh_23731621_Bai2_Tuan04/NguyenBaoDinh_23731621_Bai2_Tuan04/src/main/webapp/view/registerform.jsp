<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Registration Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background-color: #f8f9fa;
        }
        .registration-container {
            background-color: white;
            padding: 30px;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0,0,0,0.1);
            border: 2px solid #28a745;
            max-width: 500px;
            width: 100%;
        }
    </style>
</head>
<body>

<div class="registration-container">
    <h2 class="text-center mb-4">User Registration Form</h2>

    <form action="${pageContext.request.contextPath}/registerform" method="post">

        <div class="row mb-3">
            <div class="col">
                <input type="text" class="form-control" name="firstname" placeholder="First Name" required>
            </div>
            <div class="col">
                <input type="text" class="form-control" name="lastname" placeholder="Last Name" required>
            </div>
        </div>

        <div class="mb-3">
            <input type="email" class="form-control" name="email" placeholder="Your Email" required>
        </div>

        <div class="mb-3">
            <input type="password" class="form-control" name="password" placeholder="Password" required>
        </div>

        <div class="mb-3">
            <label class="form-label">Birthday</label>
            <div class="row">
                <div class="col">
                    <select class="form-select" name="month" required>
                        <option value="" selected disabled>Month</option>
                        <% for(int i=1; i<=12; i++) { %>
                        <option value="<%= i %>"><%= i %></option>
                        <% } %>
                    </select>
                </div>
                <div class="col">
                    <select class="form-select" name="day" required>
                        <option value="" selected disabled>Day</option>
                        <% for(int i=1; i<=31; i++) { %>
                        <option value="<%= i %>"><%= i %></option>
                        <% } %>
                    </select>
                </div>
                <div class="col">
                    <select class="form-select" name="year" required>
                        <option value="" selected disabled>Year</option>
                        <% for(int i=2024; i>=1950; i--) { %>
                        <option value="<%= i %>"><%= i %></option>
                        <% } %>
                    </select>
                </div>
            </div>
        </div>

        <div class="mb-4">
            <label class="form-label d-block">Gender</label>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="gender" id="female" value="Female">
                <label class="form-check-label" for="female">Female</label>
            </div>
            <div class="form-check form-check-inline">
                <input class="form-check-input" type="radio" name="gender" id="male" value="Male">
                <label class="form-check-label" for="male">Male</label>
            </div>
        </div>

        <button type="submit" class="btn btn-primary w-100">Sign Up</button>

    </form>
</div>

</body>
</html>