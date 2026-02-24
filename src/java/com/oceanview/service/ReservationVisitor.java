package com.oceanview.service;

import com.oceanview.model.Reservation;

/**
 * Visitor Pattern for PDF generation
 */
public interface ReservationVisitor {
    void visit(Reservation reservation, String filePath);
}
