package com.oceanview.model;

import java.util.Date;

/**
 * Builder Pattern for Reservation Objects
 */
public class ReservationBuilder {
    private Reservation reservation;

    public ReservationBuilder() {
        this.reservation = new Reservation();
    }

    public ReservationBuilder setGuestId(int guestId) {
        reservation.setGuestId(guestId);
        return this;
    }

    public ReservationBuilder setRoomId(int roomId) {
        reservation.setRoomId(roomId);
        return this;
    }

    public ReservationBuilder setGuestName(String guestName) {
        reservation.setGuestName(guestName);
        return this;
    }

    public ReservationBuilder setGuestAddress(String guestAddress) {
        reservation.setGuestAddress(guestAddress);
        return this;
    }

    public ReservationBuilder setGuestContact(String guestContact) {
        reservation.setGuestContact(guestContact);
        return this;
    }

    public ReservationBuilder setRoomType(String roomType) {
        reservation.setRoomType(roomType);
        return this;
    }

    public ReservationBuilder setCheckIn(Date checkIn) {
        reservation.setCheckIn(checkIn);
        return this;
    }

    public ReservationBuilder setCheckOut(Date checkOut) {
        reservation.setCheckOut(checkOut);
        return this;
    }

    public ReservationBuilder setServices(String services) {
        reservation.setServices(services);
        return this;
    }

    public ReservationBuilder setTotalCost(double totalCost) {
        reservation.setTotalCost(totalCost);
        return this;
    }

    public ReservationBuilder setRoomRate(double roomRate) {
        reservation.setRoomRate(roomRate);
        return this;
    }

    public Reservation build() {
        reservation.setStatus("Confirmed");
        return reservation;
    }
}
