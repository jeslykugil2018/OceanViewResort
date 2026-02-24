package com.oceanview.model;

public class AirportPickupDecorator extends ServiceDecorator {
    public AirportPickupDecorator(ReservationService decoratedReservation) {
        super(decoratedReservation);
    }

    @Override
    public String getDescription() {
        return decoratedReservation.getDescription() + ", Airport Pickup";
    }

    @Override
    public double getCost() {
        return decoratedReservation.getCost() + 25.0;
    }
}
