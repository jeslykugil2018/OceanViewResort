package com.oceanview.service;

import com.oceanview.model.Reservation;
import java.text.SimpleDateFormat;

/**
 * Concrete Visitor for CSV Report Generation
 */
public class CSVVisitor implements ReservationVisitor {
    private StringBuilder csvContent;
    private SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

    public CSVVisitor() {
        csvContent = new StringBuilder();
        // CSV Header
        csvContent.append(
                "Reservation #,Guest ID,Guest Name,Room ID,Room Type,Check-In,Check-Out,Services,Total Cost,Status\n");
    }

    @Override
    public void visit(Reservation res, String unused) {
        csvContent.append(res.getReservationNumber()).append(",");
        csvContent.append(res.getGuestId()).append(",");
        csvContent.append("\"").append(res.getGuestName()).append("\",");
        csvContent.append(res.getRoomId()).append(",");
        csvContent.append("\"").append(res.getRoomType()).append("\",");
        csvContent.append(sdf.format(res.getCheckIn())).append(",");
        csvContent.append(sdf.format(res.getCheckOut())).append(",");
        csvContent.append("\"").append(res.getServices() == null ? "" : res.getServices().trim()).append("\",");
        csvContent.append(res.getTotalCost()).append(",");
        csvContent.append(res.getStatus()).append("\n");
    }

    public String getCsvContent() {
        return csvContent.toString();
    }
}
