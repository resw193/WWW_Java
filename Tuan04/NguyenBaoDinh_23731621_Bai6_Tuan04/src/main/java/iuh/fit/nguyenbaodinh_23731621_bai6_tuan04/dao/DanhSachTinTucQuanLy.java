package iuh.fit.nguyenbaodinh_23731621_bai6_tuan04.dao;

import iuh.fit.nguyenbaodinh_23731621_bai6_tuan04.model.TinTuc;
import iuh.fit.nguyenbaodinh_23731621_bai6_tuan04.util.DBUtil;

import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class DanhSachTinTucQuanLy {

    private DBUtil dbUtil;

    public DanhSachTinTucQuanLy(DataSource dataSource) {
        dbUtil = new DBUtil(dataSource);
    }

    // Lấy tất cả tin tức
    public List<TinTuc> getAll() {
        List<TinTuc> list = new ArrayList<>();

        String sql = "SELECT * FROM tintuc ORDER BY MATT";

        try (Connection conn = dbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {

                TinTuc tinTuc = new TinTuc();

                tinTuc.setMaTT(rs.getInt("MATT"));
                tinTuc.setTieuDe(rs.getString("TIEUDE"));
                tinTuc.setNoiDungTT(rs.getString("NOIDUNGTT"));
                tinTuc.setLienKet(rs.getString("LIENKET"));
                tinTuc.setMaDM(rs.getInt("MADM"));

                list.add(tinTuc);
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return list;
    }

    // Lấy tin tức theo danh mục
    public List<TinTuc> getByDanhMuc(int maDM) {
        List<TinTuc> list = new ArrayList<>();

        String sql = "SELECT * FROM tintuc WHERE MADM=? ORDER BY MATT";

        try (Connection conn = dbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maDM);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    TinTuc tinTuc = new TinTuc();

                    tinTuc.setMaTT(rs.getInt("MATT"));
                    tinTuc.setTieuDe(rs.getString("TIEUDE"));
                    tinTuc.setNoiDungTT(rs.getString("NOIDUNGTT"));
                    tinTuc.setLienKet(rs.getString("LIENKET"));
                    tinTuc.setMaDM(rs.getInt("MADM"));

                    list.add(tinTuc);
                }
            }

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return list;
    }

    // Thêm tin tức
    public void save(TinTuc tinTuc) {

        String sql = "INSERT INTO tintuc(TIEUDE, NOIDUNGTT, LIENKET, MADM) VALUES (?, ?, ?, ?)";

        try (Connection conn = dbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, tinTuc.getTieuDe());
            ps.setString(2, tinTuc.getNoiDungTT());
            ps.setString(3, tinTuc.getLienKet());
            ps.setInt(4, tinTuc.getMaDM());

            ps.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    // Xóa tin tức
    public void delete(int maTT) {

        String sql = "DELETE FROM tintuc WHERE MATT=?";

        try (Connection conn = dbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, maTT);

            ps.executeUpdate();

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }
}