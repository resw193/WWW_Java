package iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.model;

import java.io.Serializable;

public class OrderItem implements Serializable {
    private Product product;
    private int quantity;
    private double price;

    public OrderItem() {

    }

    public OrderItem(Product product, int quantity, double price) {
        this.product = product;
        this.quantity = quantity;
        this.price = price;
    }

    public Product getProduct() {
        return product;
    }

    public void setProduct(Product product) {
        this.product = product;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public double getSubtotal() {
        return price * quantity;
    }
}