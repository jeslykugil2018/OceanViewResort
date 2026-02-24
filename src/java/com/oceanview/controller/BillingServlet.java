package com.oceanview.controller;

import com.oceanview.dao.ReservationDAO;
import com.oceanview.model.Reservation;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import com.oceanview.service.PDFVisitor;

/**
 * Controller for printing bills.
 * Renamed from BillingServlet to satisfy requirement.
 */
@WebServlet("/BillingServlet")
public class BillingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String resParam = request.getParameter("reservationNumber");
        if (resParam == null || resParam.isEmpty()) {
            response.sendRedirect("staffDashboard.jsp?error=Invalid reservation number");
            return;
        }

        int resId = Integer.parseInt(resParam);
        try {
            ReservationDAO dao = new ReservationDAO();
            List<Reservation> all = dao.getAllReservations();
            Reservation target = null;
            for (Reservation r : all) {
                if (r.getReservationNumber() == resId) {
                    target = r;
                    break;
                }
            }

            if (target != null) {
                String fileName = "Bill_" + resId + ".pdf";
                String filePath = getServletContext().getRealPath("/") + fileName;

                // Use Visitor pattern via accept method
                PDFVisitor visitor = new PDFVisitor();
                target.accept(visitor, filePath);

                response.sendRedirect(fileName);
            } else {
                response.sendRedirect("staffDashboard.jsp?error=Reservation not found");
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
