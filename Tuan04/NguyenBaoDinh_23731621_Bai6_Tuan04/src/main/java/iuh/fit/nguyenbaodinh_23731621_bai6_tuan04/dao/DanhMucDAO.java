package iuh.fit.nguyenbaodinh_23731621_bai6_tuan04.dao;

import iuh.fit.nguyenbaodinh_23731621_bai6_tuan04.model.DanhMuc;
import iuh.fit.nguyenbaodinh_23731621_bai6_tuan04.util.DBUtil;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DanhMucDAO {

    private DBUtil dbUtil;

    public DanhMucDAO(DataSource dataSource) {
        dbUtil = new DBUtil(dataSource);
    }

    // Lấy tất cả danh mục
    public List<DanhMuc> getAll() {
        List<DanhMuc> list = new ArrayList<>();

        String sql = "SELECT * FROM danhmuc ORDER BY MADM";

        try (Connection conn = dbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                DanhMuc dm = new DanhMuc();

                dm.setMaDM(rs.getInt("MADM"));
                dm.setTenDanhMuc(rs.getString("TENDANHMUC"));
                dm.setNguoiQuanLy(rs.getString("NGUOIQUANLY"));
                dm.setGhiChu(rs.getString("GHICHU"));

                list.add(dm);
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return list;
    }

    // Lấy danh mục theo mã
    public DanhMuc getById(int maDM) {

        String sql = "SELECT * FROM danhmuc WHERE MADM=?";

        try (Connection conn = dbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maDM);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    DanhMuc dm = new DanhMuc();

                    dm.setMaDM(rs.getInt("MADM"));
                    dm.setTenDanhMuc(rs.getString("TENDANHMUC"));
                    dm.setNguoiQuanLy(rs.getString("NGUOIQUANLY"));
                    dm.setGhiChu(rs.getString("GHICHU"));

                    return dm;
                }
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return null;
    }
}