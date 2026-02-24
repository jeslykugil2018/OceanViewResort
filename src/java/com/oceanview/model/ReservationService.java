package com.oceanview.model;

/**
 * Decorator Pattern for adding optional services to reservations
 */
public interface ReservationService {
    String getDescription();

    double getCost();
}
