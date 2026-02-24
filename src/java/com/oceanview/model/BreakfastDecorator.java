package com.oceanview.model;

public class BreakfastDecorator extends ServiceDecorator {
    public BreakfastDecorator(ReservationService decoratedReservation) {
        super(decoratedReservation);
    }

    @Override
    public String getDescription() {
        return decoratedReservation.getDescription() + ", Breakfast";
    }

    @Override
    public double getCost() {
        return decoratedReservation.getCost() + 15.0;
    }
}
