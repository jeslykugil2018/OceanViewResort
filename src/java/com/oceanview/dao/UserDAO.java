package com.oceanview.dao;

import com.oceanview.model.User;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAO {
    private Connection connection;

    public UserDAO() throws SQLException {
        this.connection = DBConnection.getInstance().getConnection();
    }

    public boolean registerUser(User user) throws SQLException {
        String query = "INSERT INTO Users (name, username, email, contact, address, password, role) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getContact());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getPassword());
            ps.setString(7, user.getRole());
            return ps.executeUpdate() > 0;
        }
    }

    public User loginUser(String email, String password) throws SQLException {
        String query = "SELECT * FROM Users WHERE email = ? AND password = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, email);
            ps.setString(2, password);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("userId"),
                            rs.getString("name"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("contact"),
                            rs.getString("address"),
                            rs.getString("password"),
                            rs.getString("role"));
                }
            }
        }
        return null;
    }

    public User getUserById(int userId) throws SQLException {
        String query = "SELECT * FROM Users WHERE userId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new User(
                            rs.getInt("userId"),
                            rs.getString("name"),
                            rs.getString("username"),
                            rs.getString("email"),
                            rs.getString("contact"),
                            rs.getString("address"),
                            rs.getString("password"),
                            rs.getString("role"));
                }
            }
        }
        return null;
    }

    public boolean isUsernameTaken(String username) throws SQLException {
        String query = "SELECT COUNT(*) FROM Users WHERE username = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, username);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public boolean isEmailTaken(String email) throws SQLException {
        String query = "SELECT COUNT(*) FROM Users WHERE email = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, email);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next())
                    return rs.getInt(1) > 0;
            }
        }
        return false;
    }

    public List<User> getAllStaff() throws SQLException {
        List<User> staffList = new ArrayList<>();
        String query = "SELECT * FROM Users WHERE role IN ('Staff', 'Admin')";
        try (PreparedStatement ps = connection.prepareStatement(query);
                ResultSet rs = ps.executeQuery()) {
            while (rs.next()) {
                staffList.add(new User(
                        rs.getInt("userId"),
                        rs.getString("name"),
                        rs.getString("username"),
                        rs.getString("email"),
                        rs.getString("contact"),
                        rs.getString("address"),
                        rs.getString("password"),
                        rs.getString("role")));
            }
        }
        return staffList;
    }

    public boolean updateUser(User user) throws SQLException {
        String query = "UPDATE Users SET name=?, username=?, email=?, contact=?, address=?, role=? WHERE userId=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, user.getName());
            ps.setString(2, user.getUsername());
            ps.setString(3, user.getEmail());
            ps.setString(4, user.getContact());
            ps.setString(5, user.getAddress());
            ps.setString(6, user.getRole());
            ps.setInt(7, user.getUserId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteUser(int userId) throws SQLException {
        String query = "DELETE FROM Users WHERE userId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, userId);
            return ps.executeUpdate() > 0;
        }
    }
}
