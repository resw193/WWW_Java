package iuh.fit.nguyenbaodinh_23731621_bai3_tuan04.model;

import java.io.Serializable;

public class CartItemBean implements Serializable {
    private Product product;
    private int quantity;

    public CartItemBean(Product product, int quantity) {
        this.product = product;
        this.quantity = quantity;
    }

    // Getter & Setter


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

    // SubTotal
    public double getSubtotal() {
        return product.getPrice() * quantity;
    }
}
