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
import java.util.ArrayList;
import java.util.List;

@WebServlet("/tintuc-form")
public class TinTucFormServlet extends HttpServlet {

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
        // Load danh mục cho combobox
        req.setAttribute("danhMucs", danhMucDAO.getAll());

        req.getRequestDispatcher("/view/TinTucForm.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");

        String tieuDe = req.getParameter("tieuDe");
        String noiDungTT = req.getParameter("noiDungTT");
        String lienKet = req.getParameter("lienKet");
        String maDMParam = req.getParameter("maDM");

        List<String> errors = new ArrayList<>();

        // Tiêu đề bắt buộc nhập
        if (tieuDe == null || tieuDe.trim().isEmpty()) {
            errors.add("Tiêu đề không được để trống.");
        }

        // Nội dung bắt buộc
        if (noiDungTT == null || noiDungTT.trim().isEmpty()) {
            errors.add("Nội dung không được để trống.");
        }

        // Nội dung không quá 255 ký tự
        if (noiDungTT != null && !noiDungTT.trim().isEmpty() && !noiDungTT.matches("(?s)^.{1,255}$")) {
            errors.add("Nội dung không được quá 255 ký tự.");
        }

        // Liên kết bắt buộc
        if (lienKet == null || lienKet.trim().isEmpty()) {
            errors.add("Liên kết không được để trống.");
        }
        else {
            // Chấp nhận http:// và https://
            if (!lienKet.matches("^https?://.+$")) {
                errors.add("Liên kết phải bắt đầu bằng http:// hoặc https://.");
            }
        }

        int maDM = 0;

        // Danh mục bắt buộc
        if (maDMParam == null || maDMParam.isEmpty()) {
            errors.add("Bạn phải chọn danh mục.");
        }
        else {
            try {
                maDM = Integer.parseInt(maDMParam);
            } catch (NumberFormatException e) {
                errors.add("Danh mục không hợp lệ.");
            }
        }

        // Nếu có lỗi thì quay lại form
        if (!errors.isEmpty()) {

            req.setAttribute("errors", errors);

            req.setAttribute("tieuDe", tieuDe);
            req.setAttribute("noiDungTT", noiDungTT);
            req.setAttribute("lienKet", lienKet);
            req.setAttribute("maDM", maDM);

            req.setAttribute("danhMucs", danhMucDAO.getAll());

            req.getRequestDispatcher("/view/TinTucForm.jsp")
                    .forward(req, resp);

            return;
        }

        // Không lỗi -> thêm vào database
        TinTuc tinTuc = new TinTuc(tieuDe.trim(), noiDungTT.trim(), lienKet.trim(), maDM);
        tinTucDAO.save(tinTuc);

        // Trở về danh sách của danh mục vừa thêm
        resp.sendRedirect(req.getContextPath() + "/danhsachtintuc?maDM=" + maDM + "&success=add");
    }
}