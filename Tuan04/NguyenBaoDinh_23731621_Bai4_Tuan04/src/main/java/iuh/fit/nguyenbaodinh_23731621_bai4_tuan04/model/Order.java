package iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class Order implements Serializable {
    private String fullName;
    private String shippingAddress;
    private String paymentMethod;
    private double totalPrice;
    private List<OrderItem> items;

    public Order() {
        items = new ArrayList<>();
    }

    public Order(String fullName, String shippingAddress, String paymentMethod, double totalPrice, List<OrderItem> items) {
        this.fullName = fullName;
        this.shippingAddress = shippingAddress;
        this.paymentMethod = paymentMethod;
        this.totalPrice = totalPrice;
        this.items = items;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getShippingAddress() {
        return shippingAddress;
    }

    public void setShippingAddress(String shippingAddress) {
        this.shippingAddress = shippingAddress;
    }

    public String getPaymentMethod() {
        return paymentMethod;
    }

    public void setPaymentMethod(String paymentMethod) {
        this.paymentMethod = paymentMethod;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public List<OrderItem> getItems() {
        return items;
    }

    public void setItems(List<OrderItem> items) {
        this.items = items;
    }
}