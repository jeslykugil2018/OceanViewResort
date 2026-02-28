package com.oceanview.service;

import com.oceanview.model.Reservation;
import java.util.HashMap;
import java.util.Map;

/**
 * Concrete Visitor for Management Reporting
 * Aggregates revenue and occupancy data
 */
public class ManagementReportVisitor implements ReservationVisitor {
    private double totalRevenue = 0;
    private int totalReservations = 0;
    private Map<String, Integer> roomTypeOccupancy = new HashMap<>();

    @Override
    public void visit(Reservation reservation, String unused) {
        if (!"Cancelled".equals(reservation.getStatus())) {
            totalRevenue += reservation.getTotalCost();
            totalReservations++;

            String type = reservation.getRoomType();
            roomTypeOccupancy.put(type, roomTypeOccupancy.getOrDefault(type, 0) + 1);
        }
    }

    public double getTotalRevenue() {
        return totalRevenue;
    }

    public int getTotalReservations() {
        return totalReservations;
    }

    public Map<String, Integer> getRoomTypeOccupancy() {
        return roomTypeOccupancy;
    }

    public String getFormattedReport() {
        StringBuilder sb = new StringBuilder();
        sb.append("Management Summary Report\n");
        sb.append("-------------------------\n");
        sb.append("Total Revenue: Rs. ").append(totalRevenue).append("\n");
        sb.append("Total Active Reservations: ").append(totalReservations).append("\n");
        sb.append("Occupancy by Room Type:\n");
        for (Map.Entry<String, Integer> entry : roomTypeOccupancy.entrySet()) {
            sb.append("- ").append(entry.getKey()).append(": ").append(entry.getValue()).append(" bookings\n");
        }
        return sb.toString();
    }
}
