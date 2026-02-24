package com.oceanview.dao;

import com.oceanview.model.User;
import java.sql.*;

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
}
