package com.oceanview.service;

import java.util.Iterator;
import java.util.List;

/**
 * Iterator Pattern implementation for Room/Reservation collections
 */
public class CollectionIterator<T> implements Iterator<T> {
    private List<T> items;
    private int position = 0;

    public CollectionIterator(List<T> items) {
        this.items = items;
    }

    @Override
    public boolean hasNext() {
        return position < items.size();
    }

    @Override
    public T next() {
        return items.get(position++);
    }
}
