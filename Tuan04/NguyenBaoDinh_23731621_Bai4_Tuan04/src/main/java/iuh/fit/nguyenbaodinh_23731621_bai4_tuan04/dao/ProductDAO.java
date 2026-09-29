package iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.dao;


import iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.model.Product;
import iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.util.DBUtil;

import javax.sql.DataSource;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDAO {
    private DBUtil dbUtil;

    private static final double DEFAULT_PRICE = 100000;
    private static final int DEFAULT_QUANTITY = 10;

    public ProductDAO(DataSource dataSource) {
        dbUtil = new DBUtil(dataSource);
    }

    // getAll
    public List<Product> getAllProducts() {
        List<Product> list = new ArrayList<>();
        String sql = "SELECT * FROM books";

        try (Connection conn = dbUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {

            while (rs.next()) {
                int id = rs.getInt("id");
                String title = rs.getString("tittle");
                String author = rs.getString("author");
                String imgURL = rs.getString("imgbook");
                double price = DEFAULT_PRICE;
                int quantity = DEFAULT_QUANTITY;
                String description = "Sách " + title + " của tác giả " + author;

                Product product = new Product(id, title, author, price, quantity, description, imgURL);
                list.add(product);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return list;
    }

    // getById
    public Product getProductById(int id) {
        String sql = "SELECT * FROM books WHERE id=?";

        try (Connection conn = dbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    String title = rs.getString("tittle");
                    String author = rs.getString("author");
                    String imgURL = rs.getString("imgbook");

                    double price = DEFAULT_PRICE;
                    int quantity = DEFAULT_QUANTITY;
                    String description = "Sách " + title + " của tác giả " + author;

                    return new Product(id, title, author, price, quantity, description, imgURL);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return null;
    }

    // Search theo title | author
    public List<Product> searchProducts(String keyword) {
        List<Product> list = new ArrayList<>();

        String sql = "SELECT * FROM books WHERE tittle LIKE ? OR author LIKE ?";

        try (Connection conn = dbUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            String searchKeyword = "%" + keyword + "%";

            ps.setString(1, searchKeyword);
            ps.setString(2, searchKeyword);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    int id = rs.getInt("id");
                    String title = rs.getString("tittle");
                    String author = rs.getString("author");
                    String imgURL = rs.getString("imgbook");
                    double price = DEFAULT_PRICE;
                    int quantity = DEFAULT_QUANTITY;
                    String description = "Sách " + title + " của tác giả " + author;

                    Product product = new Product(id, title, author, price, quantity, description, imgURL);
                    list.add(product);
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return list;
    }
}