package com.oceanview.controller;

import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Room;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/RoomServlet")
public class RoomServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        try {
            RoomDAO roomDAO = new RoomDAO();

            if ("add".equals(action)) {
                String roomNumber = request.getParameter("roomNumber");
                String roomType = request.getParameter("roomType");
                String status = request.getParameter("status");
                double price = Double.parseDouble(request.getParameter("pricePerNight"));

                Room room = new Room(0, roomNumber, roomType, status, price);
                if (roomDAO.addRoom(room)) {
                    response.sendRedirect("manageRooms.jsp?msg=Room added successfully");
                } else {
                    response.sendRedirect("manageRooms.jsp?error=Failed to add room");
                }
            } else if ("update".equals(action)) {
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                String roomNumber = request.getParameter("roomNumber");
                String roomType = request.getParameter("roomType");
                String status = request.getParameter("status");
                double price = Double.parseDouble(request.getParameter("pricePerNight"));

                Room room = new Room(roomId, roomNumber, roomType, status, price);
                if (roomDAO.updateRoom(room)) {
                    response.sendRedirect("manageRooms.jsp?msg=Room updated successfully");
                } else {
                    response.sendRedirect("manageRooms.jsp?error=Failed to update room");
                }
            } else if ("delete".equals(action)) {
                int roomId = Integer.parseInt(request.getParameter("roomId"));
                if (roomDAO.deleteRoom(roomId)) {
                    response.sendRedirect("manageRooms.jsp?msg=Room deleted successfully");
                } else {
                    response.sendRedirect("manageRooms.jsp?error=Failed to delete room");
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
