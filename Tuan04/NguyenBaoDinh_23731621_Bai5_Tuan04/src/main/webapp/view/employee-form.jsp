<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<html>

<head>
    <title>Employee Information</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">
</head>

<body>

    <div class="container">
        <img src="${pageContext.request.contextPath}/images/HRbanner.jpg" height="200px" width="100%">

        <h2>Employee Information</h2>

        <form action="${pageContext.request.contextPath}/employees" method="post">

            <input type="hidden" name="id" value="${employee.id}">

            Name:
            <input type="text" name="name" value="${employee.name}" required>
            <br>

            Salary:
            <input type="number" name="salary" value="${employee.salary}" step="0.01" required>
            <br>

            Department:
            <select name="departmentId">
                <c:forEach var="dep" items="${departments}">

                    <c:choose>
                        <c:when test="${not empty employee and employee.departmentId == dep.id}">
                            <option value="${dep.id}" selected>${dep.name}</option>
                        </c:when>

                        <c:when test="${empty employee and selectedDeptId == dep.id}">
                            <option value="${dep.id}" selected>${dep.name}</option>
                        </c:when>

                        <c:otherwise>
                            <option value="${dep.id}">${dep.name}</option>
                        </c:otherwise>

                    </c:choose>

                </c:forEach>
            </select>
            <br>
            <input type="submit" value="Save">
        </form>
    </div>

</body>

</html>