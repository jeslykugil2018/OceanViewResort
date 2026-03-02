package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.dao.RoomDAO;
import com.oceanview.dao.UserDAO;
import com.oceanview.dao.DBConnection;
import com.oceanview.model.Reservation;
import com.oceanview.model.ReservationBuilder;
import com.oceanview.model.Room;
import com.oceanview.model.User;
import com.oceanview.service.EmailService;
import com.oceanview.service.ValidationHandler;
import java.io.IOException;
import java.sql.ResultSet;
import java.sql.Statement;
import java.sql.PreparedStatement;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            UserDAO userDAO = new UserDAO();
            ReservationDAO resDAO = new ReservationDAO();
            RoomDAO roomDAO = new RoomDAO();

            if ("add".equals(action)) {
                int guestId = Integer.parseInt(request.getParameter("guestId"));
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                String checkInStr = request.getParameter("checkIn");
                String checkOutStr = request.getParameter("checkOut");

                // Validation Chain
                ValidationHandler dateChain = ValidationHandler.getDateChain();
                if (!dateChain.validate(checkInStr) || !dateChain.validate(checkOutStr)) {
                    response.sendRedirect("addReservation.jsp?error=Invalid dates provided");
                    return;
                }

                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date checkIn = sdf.parse(checkInStr);
                Date checkOut = sdf.parse(checkOutStr);

                if (checkOut.before(checkIn)) {
                    response.sendRedirect("addReservation.jsp?error=Check-out cannot be before check-in");
                    return;
                }

                Room room = roomDAO.getRoomById(roomId);
                User guest = userDAO.getUserById(guestId);

                long diff = checkOut.getTime() - checkIn.getTime();
                int days = (int) (diff / (1000 * 60 * 60 * 24));
                if (days < 1)
                    days = 1;
                double totalCost = days * room.getPricePerNight();

                String services = "";
                if (request.getParameter("breakfast") != null) {
                    services += "Breakfast ";
                    totalCost += 500 * days;
                }
                if (request.getParameter("spa") != null) {
                    services += "Spa ";
                    totalCost += 5000;
                }
                if (request.getParameter("pickup") != null) {
                    services += "Pickup ";
                    totalCost += 7500;
                }

                Reservation res = new ReservationBuilder()
                        .setGuestId(guestId)
                        .setRoomId(roomId)
                        .setGuestName(guest.getName())
                        .setGuestAddress(guest.getAddress())
                        .setGuestContact(guest.getContact())
                        .setRoomType(room.getRoomType())
                        .setCheckIn(checkIn)
                        .setCheckOut(checkOut)
                        .setServices(services)
                        .setTotalCost(totalCost)
                        .setRoomRate(room.getPricePerNight())
                        .build();

                if (resDAO.addReservation(res)) {
                    room.setStatus("Occupied");
                    roomDAO.updateRoom(room);
                    // Send Email Confirmation
                    EmailService.sendBookingConfirmation(res, guest.getEmail());
                    response.sendRedirect("guestDashboard.jsp?msg=Booking successful");
                } else {
                    response.sendRedirect("addReservation.jsp?error=Booking failed");
                }
            } else if ("walkin".equals(action)) {
                String guestName = request.getParameter("guestName");
                String guestEmail = request.getParameter("guestEmail");
                String guestContact = request.getParameter("guestContact");
                String guestAddress = request.getParameter("guestAddress");

                // Validation Chain for Guest Details
                ValidationHandler nameChain = ValidationHandler.getNameChain();
                ValidationHandler basicChain = ValidationHandler.getBasicChain();

                if (!nameChain.validate(guestName) || !basicChain.validate(guestEmail) ||
                        !nameChain.validate(guestContact) || !nameChain.validate(guestAddress)) {
                    response.sendRedirect("walkinReservation.jsp?error=Invalid guest details");
                    return;
                }

                String checkInStr = request.getParameter("checkIn");
                String checkOutStr = request.getParameter("checkOut");
                ValidationHandler dateChain = ValidationHandler.getDateChain();
                if (!dateChain.validate(checkInStr) || !dateChain.validate(checkOutStr)) {
                    response.sendRedirect("walkinReservation.jsp?error=Invalid dates");
                    return;
                }

                User existingGuest = null;
                try (PreparedStatement ps = DBConnection.getInstance().getConnection()
                        .prepareStatement("SELECT * FROM Users WHERE email=?")) {
                    ps.setString(1, guestEmail);
                    try (ResultSet rs = ps.executeQuery()) {
                        if (rs.next()) {
                            existingGuest = new User(rs.getInt("userId"), rs.getString("name"),
                                    rs.getString("username"), rs.getString("email"), rs.getString("contact"),
                                    rs.getString("address"), rs.getString("password"), rs.getString("role"));
                        }
                    }
                }

                int guestId = 0;
                if (existingGuest == null) {
                    String username = guestEmail.length() > 50 ? guestEmail.substring(0, 47) + "..." : guestEmail;
                    User newUser = new User(0, guestName, username, guestEmail, guestContact, guestAddress,
                            "password123", "Guest");
                    userDAO.registerUser(newUser);

                    try (PreparedStatement ps = DBConnection.getInstance().getConnection()
                            .prepareStatement("SELECT userId FROM Users WHERE email=?")) {
                        ps.setString(1, guestEmail);
                        try (ResultSet rs = ps.executeQuery()) {
                            if (rs.next())
                                guestId = rs.getInt("userId");
                        }
                    }
                } else {
                    guestId = existingGuest.getUserId();
                }

                int roomId = Integer.parseInt(request.getParameter("roomId"));
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date checkIn = sdf.parse(checkInStr);
                Date checkOut = sdf.parse(checkOutStr);

                if (checkOut.before(checkIn)) {
                    response.sendRedirect("walkinReservation.jsp?error=Invalid date range");
                    return;
                }

                Room room = roomDAO.getRoomById(roomId);
                long diff = checkOut.getTime() - checkIn.getTime();
                int days = (int) (diff / (1000 * 60 * 60 * 24));
                if (days < 1)
                    days = 1;
                double totalCost = days * room.getPricePerNight();

                String services = "";
                if (request.getParameter("breakfast") != null) {
                    services += "Breakfast ";
                    totalCost += 500 * days;
                }
                if (request.getParameter("spa") != null) {
                    services += "Spa ";
                    totalCost += 5000;
                }
                if (request.getParameter("pickup") != null) {
                    services += "Pickup ";
                    totalCost += 7500;
                }

                Reservation res = new ReservationBuilder()
                        .setGuestId(guestId)
                        .setRoomId(roomId)
                        .setGuestName(guestName)
                        .setGuestAddress(guestAddress)
                        .setGuestContact(guestContact)
                        .setRoomType(room.getRoomType())
                        .setCheckIn(checkIn)
                        .setCheckOut(checkOut)
                        .setServices(services)
                        .setTotalCost(totalCost)
                        .setRoomRate(room.getPricePerNight())
                        .build();

                if (resDAO.addReservation(res)) {
                    room.setStatus("Occupied");
                    roomDAO.updateRoom(room);
                    // Send Email Confirmation to walk-in guest
                    EmailService.sendBookingConfirmation(res, guestEmail);
                    String redirect = "staffDashboard.jsp";
                    User currentUser = (User) request.getSession().getAttribute("user");
                    if (currentUser != null && currentUser.getRole().equals("Admin"))
                        redirect = "adminDashboard.jsp";
                    response.sendRedirect(redirect + "?msg=Reservation stored successfully");
                } else {
                    response.sendRedirect("walkinReservation.jsp?error=Storage failed");
                }
            } else if ("cancel".equals(action)) {
                int id = Integer.parseInt(request.getParameter("reservationNumber"));
                resDAO.updateStatus(id, "Cancelled");

                String referer = request.getHeader("referer");
                if (referer != null && !referer.isEmpty()) {
                    response.sendRedirect(referer + (referer.contains("?") ? "&" : "?") + "msg=Cancelled");
                } else {
                    String redirect = "guestDashboard.jsp";
                    User currentUser = (User) request.getSession().getAttribute("user");
                    if (currentUser != null) {
                        if (currentUser.getRole().equals("Staff"))
                            redirect = "staffDashboard.jsp";
                        else if (currentUser.getRole().equals("Admin"))
                            redirect = "adminDashboard.jsp";
                    }
                    response.sendRedirect(redirect + "?msg=Cancelled");
                }
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
