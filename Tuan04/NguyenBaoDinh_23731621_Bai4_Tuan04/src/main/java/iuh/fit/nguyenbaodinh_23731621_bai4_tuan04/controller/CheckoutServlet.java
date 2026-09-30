package iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.controller;

import iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.model.CartBean;
import iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.model.CartItemBean;
import iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.model.Order;
import iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.model.OrderItem;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/checkout")
public class CheckoutServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        CartBean cart = (CartBean) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/products");
            return;
        }

        // Có item trong giỏ hàng (Cart) thì qua trang thanhtoan.jsp
        req.getRequestDispatcher("/view/thanhtoan.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        HttpSession session = req.getSession();
        CartBean cart = (CartBean) session.getAttribute("cart");

        if (cart == null || cart.getItems().isEmpty()) {
            resp.sendRedirect(req.getContextPath() + "/products");
            return;
        }

        String fullName = req.getParameter("fullName");
        String shippingAddress = req.getParameter("shippingAddress");
        String paymentMethod = req.getParameter("paymentMethod");

        List<OrderItem> orderItems = new ArrayList<>();
        for (CartItemBean cartItem : cart.getItems()) {
            OrderItem orderItem = new OrderItem(cartItem.getProduct(), cartItem.getQuantity(), cartItem.getProduct().getPrice());
            orderItems.add(orderItem);
        }
        Order order = new Order(fullName, shippingAddress, paymentMethod, cart.getTotal(), orderItems);

        req.setAttribute("order", order);
        cart.clear();
        req.getRequestDispatcher("/view/thanhtoanthanhcong.jsp").forward(req, resp);
    }
}