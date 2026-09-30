package iuh.fit.nguyenbaodinh_23731621_bai6_tuan04.controller;

import iuh.fit.nguyenbaodinh_23731621_bai6_tuan04.dao.DanhMucDAO;
import iuh.fit.nguyenbaodinh_23731621_bai6_tuan04.dao.DanhSachTinTucQuanLy;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;

@WebServlet("/quanly")
public class QuanLyFormServlet extends HttpServlet {

    @Resource(name = "jdbc/quanlytintuc")
    private DataSource dataSource;

    private DanhSachTinTucQuanLy tinTucDAO;
    private DanhMucDAO danhMucDAO;

    @Override
    public void init(ServletConfig servletConfig) throws ServletException {
        super.init(servletConfig);

        try {
            tinTucDAO = new DanhSachTinTucQuanLy(dataSource);
            danhMucDAO = new DanhMucDAO(dataSource);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":

                req.setAttribute("tinTucs", tinTucDAO.getAll());
                req.setAttribute("danhMucs", danhMucDAO.getAll());

                req.getRequestDispatcher("/view/QuanLyForm.jsp").forward(req, resp);
                break;

            case "delete":
                int maTT = Integer.parseInt(req.getParameter("id"));

                tinTucDAO.delete(maTT);
                resp.sendRedirect(req.getContextPath() + "/quanly?success=delete");

                break;
        }
    }
}