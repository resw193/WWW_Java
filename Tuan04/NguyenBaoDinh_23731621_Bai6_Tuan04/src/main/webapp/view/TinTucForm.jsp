<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Thêm tin tức</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/style.css">
</head>

<body>
    <div class="container">
        <h1>QUẢN LÝ TIN TỨC</h1>

        <div class="menu">
            <a href="${pageContext.request.contextPath}/danhsachtintuc">Danh sách tin</a>

            |

            <a href="${pageContext.request.contextPath}/tintuc-form">Thêm tin</a>

            |

            <a href="${pageContext.request.contextPath}/quanly">Quản lý tin</a>
        </div>

        <hr>

        <h2>Thêm tin tức</h2>
        <c:if test="${not empty errors}">
            <div class="error">
                <c:forEach var="error" items="${errors}">
                    <p>${error}</p>
                </c:forEach>
            </div>
        </c:if>

        <form action="${pageContext.request.contextPath}/tintuc-form" method="post">
            <div class="form-row">
                <label>Tiêu đề:</label>
                <input type="text" name="tieuDe" value="${tieuDe}" required>
            </div>

            <div class="form-row">
                <label>Nội dung:</label>
                <textarea name="noiDungTT" rows="5" maxlength="255" required>${noiDungTT}</textarea>

            </div>

            <div class="form-row">
                <label>Liên kết:</label>
                <input type="text" name="lienKet" value="${lienKet}" placeholder="https://..." required>
            </div>


            <div class="form-row">
                <label>Danh mục:</label>
                <select name="maDM" required>
                    <option value="">-- Chọn danh mục --</option>

                    <c:forEach var="dm" items="${danhMucs}">
                        <c:choose>
                            <c:when test="${maDM == dm.maDM}">
                                <option value="${dm.maDM}" selected>
                                        ${dm.tenDanhMuc}
                                </option>
                            </c:when>

                            <c:otherwise>
                                <option value="${dm.maDM}">${dm.tenDanhMuc}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
            </div>

            <br>

            <input type="submit" value="Thêm">

            <a href="${pageContext.request.contextPath}/danhsachtintuc">Quay lại</a>
        </form>
    </div>
</body>
</html>