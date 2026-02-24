package com.oceanview.dao;

import java.sql.*;

public class MessageDAO {
    private Connection connection;

    public MessageDAO() throws SQLException {
        this.connection = DBConnection.getInstance().getConnection();
    }

    public boolean saveMessage(String name, String email, String subject, String message) throws SQLException {
        String query = "INSERT INTO ContactMessages (name, email, subject, message) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, subject);
            ps.setString(4, message);
            return ps.executeUpdate() > 0;
        }
    }
}
