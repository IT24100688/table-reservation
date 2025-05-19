package com.restaurant.model;

import java.util.*;

public class HotelTableManager {
    private Map<String, Map<String, Queue<Table>>> hotelTables = new HashMap<>();

    public void addHotel(String hotelName) {
        Map<String, Queue<Table>> tableTypes = new HashMap<>();
        tableTypes.put("VIP", new LinkedList<>());
        tableTypes.put("Outdoor", new LinkedList<>());
        tableTypes.put("Family", new LinkedList<>());
        hotelTables.put(hotelName, tableTypes);
    }

    public Set<String> getAllHotelNames() {
        return hotelTables.keySet();
    }

    public void addTable(String hotelName, String type, int count) {
        if (!hotelTables.containsKey(hotelName)) return;
        Queue<Table> queue = hotelTables.get(hotelName).get(type);
        if (queue == null) return;
        for (int i = 0; i < count; i++) {
            queue.offer(new Table(type));
        }
    }

    public void removeTable(String hotelName, String type) {
        if (!hotelTables.containsKey(hotelName)) return;
        Queue<Table> queue = hotelTables.get(hotelName).get(type);
        if (queue == null || queue.isEmpty()) return;
        queue.poll();
    }

    public int getAvailableCount(String hotelName, String type) {
        if (!hotelTables.containsKey(hotelName)) return 0;
        Queue<Table> queue = hotelTables.get(hotelName).get(type);
        return queue != null ? queue.size() : 0;
    }

    public Map<String, Integer> getTableCounts(String hotelName) {
        Map<String, Integer> result = new HashMap<>();
        for (String type : Arrays.asList("VIP", "Outdoor", "Family")) {
            result.put(type, getAvailableCount(hotelName, type)); // returns 0 safely
        }
        return result;
    }
    public void removeHotel(String hotelName) {
        hotelTables.remove(hotelName);
    }

}
