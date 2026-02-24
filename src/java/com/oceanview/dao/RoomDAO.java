package com.oceanview.dao;

import com.oceanview.model.Room;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class RoomDAO {
    private Connection connection;

    public RoomDAO() throws SQLException {
        this.connection = DBConnection.getInstance().getConnection();
    }

    public List<Room> getAllRooms() throws SQLException {
        List<Room> rooms = new ArrayList<>();
        String query = "SELECT * FROM Rooms ORDER BY roomNumber ASC";
        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(query)) {
            while (rs.next()) {
                rooms.add(new Room(
                        rs.getInt("roomId"),
                        rs.getString("roomNumber"),
                        rs.getString("roomType"),
                        rs.getString("status"),
                        rs.getDouble("pricePerNight")));
            }
        }
        return rooms;
    }

    public List<Room> getAvailableRooms() throws SQLException {
        List<Room> rooms = new ArrayList<>();
        String query = "SELECT * FROM Rooms WHERE status = 'Available' ORDER BY roomNumber ASC";
        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(query)) {
            while (rs.next()) {
                rooms.add(new Room(
                        rs.getInt("roomId"),
                        rs.getString("roomNumber"),
                        rs.getString("roomType"),
                        rs.getString("status"),
                        rs.getDouble("pricePerNight")));
            }
        }
        return rooms;
    }

    public Room getRoomById(int roomId) throws SQLException {
        String query = "SELECT * FROM Rooms WHERE roomId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, roomId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return new Room(
                            rs.getInt("roomId"),
                            rs.getString("roomNumber"),
                            rs.getString("roomType"),
                            rs.getString("status"),
                            rs.getDouble("pricePerNight"));
                }
            }
        }
        return null;
    }

    public boolean addRoom(Room room) throws SQLException {
        String query = "INSERT INTO Rooms (roomNumber, roomType, status, pricePerNight) VALUES (?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, room.getRoomNumber());
            ps.setString(2, room.getRoomType());
            ps.setString(3, room.getStatus());
            ps.setDouble(4, room.getPricePerNight());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean updateRoom(Room room) throws SQLException {
        String query = "UPDATE Rooms SET roomNumber=?, roomType=?, status=?, pricePerNight=? WHERE roomId=?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, room.getRoomNumber());
            ps.setString(2, room.getRoomType());
            ps.setString(3, room.getStatus());
            ps.setDouble(4, room.getPricePerNight());
            ps.setInt(5, room.getRoomId());
            return ps.executeUpdate() > 0;
        }
    }

    public boolean deleteRoom(int roomId) throws SQLException {
        String query = "DELETE FROM Rooms WHERE roomId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, roomId);
            return ps.executeUpdate() > 0;
        }
    }
}
