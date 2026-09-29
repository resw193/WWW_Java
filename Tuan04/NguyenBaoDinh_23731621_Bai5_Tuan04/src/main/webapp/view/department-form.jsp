<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Department Information</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .main-container {
            width: 600px;
            margin: 25px auto;
            border: 1px solid #1684c2;
        }

        .banner {
            width: 100%;
            height: 220px;
            object-fit: cover;
        }

        .content {
            padding: 10px;
        }

        .form-input {
            width: 300px;
            display: inline-block;
        }
    </style>
</head>

<body>
    <div class="main-container">

        <img src="${pageContext.request.contextPath}/images/HRbanner.jpg" class="banner">

        <div class="content">

            <h2>Department Information</h2>

            <form action="${pageContext.request.contextPath}/departments" method="post">
                <input type="hidden" name="id" value="${department.id}">
                <label>Name:</label>
                <input type="text" name="name" value="${department.name}" class="form-control form-control-sm form-input" required>

                <br><br>
                <input type="submit" value="Save" class="btn btn-light btn-sm border">
                <a href="${pageContext.request.contextPath}/departments" class="btn btn-light btn-sm border">Cancel</a>
            </form>
        </div>
    </div>
</body>
</html>