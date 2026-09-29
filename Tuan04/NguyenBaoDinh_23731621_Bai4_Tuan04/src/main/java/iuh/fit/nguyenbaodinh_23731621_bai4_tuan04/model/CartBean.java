package iuh.fit.nguyenbaodinh_23731621_bai4_tuan04.model;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

public class CartBean implements Serializable {
    private List<CartItemBean> items;

    public CartBean() {
        items = new ArrayList<>();
    }

    public List<CartItemBean> getItems() {
        return items;
    }

    public void addProduct(Product product, int quantity) {
        if (product == null || quantity <= 0) {
            return;
        }

        for (CartItemBean item : items) {
            if (item.getProduct().getId() == product.getId()) {
                int newQuantity = item.getQuantity() + quantity;

                if (newQuantity > product.getQuantity()) {
                    newQuantity = product.getQuantity();
                }

                item.setQuantity(newQuantity);
                return;
            }
        }

        if (quantity > product.getQuantity()) {
            quantity = product.getQuantity();
        }

        items.add(new CartItemBean(product, quantity));
    }

    public void removeProduct(int productId) {
        items.removeIf(item -> item.getProduct().getId() == productId);
    }

    public void updateQuantity(int productId, int quantity) {
        for (CartItemBean item : items) {
            if (item.getProduct().getId() == productId) {
                if (quantity <= 0) {
                    removeProduct(productId);
                    return;
                }

                if (quantity > item.getProduct().getQuantity()) {
                    quantity = item.getProduct().getQuantity();
                }

                item.setQuantity(quantity);
                return;
            }
        }
    }

    public double getTotal() {
        double total = 0;

        for (CartItemBean item : items) {
            total += item.getSubtotal();
        }

        return total;
    }

    public int getItemCount() {
        return items.size();
    }

    public void clear() {
        items.clear();
    }
}