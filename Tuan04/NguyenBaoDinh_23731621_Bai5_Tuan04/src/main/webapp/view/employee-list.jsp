<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Employees List</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .main-container {
            width: 900px;
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

        .employee-table th {
            background-color: #c5daf8;
        }

        .employee-table td {
            background-color: #dce9fa;
        }
    </style>
</head>

<body>
    <div class="main-container">
        <img src="${pageContext.request.contextPath}/images/HRbanner.jpg" class="banner">

        <div class="content">
            <h2>Employees List</h2>

            <c:if test="${not empty currentDepartment}">
                <p><strong>Department:</strong> ${currentDepartment.name}</p>
            </c:if>

            <c:choose>
                <c:when test="${not empty currentDeptId}">
                    <a href="${pageContext.request.contextPath}/employees?action=new&deptId=${currentDeptId}">Add Employee</a>
                </c:when>

                <c:otherwise>
                    <a href="${pageContext.request.contextPath}/employees?action=new">Add Employee</a>
                </c:otherwise>
            </c:choose>

            <br><br>

            <table class="table employee-table">
                <thead>
                <tr>
                    <th>ID</th>
                    <th>Name Employee</th>
                    <th>Salary</th>
                    <th>Dept</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>

                <c:forEach var="emp" items="${employees}">

                    <tr>
                        <td>${emp.id}</td>
                        <td>${emp.name}</td>
                        <td><fmt:formatNumber value="${emp.salary}" type="number"/></td>
                        <td>${emp.departmentId}</td>

                        <td>
                            <a href="${pageContext.request.contextPath}/employees?action=edit&id=${emp.id}">Edit</a> |
                            <a href="${pageContext.request.contextPath}/employees?action=delete&id=${emp.id}" onclick="return confirm('Bạn có chắc muốn xóa nhân viên này?')">Delete</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
            <a href="${pageContext.request.contextPath}/departments">Department</a>
        </div>
    </div>
</body>
</html>