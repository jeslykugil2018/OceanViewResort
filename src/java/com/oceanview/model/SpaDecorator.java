package com.oceanview.model;

public class SpaDecorator extends ServiceDecorator {
    public SpaDecorator(ReservationService decoratedReservation) {
        super(decoratedReservation);
    }

    @Override
    public String getDescription() {
        return decoratedReservation.getDescription() + ", Spa";
    }

    @Override
    public double getCost() {
        return decoratedReservation.getCost() + 50.0;
    }
}
