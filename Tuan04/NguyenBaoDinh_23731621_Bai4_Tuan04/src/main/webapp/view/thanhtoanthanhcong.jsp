<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Thanh toán thành công</title>

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

        .success {
            padding: 12px;
            background-color: #dff0d8;
            color: #3c763d;
            border: 1px solid #b2dba1;
            margin-bottom: 20px;
        }

        .order-table {
            width: 100%;
            border-collapse: collapse;
        }

        .order-table th,
        .order-table td {
            border: 1px solid #aaa;
            padding: 8px;
        }

        .order-table th {
            background-color: #34495e;
            color: white;
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

            <div class="success">
                <strong>Thanh toán thành công!</strong>
            </div>

            <h4>Thông tin đơn hàng</h4>
            <div>
                <p><strong>Full name:</strong> ${order.fullName}</p>
                <p><strong>Shipping address:</strong> ${order.shippingAddress}</p>
                <p><strong>Payment method:</strong> ${order.paymentMethod}</p>
            </div>

            <h4>Danh sách sản phẩm đã mua</h4>
            <table class="order-table">

                <tr>
                    <th>Product ID</th>
                    <th>Book</th>
                    <th>Author</th>
                    <th>Price</th>
                    <th>Quantity</th>
                    <th>Subtotal</th>
                </tr>

                <c:forEach var="item" items="${order.items}">
                    <tr>
                        <td>${item.product.id}</td>
                        <td>${item.product.title}</td>
                        <td>${item.product.author}</td>
                        <td><fmt:formatNumber value="${item.price}" type="number"/> VNĐ</td>
                        <td>${item.quantity}</td>
                        <td><fmt:formatNumber value="${item.subtotal}" type="number"/> VNĐ</td>
                    </tr>
                </c:forEach>

                <tr>
                    <td colspan="5" style="text-align: right;"><strong>Total price:</strong></td>
                    <td><strong><fmt:formatNumber value="${order.totalPrice}" type="number"/> VNĐ</strong></td>
                </tr>

            </table>

            <br>

            <a href="${pageContext.request.contextPath}/products" class="btn btn-secondary">Continue shopping</a>

        </div>

    </div>

</div>

</body>
</html>