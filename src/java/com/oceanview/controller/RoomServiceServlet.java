package com.oceanview.controller;

import com.oceanview.dao.RoomDAO;
import com.oceanview.model.Room;
import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 * RESTful Web Service for Room Availability
 * returns JSON data for distributed consumption
 */
@WebServlet("/api/rooms/available")
public class RoomServiceServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");

        RoomDAO roomDAO = null;
        try {
            roomDAO = new RoomDAO();
        } catch (SQLException ex) {
            Logger.getLogger(RoomServiceServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
        try {
            List<Room> availableRooms = roomDAO.getAvailableRooms();

            PrintWriter out = response.getWriter();
            StringBuilder json = new StringBuilder();
            json.append("[");

            for (int i = 0; i < availableRooms.size(); i++) {
                Room r = availableRooms.get(i);
                json.append("{");
                json.append("\"roomId\":").append(r.getRoomId()).append(",");
                json.append("\"roomType\":\"").append(r.getRoomType()).append("\",");
                json.append("\"price\":").append(r.getPricePerNight()).append(",");
                json.append("\"status\":\"").append(r.getStatus()).append("\"");
                json.append("}");
                if (i < availableRooms.size() - 1) {
                    json.append(",");
                }
            }

            json.append("]");
            out.print(json.toString());
            out.flush();

        } catch (Exception e) {
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            response.getWriter().write("{\"error\":\"" + e.getMessage() + "\"}");
        }
    }
}
