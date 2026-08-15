package com.springboot.dto;

/**
 * Data Transfer Object for Game Create/Update Request
 */
public class GameRequest {
    
    private String name;
    private String description;
    private String category;
    private String imageUrl;
    private Boolean active;
    private Boolean popular;
    
    public GameRequest() {}
    
    public GameRequest(String name, String description, String category, String imageUrl) {
        this.name = name;
        this.description = description;
        this.category = category;
        this.imageUrl = imageUrl;
    }
    
    public String getName() {
        return name;
    }
    
    public void setName(String name) {
        this.name = name;
    }
    
    public String getDescription() {
        return description;
    }
    
    public void setDescription(String description) {
        this.description = description;
    }
    
    public String getCategory() {
        return category;
    }
    
    public void setCategory(String category) {
        this.category = category;
    }
    
    public String getImageUrl() {
        return imageUrl;
    }
    
    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }
    
    public Boolean getActive() {
        return active;
    }
    
    public void setActive(Boolean active) {
        this.active = active;
    }
    
    public Boolean getPopular() {
        return popular;
    }
    
    public void setPopular(Boolean popular) {
        this.popular = popular;
    }
    
    // Validation
    public boolean isValid() {
        return name != null && !name.trim().isEmpty()
            && category != null && !category.trim().isEmpty();
    }
    
    @Override
    public String toString() {
        return "GameRequest{" +
                "name='" + name + '\'' +
                ", description='" + description + '\'' +
                ", category='" + category + '\'' +
                ", imageUrl='" + imageUrl + '\'' +
                ", active=" + active +
                ", popular=" + popular +
                '}';
    }
}