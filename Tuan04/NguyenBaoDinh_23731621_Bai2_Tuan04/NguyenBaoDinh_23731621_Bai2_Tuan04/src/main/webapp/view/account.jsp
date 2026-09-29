<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Danh sách Account</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body class="bg-light">

<div class="container mt-5">
    <div class="card shadow-sm">
        <div class="card-header bg-primary text-white text-center">
            <h3 class="mb-0">Danh sách Tài khoản đã Đăng ký</h3>
        </div>
        <div class="card-body">

            <table class="table table-hover table-bordered text-center align-middle">

                <thead class="table-light">
                    <tr>
                        <th>ID</th>
                        <th>First Name</th>
                        <th>Last Name</th>
                        <th>Email</th>
                        <th>Date of Birth</th>
                    </tr>
                </thead>

                <tbody>
                    <!-- Duyệt qua danh sách 'accounts' được set trong req.setAttribute("accounts", accounts) ở Servlet -->
                    <c:forEach var="acc" items="${accounts}">
                        <tr>
                            <td>${acc.id}</td>
                            <td>${acc.firstName}</td>
                            <td>${acc.lastName}</td>
                            <td>${acc.email}</td>
                            <td>${acc.dateOfBirth}</td>
                        </tr>
                    </c:forEach>

                    <!-- Hiển thị thông báo nếu danh sách trống (tuỳ chọn) -->
                    <c:if test="${empty accounts}">
                        <tr>
                            <td colspan="5" class="text-muted">Chưa có tài khoản nào được đăng ký.</td>
                        </tr>
                    </c:if>
                </tbody>
            </table>

        </div>
    </div>
</div>

</body>
</html>