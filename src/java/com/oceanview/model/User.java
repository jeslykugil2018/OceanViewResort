package com.oceanview.model;

/**
 * User Model
 */
public class User {
    private int userId;
    private String name;
    private String username;
    private String email;
    private String contact;
    private String address;
    private String password;
    private String role;

    public User() {
    }

    public User(int userId, String name, String username, String email, String contact, String address, String password,
            String role) {
        this.userId = userId;
        this.name = name;
        this.username = username;
        this.email = email;
        this.contact = contact;
        this.address = address;
        this.password = password;
        this.role = role;
    }

    // Getters and Setters
    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getContact() {
        return contact;
    }

    public void setContact(String contact) {
        this.contact = contact;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getRole() {
        return role;
    }

    public void setRole(String role) {
        this.role = role;
    }
}
