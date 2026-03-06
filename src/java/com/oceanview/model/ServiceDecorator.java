package com.oceanview.model;

public abstract class ServiceDecorator implements ReservationService {
    protected ReservationService decoratedReservation;

    public ServiceDecorator(ReservationService decoratedReservation) {
        this.decoratedReservation = decoratedReservation;
    }

    @Override
    public String getDescription() {
        return decoratedReservation.getDescription();
    }

    @Override
    public double getCost() {
        return decoratedReservation.getCost();
    }
}
