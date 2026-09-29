<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Shopping Cart</title>

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

        .cart-title {
            text-align: center;
            margin-bottom: 20px;
        }

        .cart-table {
            width: 100%;
            border-collapse: collapse;
        }

        .cart-table th,
        .cart-table td {
            border: 1px solid #aaa;
            padding: 8px;
        }

        .cart-table th {
            background-color: #34495e;
            color: white;
        }

        .quantity-input {
            width: 65px;
        }

        .button-area {
            margin-top: 15px;
        }

        .button-link {
            display: inline-block;
            padding: 6px 12px;
            background-color: #eee;
            border: 1px solid #aaa;
            color: black;
            text-decoration: none;
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

            <h4 class="cart-title">YOUR SHOPPING CART</h4>

            <c:if test="${empty sessionScope.cart or empty sessionScope.cart.items}">
                <p>Cart is empty!</p>
                <a href="${pageContext.request.contextPath}/products" class="button-link">Continue shopping</a>
            </c:if>

            <c:if test="${not empty sessionScope.cart and not empty sessionScope.cart.items}">

                <table class="cart-table">

                    <tr>
                        <th>Product ID</th>
                        <th>Product name</th>
                        <th>Price</th>
                        <th>Qty</th>
                        <th>Total</th>
                        <th>Remove</th>
                    </tr>

                    <c:forEach var="item" items="${sessionScope.cart.items}">

                        <tr>
                            <td>${item.product.id}</td>

                            <td>${item.product.title} - ${item.product.author}</td>

                            <td><fmt:formatNumber value="${item.product.price}" type="number"/></td>

                            <td>
                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="action" value="update">
                                    <input type="hidden" name="productId" value="${item.product.id}">
                                    <input type="number" name="quantity" value="${item.quantity}" min="1" max="${item.product.quantity}" class="quantity-input">
                                    <input type="submit" value="Update">
                                </form>
                            </td>

                            <td><fmt:formatNumber value="${item.subtotal}" type="number"/></td>

                            <td>
                                <form action="${pageContext.request.contextPath}/cart" method="post">
                                    <input type="hidden" name="action" value="remove">
                                    <input type="hidden" name="productId" value="${item.product.id}">
                                    <input type="submit" value="Remove">
                                </form>
                            </td>
                        </tr>

                    </c:forEach>

                    <tr>
                        <td colspan="4" style="text-align: right;"><strong>Total price</strong></td>
                        <td colspan="2"><strong>VNĐ <fmt:formatNumber value="${sessionScope.cart.total}" type="number"/></strong></td>
                    </tr>

                </table>

                <div class="button-area">
                    <a href="${pageContext.request.contextPath}/checkout" class="button-link">Checkout</a>

                    <a href="${pageContext.request.contextPath}/products" class="button-link">Continue shopping</a>

                    <form action="${pageContext.request.contextPath}/cart" method="post" style="display: inline;">
                        <input type="hidden" name="action" value="clear">
                        <input type="submit" value="Clear Cart">
                    </form>
                </div>
            </c:if>
        </div>
    </div>

</div>

</body>
</html>