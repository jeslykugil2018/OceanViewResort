package com.oceanview.service;

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
        if (!value.contains("@")) {
            return false;
        }
        return checkNext(value);
    }
}
