package iuh.fit.nguyenbaodinh_23731621_bai3_tuan04.model;

public class Product {
    private int id;
    private String model;
    private double price;
    private int quantity;
    private String description;
    private String imgURL;

    public Product() {

    }

    public Product(int id, String model, double price, int quantity, String description, String imgURL) {
        this.id = id;
        this.model = model;
        this.price = price;
        this.quantity = quantity;
        this.description = description;
        this.imgURL = imgURL;
    }


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getModel() {
        return model;
    }

    public void setModel(String model) {
        this.model = model;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public int getQuantity() {
        return quantity;
    }

    public void setQuantity(int quantity) {
        this.quantity = quantity;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getImgURL() {
        return imgURL;
    }

    public void setImgURL(String imgURL) {
        this.imgURL = imgURL;
    }

}
