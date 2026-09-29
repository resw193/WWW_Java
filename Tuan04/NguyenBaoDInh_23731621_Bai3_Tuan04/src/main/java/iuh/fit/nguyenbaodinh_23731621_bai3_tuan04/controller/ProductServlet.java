package iuh.fit.nguyenbaodinh_23731621_bai3_tuan04.controller;

import iuh.fit.nguyenbaodinh_23731621_bai3_tuan04.dao.ProductDAO;
import iuh.fit.nguyenbaodinh_23731621_bai3_tuan04.model.Product;
import jakarta.annotation.Resource;
import jakarta.servlet.RequestDispatcher;
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

    @Resource(name="jdbc/shopdb")
    private DataSource dataSource;

    @Override
    public void init() {
        productDAO = new ProductDAO(dataSource);
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String idstr = req.getParameter("id");

        // Khi bấm vào "Product Detail (Xem chi tiết product)"
        if(idstr != null)
        {
            int id = Integer.parseInt(idstr);
            Product product = productDAO.getProductById(id);

            if(product != null) {
                req.setAttribute("product", product);
                req.getServletContext().getRequestDispatcher("/view/product-detail.jsp").forward(req, resp);
            }
            else {
                resp.sendError(HttpServletResponse.SC_NOT_FOUND, "Product not found");
                return;
            }
        }

        // Khi không bấm vào "Product Detail (Xem chi tiết product)" --> Hiển thị toàn bộ product
        List<Product> products = productDAO.getAllProducts();
        req.setAttribute("products", products);
        req.getServletContext().getRequestDispatcher("/view/product-list.jsp").forward(req, resp);
    }

}
