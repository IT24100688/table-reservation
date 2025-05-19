package com.restaurant.model;

public class User {
    private String name;
    private String email;
    private String phone;
    private String password;
    private String address;

    public User(String name, String email, String phone, String password, String address) {
        this.name = name;
        this.email = email;
        this.phone = phone;
        this.password = password;
        this.address = address;
    }

    // Add backward-compatible constructor
    public User(String name, String email, String phone, String password) {
        this(name, email, phone, password, "");
    }

    public String getAddress() {
        return address == null ? "" : address;
    }

    public String getName() {
        return name;
    }

    public String getEmail() {
        return email;
    }

    public String getPhone() {
        return phone;
    }

    public String getPassword() {
        return password;
    }

    public String toFileFormat() {
        return name + "|" + email + "|" + phone + "|" + password + "|" + address;
    }

    public static com.restaurant.model.User fromLine(String line) {
        if (line == null || line.trim().isEmpty()) {
            return null;
        }

        // Check if file uses commas instead of pipes and handle accordingly
        String[] parts;
        if (line.contains("|")) {
            parts = line.split("\\|");
        } else {
            parts = line.split(",");
        }

        if (parts.length >= 4) {
            String address = parts.length >= 5 ? parts[4] : "";
            // Trim all parts to remove extra whitespace
            for (int i = 0; i < parts.length; i++) {
                parts[i] = parts[i].trim();
            }
            return new com.restaurant.model.User(parts[0], parts[1], parts[2], parts[3], address);
        }
        return null;
    }

    public void setAddress(String address) {
        this.address = address == null ? "" : address;
    }

    public void setName(String name) {
        this.name = name;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }
}
