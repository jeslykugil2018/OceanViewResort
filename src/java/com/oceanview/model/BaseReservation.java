package com.oceanview.model;

public class BaseReservation implements ReservationService {
    private double basePrice;

    public BaseReservation(double basePrice) {
        this.basePrice = basePrice;
    }

    @Override
    public String getDescription() {
        return "Room Reservation";
    }

    @Override
    public double getCost() {
        return basePrice;
    }
}
