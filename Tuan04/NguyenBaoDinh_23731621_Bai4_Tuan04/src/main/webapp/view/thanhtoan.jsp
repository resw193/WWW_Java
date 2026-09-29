<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<fmt:formatNumber value="${sessionScope.cart.total}" type="number" var="formattedTotal"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Checkout</title>

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
            min-height: 500px;
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

        .checkout-title {
            text-align: center;
            font-size: 16px;
        }

        .checkout-table {
            width: 100%;
            border-collapse: collapse;
        }

        .checkout-table td {
            border: 1px solid #999;
            padding: 10px;
        }

        .text-input {
            width: 400px;
            padding: 6px;
        }

        .error {
            background-color: #f2dede;
            color: #a94442;
            border: 1px solid #ebcccc;
            padding: 10px;
            margin-bottom: 15px;
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

            <div class="checkout-title">Checkout - Already registered?</div>

            <c:if test="${not empty error}">
                <div class="error">${error}</div>
            </c:if>

            <form action="${pageContext.request.contextPath}/checkout" method="post">

                <table class="checkout-table">

                    <tr>
                        <td style="width: 180px;">Fullname:</td>
                        <td><input type="text" name="fullName" value="${param.fullName}" class="text-input" required></td>
                    </tr>

                    <tr>
                        <td>Shipping address:</td>
                        <td><input type="text" name="shippingAddress" value="${param.shippingAddress}" class="text-input" required></td>
                    </tr>

                    <tr>
                        <td>Total price:</td>
                        <td><input type="text" value="${formattedTotal} VNĐ" class="text-input" readonly></td>
                    </tr>

                    <tr>
                        <td>Payment method:</td>

                        <td>
                            <label><input type="radio" name="paymentMethod" value="Paypal" ${param.paymentMethod == 'Paypal' ? 'checked' : ''} required> Paypal</label>

                            <label><input type="radio" name="paymentMethod" value="ATM Debit" ${param.paymentMethod == 'ATM Debit' ? 'checked' : ''}> ATM Debit</label>

                            <label><input type="radio" name="paymentMethod" value="Visa/Master Card" ${param.paymentMethod == 'Visa/Master Card' ? 'checked' : ''}> Visa/Master card</label>
                        </td>
                    </tr>

                    <tr>
                        <td colspan="2" style="text-align: center;">
                            <input type="submit" value="Save">
                            <a href="${pageContext.request.contextPath}/cart" class="btn btn-light btn-sm border">Cancel</a>
                        </td>
                    </tr>
                </table>
            </form>
        </div>
    </div>

</div>

</body>
</html>