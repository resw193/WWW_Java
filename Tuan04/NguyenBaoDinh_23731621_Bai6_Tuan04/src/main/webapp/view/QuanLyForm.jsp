<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Quản lý tin tức</title>
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

        <h2>Quản lý tin tức</h2>
        <c:if test="${param.success == 'delete'}">
            <p class="success">Xóa tin tức thành công.</p>
        </c:if>

        <table>
            <tr>
                <th>Mã TT</th>
                <th>Tiêu đề</th>
                <th>Danh mục</th>
                <th>Chức năng</th>
            </tr>

            <c:forEach var="tin" items="${tinTucs}">
                <tr>
                    <td>${tin.maTT}</td>
                    <td>${tin.tieuDe}</td>
                    <td>
                        <c:forEach var="dm" items="${danhMucs}">
                            <c:if test="${dm.maDM == tin.maDM}">
                                ${dm.tenDanhMuc}
                            </c:if>
                        </c:forEach>
                    </td>
                    <td>
                        <a href="${pageContext.request.contextPath}/quanly?action=delete&id=${tin.maTT}" onclick="return confirm('Bạn có chắc muốn xóa tin này?')">
                            Xóa
                        </a>
                    </td>
                </tr>
            </c:forEach>
        </table>
    </div>
</body>
</html>