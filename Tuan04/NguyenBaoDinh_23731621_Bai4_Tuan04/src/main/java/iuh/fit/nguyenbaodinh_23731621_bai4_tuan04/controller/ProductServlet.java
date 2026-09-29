package iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.controller;

import iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.dao.ProductDAO;
import iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.model.Product;
import jakarta.annotation.Resource;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.List;

@WebServlet({"/products", "/product"})
public class ProductServlet extends HttpServlet {
    private ProductDAO productDAO;

    @Resource(name="jdbc/bookstoredb")
    private DataSource dataSource;

    @Override
    public void init() {
        productDAO = new ProductDAO(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idStr = req.getParameter("id");

        // Xem chi tiết sách
        if (idStr != null && !idStr.isBlank()) {
            try {
                int id = Integer.parseInt(idStr);
                Product product = productDAO.getProductById(id);

                if (product == null) {
                    resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                    return;
                }

                req.setAttribute("product", product);
                req.getRequestDispatcher("/view/chitietsach.jsp").forward(req, resp);
                return;

            } catch (NumberFormatException e) {
                resp.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Product ID");
                return;
            }
        }

        // Tìm kiếm hoặc hiển thị tất cả sách
        String keyword = req.getParameter("keyword");
        List<Product> products;

        if (keyword != null && !keyword.trim().isEmpty()) {
            products = productDAO.searchProducts(keyword.trim());
            req.setAttribute("keyword", keyword.trim());
        }
        else {
            products = productDAO.getAllProducts();
        }

        req.setAttribute("products", products);
        req.getRequestDispatcher("/view/danhsach.jsp").forward(req, resp);
    }
}