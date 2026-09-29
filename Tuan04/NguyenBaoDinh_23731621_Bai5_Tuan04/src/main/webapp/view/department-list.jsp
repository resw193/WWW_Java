<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Departments List</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        .main-container {
            width: 900px;
            margin: 25px auto;
            border: 1px solid #1684c2;
        }

        .banner {
            width: 100%;
            height: 190px;
            object-fit: cover;
        }

        .content {
            padding: 10px;
        }

        .title {
            font-size: 30px;
            margin: 0;
        }

        .search-area {
            margin-bottom: 15px;
        }

        .search-input {
            width: 300px;
            display: inline-block;
        }

        .department-table th {
            font-weight: bold;
        }
    </style>
</head>

<body>

    <div class="main-container">
        <img src="${pageContext.request.contextPath}/images/HRbanner.jpg" class="banner">

        <div class="content">
            <h2 class="title">Departments List</h2>
            <a href="${pageContext.request.contextPath}/departments?action=new">Add Department</a>

            <form action="${pageContext.request.contextPath}/departments" method="get" class="search-area">
                <label>Tìm phòng ban:</label>
                <input type="text" name="keyword" value="${keyword}" class="form-control form-control-sm search-input">
                <input type="submit" value="Search" class="btn btn-light btn-sm border">
            </form>

            <c:if test="${param.error == 'departmentHasEmployees'}">
                <div class="alert alert-danger">Không thể xóa phòng ban vì vẫn còn nhân viên thuộc phòng ban này.</div>
            </c:if>

            <table class="table department-table">

                <thead>
                <tr>
                    <th>DEPT ID</th>
                    <th>Name Department</th>
                    <th>Action</th>
                </tr>
                </thead>

                <tbody>

                <c:forEach var="dep" items="${departments}">
                    <tr>
                        <td>${dep.id}</td>
                        <td>${dep.name}</td>
                        <td>
                            <a href="${pageContext.request.contextPath}/departments?action=edit&id=${dep.id}">Edit</a> |
                            <a href="${pageContext.request.contextPath}/departments?action=delete&id=${dep.id}" onclick="return confirm('Bạn có chắc muốn xóa phòng ban này?')">Delete</a> |
                            <a href="${pageContext.request.contextPath}/employees?action=viewbyid&deptId=${dep.id}">Employees</a>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>