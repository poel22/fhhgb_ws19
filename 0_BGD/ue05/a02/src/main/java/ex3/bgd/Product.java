package ex3.bgd;

import java.util.HashMap;
import java.util.Map;

public class Product {
    private String hash;
    private String name;
    private String category;
    private String description;
    private double price;

    public Product() {

    }

    public String getHash() {
        return hash;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public double getPrice() {
        return price;
    }

    public void setPrice(double price) {
        this.price = price;
    }

    public Map<String, String> toMap() {
        Map<String, String> result = new HashMap<>();
        result.put("hash", hash);
        result.put("name", name);
        result.put("category", category);
        result.put("description", description);
        result.put("price", Double.toString(price));

        return result;
    }

    public static Product fromMap(Map<String, String> map) {
        Product result = new Product();

        result.setHash(map.get("hash"));
        result.setName(map.get("name"));
        result.setCategory(map.get("category"));
        result.setDescription(map.get("description"));
        result.setPrice(Double.parseDouble(map.get("price")));

        return result;
    }

}