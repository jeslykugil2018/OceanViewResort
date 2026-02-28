package com.oceanview.service;

import java.text.SimpleDateFormat;
import java.util.Date;

/**
 * Chain of Responsibility Pattern for Validation
 */
public abstract class ValidationHandler {
    protected ValidationHandler next;

    public void setNext(ValidationHandler next) {
        this.next = next;
    }

    public abstract boolean validate(String value);

    protected boolean checkNext(String value) {
        if (next == null) {
            return true;
        }
        return next.validate(value);
    }

    /**
     * Factory method to get a standard validation chain
     */
    public static ValidationHandler getBasicChain() {
        ValidationHandler empty = new NotEmptyHandler();
        ValidationHandler email = new EmailHandler();
        empty.setNext(email);
        return empty;
    }

    /**
     * Factory method for date validation
     */
    public static ValidationHandler getDateChain() {
        ValidationHandler empty = new NotEmptyHandler();
        ValidationHandler date = new DateHandler();
        empty.setNext(date);
        return empty;
    }

    /**
     * Factory method for name validation
     */
    public static ValidationHandler getNameChain() {
        return new NotEmptyHandler();
    }
}

class NotEmptyHandler extends ValidationHandler {
    @Override
    public boolean validate(String value) {
        if (value == null || value.trim().isEmpty()) {
            return false;
        }
        return checkNext(value);
    }
}

class EmailHandler extends ValidationHandler {
    @Override
    public boolean validate(String value) {
        if (value == null || !value.contains("@") || !value.contains(".")) {
            return false;
        }
        return checkNext(value);
    }
}

class DateHandler extends ValidationHandler {
    @Override
    public boolean validate(String value) {
        try {
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            sdf.setLenient(false);
            Date date = sdf.parse(value);
            // Ensure date is not in the past
            if (date.before(new Date(System.currentTimeMillis() - 86400000))) {
                return false;
            }
            return checkNext(value);
        } catch (Exception e) {
            return false;
        }
    }
}
