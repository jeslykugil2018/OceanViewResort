package com.oceanview.model;

/**
 * Factory Pattern for Room Objects
 */
public class RoomFactory {
    public static Room createRoom(String roomNumber, String type, double price) {
        // Simple factory implementation
        return new Room(0, roomNumber, type, "Available", price);
    }
}
