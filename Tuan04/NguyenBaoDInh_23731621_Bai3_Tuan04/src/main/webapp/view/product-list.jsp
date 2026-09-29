<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Product List</title>

    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 30px;
            background-color: #f5f5f5;
        }

        h1 {
            text-align: center;
            margin-bottom: 30px;
        }

        .cart-link {
            max-width: 1200px;
            margin: 0 auto 20px auto;
        }

        .product-list {
            display: grid;
            grid-template-columns: repeat(4, 1fr);
            gap: 20px;
            max-width: 1200px;
            margin: 0 auto;
        }

        .product-class {
            background-color: white;
            border: 1px solid #ddd;
            border-radius: 10px;
            padding: 15px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0, 0, 0, 0.1);
        }

        .product-name {
            font-size: 20px;
            font-weight: bold;
            margin-bottom: 10px;
        }

        .hinh {
            width: 180px;
            height: 180px;
            object-fit: contain;
            display: block;
            margin: 10px auto;
        }

        .description {
            margin-top: 10px;
        }

        .stock {
            margin-top: 8px;
        }

        .price {
            color: red;
            font-weight: bold;
            margin: 10px 0;
        }

        .quantity {
            width: 60px;
            padding: 5px;
            text-align: center;
        }

        .btn-add {
            margin-top: 10px;
            padding: 8px 15px;
            cursor: pointer;
        }

        .detail {
            display: inline-block;
            margin-top: 10px;
        }

        @media (max-width: 900px) {
            .product-list {
                grid-template-columns: repeat(2, 1fr);
            }
        }

        @media (max-width: 500px) {
            .product-list {
                grid-template-columns: 1fr;
            }
        }
    </style>
</head>

<body>

    <h1>Product List</h1>

    <div class="cart-link">
        <a href="${pageContext.request.contextPath}/cart">View Cart</a>
    </div>

    <div class="product-list">
        <c:forEach items="${products}" var="p">

            <div class="product-class">
                <div class="product-name">${p.model}</div>

                <img src="${pageContext.request.contextPath}/images/${p.imgURL}" class="hinh" alt="${p.model}">
                <div class="description">Description: ${p.description}</div>
                <div class="stock">Stock: ${p.quantity}</div>
                <div class="price">Price: ${p.price}</div>

                <form action="${pageContext.request.contextPath}/cart" method="post">
                    <label>Quantity:</label>
                    <input type="number" name="quantity" value="1" min="1" max="${p.quantity}" class="quantity">
                    <input type="hidden" name="id" value="${p.id}">
                    <input type="hidden" name="action" value="add">
                    <br>
                    <input type="submit" value="Add To Cart" class="btn-add">
                </form>

                <a class="detail" href="${pageContext.request.contextPath}/product?id=${p.id}">Product Detail</a>
            </div>

        </c:forEach>

    </div>
</body>
</html>