package com.oceanview.dao;

import com.oceanview.model.Reservation;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ReservationDAO {
    private Connection connection;

    public ReservationDAO() throws SQLException {
        this.connection = DBConnection.getInstance().getConnection();
    }

    public boolean addReservation(Reservation res) throws SQLException {
        String query = "INSERT INTO Reservations (guestId, roomId, guestName, guestAddress, guestContact, roomType, checkIn, checkOut, services, totalCost, roomRate, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (PreparedStatement ps = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            ps.setInt(1, res.getGuestId());
            ps.setInt(2, res.getRoomId());
            ps.setString(3, res.getGuestName());
            ps.setString(4, res.getGuestAddress());
            ps.setString(5, res.getGuestContact());
            ps.setString(6, res.getRoomType());
            ps.setDate(7, new java.sql.Date(res.getCheckIn().getTime()));
            ps.setDate(8, new java.sql.Date(res.getCheckOut().getTime()));
            ps.setString(9, res.getServices());
            ps.setDouble(10, res.getTotalCost());
            ps.setDouble(11, res.getRoomRate());
            ps.setString(12, res.getStatus());

            boolean success = ps.executeUpdate() > 0;
            if (success) {
                try (ResultSet generatedKeys = ps.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        res.setReservationNumber(generatedKeys.getInt(1));
                    }
                }
            }
            return success;
        }
    }

    public List<Reservation> getAllReservations() throws SQLException {
        List<Reservation> list = new ArrayList<>();
        String query = "SELECT * FROM Reservations";
        try (Statement st = connection.createStatement(); ResultSet rs = st.executeQuery(query)) {
            while (rs.next()) {
                Reservation res = new Reservation();
                res.setReservationNumber(rs.getInt("reservationNumber"));
                res.setGuestId(rs.getInt("guestId"));
                res.setRoomId(rs.getInt("roomId"));
                res.setGuestName(rs.getString("guestName"));
                res.setGuestAddress(rs.getString("guestAddress"));
                res.setGuestContact(rs.getString("guestContact"));
                res.setRoomType(rs.getString("roomType"));
                res.setCheckIn(rs.getDate("checkIn"));
                res.setCheckOut(rs.getDate("checkOut"));
                res.setServices(rs.getString("services"));
                res.setTotalCost(rs.getDouble("totalCost"));
                res.setRoomRate(rs.getDouble("roomRate"));
                res.setStatus(rs.getString("status"));
                list.add(res);
            }
        }
        return list;
    }

    public List<Reservation> getReservationsByGuest(int guestId) throws SQLException {
        List<Reservation> list = new ArrayList<>();
        String query = "SELECT * FROM Reservations WHERE guestId = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setInt(1, guestId);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Reservation res = new Reservation();
                    res.setReservationNumber(rs.getInt("reservationNumber"));
                    res.setGuestId(rs.getInt("guestId"));
                    res.setRoomId(rs.getInt("roomId"));
                    res.setGuestName(rs.getString("guestName"));
                    res.setGuestAddress(rs.getString("guestAddress"));
                    res.setGuestContact(rs.getString("guestContact"));
                    res.setRoomType(rs.getString("roomType"));
                    res.setCheckIn(rs.getDate("checkIn"));
                    res.setCheckOut(rs.getDate("checkOut"));
                    res.setServices(rs.getString("services"));
                    res.setTotalCost(rs.getDouble("totalCost"));
                    res.setRoomRate(rs.getDouble("roomRate"));
                    res.setStatus(rs.getString("status"));
                    list.add(res);
                }
            }
        }
        return list;
    }

    public boolean updateStatus(int reservationNumber, String status) throws SQLException {
        String query = "UPDATE Reservations SET status = ? WHERE reservationNumber = ?";
        try (PreparedStatement ps = connection.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, reservationNumber);
            return ps.executeUpdate() > 0;
        }
    }
}
