package com.iuh.fit.nguyenbaodinh_23731621_tuan2.web;

import com.iuh.fit.nguyenbaodinh_23731621_tuan2.service.AuthenticationService;
import com.iuh.fit.nguyenbaodinh_23731621_tuan2.session.UserSession;
import jakarta.inject.Inject;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Inject
    private AuthenticationService authenticationService;
    @Inject
    private UserSession userSession;
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (userSession.isLoggedIn()) {
            response.sendRedirect(request.getContextPath() + "/products");
            return;
        }

        // Dang nhap ko dung'
        request.getRequestDispatcher("/view/login.jsp").forward(request, response);
    }
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Ko thanh cong
        if (!authenticationService.authenticate(username, password)) {
            request.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/view/login.jsp").forward(request, response);
            return;
        }

        // Dang nhap thanh cong
        userSession.login(username);
        response.sendRedirect(request.getContextPath() + "/products");
    }
}
