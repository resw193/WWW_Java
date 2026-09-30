<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product Detail</title>

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
            min-height: 550px;
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

        .detail-layout {
            display: flex;
            gap: 35px;
            margin-top: 20px;
        }

        .product-image {
            width: 230px;
            height: 320px;
            object-fit: contain;
        }

        .product-information {
            flex: 1;
        }

        .quantity-input {
            width: 70px;
            padding: 5px;
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
                    <input type="text" name="keyword" class="search-box">
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

            <c:if test="${not empty product}">

                <div>Product details: ${product.title} - Tác giả: ${product.author}</div>

                <div class="detail-layout">

                    <div>
                        <img src="${pageContext.request.contextPath}/images/${product.imgURL}" class="product-image" alt="${product.title}">
                    </div>

                    <div class="product-information">
                        <p><strong>ID:</strong> ${product.id}</p>
                        <p><strong>Title:</strong> ${product.title}</p>
                        <p><strong>Author:</strong> ${product.author}</p>
                        <p><strong>Description:</strong> ${product.description}</p>
                        <p><strong>Price:</strong> <fmt:formatNumber value="${product.price}" type="number"/> VNĐ</p>
                        <p><strong>Quantity:</strong> ${product.quantity}</p>

                        <c:if test="${product.quantity > 0}">
                            <form action="${pageContext.request.contextPath}/cart" method="post">
                                <input type="hidden" name="action" value="add">
                                <input type="hidden" name="id" value="${product.id}">

                                <label>Quantity:</label>
                                <input type="number" name="quantity" value="1" min="1" max="${product.quantity}" class="quantity-input">

                                <button type="submit" class="btn btn-secondary btn-sm">Add to cart</button>
                            </form>
                        </c:if>

                        <br>

                        <a href="${pageContext.request.contextPath}/products">Back to Product List</a>
                    </div>
                </div>
            </c:if>
        </div>

    </div>
</div>

</body>
</html>