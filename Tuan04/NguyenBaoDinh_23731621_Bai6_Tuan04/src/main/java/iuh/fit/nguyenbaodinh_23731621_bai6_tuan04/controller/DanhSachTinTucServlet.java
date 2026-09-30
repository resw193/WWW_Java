package iuh.fit.nguyenbaodinh_23731621_bai6_tuan04.controller;

import iuh.fit.nguyenbaodinh_23731621_bai6_tuan04.dao.DanhMucDAO;
import iuh.fit.nguyenbaodinh_23731621_bai6_tuan04.dao.DanhSachTinTucQuanLy;
import iuh.fit.nguyenbaodinh_23731621_bai6_tuan04.model.TinTuc;

import jakarta.annotation.Resource;
import jakarta.servlet.ServletConfig;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import javax.sql.DataSource;
import java.io.IOException;
import java.util.List;

@WebServlet("/danhsachtintuc")
public class DanhSachTinTucServlet extends HttpServlet {

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
        String maDMParam = req.getParameter("maDM");

        List<TinTuc> danhSachTin;

        // Nếu có chọn danh mục
        if (maDMParam != null && !maDMParam.isEmpty()) {
            int maDM = Integer.parseInt(maDMParam);

            danhSachTin = tinTucDAO.getByDanhMuc(maDM);
            req.setAttribute("currentMaDM", maDM);
        }
        // Không chọn thì hiển thị tất cả
        else {
            danhSachTin = tinTucDAO.getAll();
        }

        req.setAttribute("tinTucs", danhSachTin);
        req.setAttribute("danhMucs", danhMucDAO.getAll());

        req.getRequestDispatcher("/view/DanhSachTinTuc.jsp").forward(req, resp);
    }
}