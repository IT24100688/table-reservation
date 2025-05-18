package com.restaurant.service;

import com.restaurant.model.Reservation;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

public class MergeSort {

    public static void sort(List<Reservation> list) {
        if (list == null || list.size() <= 1) {
            return; // Already sorted or empty
        }
        sort(list, 0, list.size() - 1);
    }

    private static void sort(List<Reservation> list, int left, int right) {
        if (left < right) {
            int mid = left + (right - left) / 2; // Avoid potential overflow

            sort(list, left, mid);
            sort(list, mid + 1, right);
            merge(list, left, mid, right);
        }
    }

    private static void merge(List<Reservation> list, int left, int mid, int right) {
        // Create temporary lists
        List<Reservation> leftList = new ArrayList<>(list.subList(left, mid + 1));
        List<Reservation> rightList = new ArrayList<>(list.subList(mid + 1, right + 1));

        int i = 0, j = 0, k = left;

        // Merge the two lists in sorted order
        while (i < leftList.size() && j < rightList.size()) {
            Reservation a = leftList.get(i);
            Reservation b = rightList.get(j);

            if (compareByDateTime(a, b) <= 0) {
                list.set(k++, a);
                i++;
            } else {
                list.set(k++, b);
                j++;
            }
        }

        // Copy remaining elements from leftList (if any)
        while (i < leftList.size()) {
            list.set(k++, leftList.get(i++));
        }

        // Copy remaining elements from rightList (if any)
        while (j < rightList.size()) {
            list.set(k++, rightList.get(j++));
        }
    }

    // Compare reservations by date, then by time if dates are equal
    private static int compareByDateTime(Reservation r1, Reservation r2) {
        try {
            // Handle potential null values
            if (r1.getDate() == null) {
                return (r2.getDate() == null) ? 0 : -1;
            }
            if (r2.getDate() == null) {
                return 1;
            }

            // Compare dates first
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
            Date d1 = dateFormat.parse(r1.getDate());
            Date d2 = dateFormat.parse(r2.getDate());

            int dateComparison = d1.compareTo(d2);

            // If dates are equal, compare times
            if (dateComparison == 0) {
                return compareByTime(r1, r2);
            }

            return dateComparison;

        } catch (ParseException e) {
            // Log the error
            System.err.println("Error parsing date: " + e.getMessage());

            // Fall back to string comparison if parse fails
            int dateCompare = r1.getDate().compareTo(r2.getDate());
            if (dateCompare == 0) {
                return compareByTime(r1, r2);
            }
            return dateCompare;
        }
    }

    // Compare reservations by time
    private static int compareByTime(Reservation r1, Reservation r2) {
        if (r1.getTime() == null) {
            return (r2.getTime() == null) ? 0 : -1;
        }
        if (r2.getTime() == null) {
            return 1;
        }

        try {
            SimpleDateFormat timeFormat = new SimpleDateFormat("h:mm a");
            Date t1 = timeFormat.parse(r1.getTime());
            Date t2 = timeFormat.parse(r2.getTime());
            return t1.compareTo(t2);
        } catch (ParseException e) {
            // Fall back to string comparison if parse fails
            return r1.getTime().compareTo(r2.getTime());
        }
    }

    // Sort in descending order (latest first)
    public static void sortDescending(List<Reservation> list) {
        sort(list);
        Collections.reverse(list);
    }
}
