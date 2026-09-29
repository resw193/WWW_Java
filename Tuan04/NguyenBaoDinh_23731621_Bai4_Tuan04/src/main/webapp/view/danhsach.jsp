<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>IUH Bookstore</title>

    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.8/dist/css/bootstrap.min.css" rel="stylesheet">

    <style>
        body {
            margin: 0;
            background-color: #f5f5f5;
            font-family: Arial, sans-serif;
        }

        .container-page {
            width: 1100px;
            margin: 25px auto;
            background-color: white;
            border: 1px solid #999;
        }

        .header {
            background: linear-gradient(to right, #8e7c69, #c6b49d);
            padding: 15px 20px;
            border-bottom: 6px solid #15576b;
        }

        .header-content {
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .logo {
            color: white;
            font-size: 28px;
            font-weight: bold;
            text-shadow: 1px 1px 2px #555;
        }

        .menu {
            display: flex;
            gap: 8px;
        }

        .menu-item {
            background-color: #706d65;
            color: white;
            text-decoration: none;
            padding: 8px 14px;
            font-size: 13px;
        }

        .menu-item:hover {
            background-color: #555;
            color: white;
        }

        .content {
            display: flex;
        }

        .sidebar {
            width: 250px;
            min-height: 650px;
            padding: 20px;
            border-right: 1px solid #ddd;
            background-color: #fafafa;
        }

        .sidebar-section {
            margin-bottom: 35px;
        }

        .sidebar-title {
            color: #888;
            font-size: 18px;
            margin-bottom: 12px;
        }

        .search-box {
            width: 100%;
            padding: 7px;
        }

        .main-content {
            flex: 1;
            padding: 20px;
        }

        .product-list {
            display: grid;
            grid-template-columns: repeat(3, 1fr);
            gap: 15px;
        }

        .product-card {
            border: 1px solid #777;
            padding: 10px;
            text-align: center;
            background-color: white;
        }

        .product-title {
            min-height: 45px;
            font-size: 14px;
        }

        .product-image {
            width: 140px;
            height: 200px;
            object-fit: contain;
            margin: 10px auto;
            display: block;
        }

        .product-info {
            margin: 4px 0;
        }

        .detail-link {
            display: block;
            margin-top: 5px;
        }

        .add-button {
            border: none;
            background: none;
            color: #0d6efd;
            text-decoration: underline;
            cursor: pointer;
            padding: 0;
        }

        @media (max-width: 900px) {
            .container-page {
                width: 95%;
            }

            .product-list {
                grid-template-columns: repeat(2, 1fr);
            }
        }
    </style>
</head>

<body>

<div class="container-page">

    <div class="header">
        <div class="header-content">
            <div class="logo">IUH BOOKSTORE</div>

            <div class="menu">
                <a href="${pageContext.request.contextPath}/products" class="menu-item">HOME</a>
                <a href="#" class="menu-item">EXAMPLES</a>
                <a href="#" class="menu-item">SERVICES</a>
                <a href="${pageContext.request.contextPath}/products" class="menu-item">PRODUCTS</a>
                <a href="#" class="menu-item">CONTACT</a>
            </div>
        </div>
    </div>

    <div class="content">

        <div class="sidebar">

            <div class="sidebar-section">
                <div class="sidebar-title">ABOUT US</div>
                <p>About us information will be here...</p>
                <a href="#">Read More »</a>
            </div>

            <div class="sidebar-section">
                <div class="sidebar-title">SEARCH SITE</div>

                <form action="${pageContext.request.contextPath}/products" method="get">
                    <input type="text" name="keyword" value="${param.keyword}" class="search-box">
                </form>
            </div>

            <div class="sidebar-section">
                <c:set var="cartCount" value="0"/>

                <c:if test="${not empty sessionScope.cart}">
                    <c:set var="cartCount" value="${sessionScope.cart.itemCount}"/>
                </c:if>

                <a href="${pageContext.request.contextPath}/cart">Shopping cart (${cartCount})</a>
            </div>

        </div>

        <div class="main-content">

            <c:if test="${not empty keyword}">
                <h5>Kết quả tìm kiếm: "${keyword}"</h5>
                <br>
            </c:if>

            <c:if test="${empty products}">
                <div class="alert alert-warning">Không tìm thấy sách phù hợp.</div>
            </c:if>

            <div class="product-list">

                <c:forEach items="${products}" var="p">

                    <div class="product-card">

                        <div class="product-title">${p.title} - Tác giả: ${p.author}</div>

                        <img src="${pageContext.request.contextPath}/images/${p.imgURL}" class="product-image" alt="${p.title}">

                        <div class="product-info">Price: <fmt:formatNumber value="${p.price}" type="number"/> VNĐ</div>

                        <div class="product-info">Quantity: ${p.quantity}</div>

                        <a href="${pageContext.request.contextPath}/product?id=${p.id}" class="detail-link">Product details</a>

                        <c:choose>
                            <c:when test="${p.quantity > 0}">
                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="id" value="${p.id}">
                                    <input type="hidden" name="quantity" value="1">
                                    <button type="submit" class="add-button">Add to cart</button>
                                </form>
                            </c:when>

                            <c:otherwise>
                                <span class="text-danger">Out of stock</span>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </c:forEach>
            </div>
        </div>
    </div>
</div>

</body>
</html>