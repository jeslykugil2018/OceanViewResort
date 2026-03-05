package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import com.oceanview.model.User;
import com.oceanview.service.CSVVisitor;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.stream.Collectors;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/ReportServlet")
public class ReportServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession();
        User user = (User) session.getAttribute("user");

        if (user == null || !user.getRole().equals("Admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String type = request.getParameter("type"); // "weekly" or "monthly"
        if (type == null)
            type = "weekly";

        try {
            ReservationDAO resDAO = new ReservationDAO();
            List<Reservation> allReservations = resDAO.getAllReservations();

            Calendar cal = Calendar.getInstance();
            if ("weekly".equals(type)) {
                cal.add(Calendar.DAY_OF_YEAR, -7);
            } else {
                cal.add(Calendar.MONTH, -1);
            }
            Date threshold = cal.getTime();

            List<Reservation> filtered = allReservations.stream()
                    .filter(res -> res.getCheckIn().after(threshold))
                    .collect(Collectors.toList());

            CSVVisitor visitor = new CSVVisitor();
            for (Reservation res : filtered) {
                res.accept(visitor, null);
            }

            String filename = "OceanView_" + type + "_report_" + System.currentTimeMillis() + ".csv";
            response.setContentType("text/csv");
            response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");

            PrintWriter out = response.getWriter();
            out.print(visitor.getCsvContent());
            out.flush();

        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
