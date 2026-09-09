package com.iuh.fit.nguyenbaodinh_23731621_tuan2.web;

import com.iuh.fit.nguyenbaodinh_23731621_tuan2.service.ProductCatalog;
import com.iuh.fit.nguyenbaodinh_23731621_tuan2.session.UserSession;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/products")
public class ProductsServlet extends HttpServlet {
    @Inject
    private ProductCatalog productCatalog;
    @Inject
    private UserSession userSession;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (!userSession.isLoggedIn()) {
            response.sendRedirect(request.getContextPath() + "/login");
            return;
        }

        // Login vao thanh cong --> Hien thi toan bo product, thong tin user hien tai
        request.setAttribute("products", productCatalog.findAll());
        request.setAttribute("userSession", userSession);
        request.getRequestDispatcher("/view/products.jsp").forward(request, response);
    }
}
