package iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.controller;

import iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.dao.ProductDAO;
import iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.model.CartBean;
import iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.model.Product;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import javax.sql.DataSource;
import java.io.IOException;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Resource(name="jdbc/bookstoredb")
    private DataSource dataSource;

    @Override
    public void init() {
        productDAO = new ProductDAO(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/view/giohang.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        CartBean cart = (CartBean) session.getAttribute("cart");

        if (cart == null) {
            cart = new CartBean();
            session.setAttribute("cart", cart);
        }

        String action = req.getParameter("action");
        try {
            if ("add".equals(action)) {
                int id = Integer.parseInt(req.getParameter("id"));
                int quantity = Integer.parseInt(req.getParameter("quantity"));

                Product product = productDAO.getProductById(id);

                if (product == null) {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                    return;
                }

                if (quantity <= 0) {
                    quantity = 1;
                }

                cart.addProduct(product, quantity);
            }

            else if ("update".equals(action)) {
                int id = Integer.parseInt(req.getParameter("productId"));
                int quantity = Integer.parseInt(req.getParameter("quantity"));

                cart.updateQuantity(id, quantity);
            }

            else if ("remove".equals(action)) {
                int id = Integer.parseInt(req.getParameter("productId"));

                cart.removeProduct(id);
            }

            else if ("clear".equals(action)) {
                cart.clear();
            }

        } catch (NumberFormatException e) {
            throw new ServletException("Invalid number format", e);
        }

        resp.sendRedirect(req.getContextPath() + "/cart");
    }
}