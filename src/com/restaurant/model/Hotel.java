package com.restaurant.model;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public class Hotel {
    private String name;
    private String description;
    private String location;
    private String imageUrl;
    private List<String> features;

    //Constructor with 5 parameters
    public Hotel(String name, String description, String location, String imageUrl, List<String> features) {
        this.name = name;
        this.description = description;
        this.location = location;
        this.imageUrl = imageUrl;
        this.features = features;
    }
    public Hotel(String line) {
        // Expected format: name|description|location|imageUrl|feature1,feature2,feature3
        String[] parts = line.split("\\|");

        this.name = parts.length > 0 ? parts[0] : "";
        this.description = parts.length > 1 ? parts[1] : "";
        this.location = parts.length > 2 ? parts[2] : "";
        this.imageUrl = parts.length > 3 ? parts[3] : "";
        this.features = parts.length > 4 ? Arrays.asList(parts[4].split(",")) : new ArrayList<>();
    }


    // Getters
    public String getName() {
        return name;
    }

    public String getDescription() {
        return description;
    }

    public String getLocation() {
        return location;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public List<String> getFeatures() {
        return features;
    }

    // Setters
    public void setName(String name) {
        this.name = name;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public void setFeatures(List<String> features) {
        this.features = features;
    }
}
