<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>Danh sách tin tức</title>

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

    <h2>Danh sách tin tức</h2>
    <c:if test="${param.success == 'add'}">
        <p class="success">Thêm tin tức thành công.</p>
    </c:if>

    <form action="${pageContext.request.contextPath}/danhsachtintuc"
          method="get">

        <label>Danh mục:</label>

        <select name="maDM">
            <option value="">Tất cả</option>

            <c:forEach var="dm" items="${danhMucs}">

                <c:choose>
                    <c:when test="${currentMaDM == dm.maDM}">
                        <option value="${dm.maDM}" selected>${dm.tenDanhMuc}</option>
                    </c:when>

                    <c:otherwise>
                        <option value="${dm.maDM}">${dm.tenDanhMuc}</option>
                    </c:otherwise>
                </c:choose>

            </c:forEach>
        </select>
        <input type="submit" value="Xem">
    </form>

    <br>

    <table>

        <tr>
            <th>Mã TT</th>
            <th>Tiêu đề</th>
            <th>Nội dung</th>
            <th>Liên kết</th>
            <th>Danh mục</th>
        </tr>

        <c:forEach var="tin" items="${tinTucs}">
            <tr>
                <td>
                        ${tin.maTT}
                </td>

                <td>
                        ${tin.tieuDe}
                </td>

                <td>
                        ${tin.noiDungTT}
                </td>

                <td>
                    <a href="${tin.lienKet}" target="_blank">
                        Xem tin
                    </a>
                </td>

                <td>

                    <c:forEach var="dm" items="${danhMucs}">
                        <c:if test="${dm.maDM == tin.maDM}">
                            ${dm.tenDanhMuc}
                        </c:if>
                    </c:forEach>

                </td>
            </tr>
        </c:forEach>
    </table>
</div>

</body>
</html>