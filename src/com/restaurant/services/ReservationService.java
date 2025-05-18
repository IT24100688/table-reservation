
package com.restaurant.service;

import com.restaurant.model.Reservation;

import javax.servlet.ServletContext;
import java.io.*;
import java.util.*;

public class ReservationService {

    public static void saveReservation(Reservation reservation, ServletContext context) {
        String filePath = context.getRealPath("/data/reservations.txt");
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(reservation.toFileString());
            writer.newLine();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    public static Queue<Reservation> getAllReservations(ServletContext context) {

        Queue<Reservation> queue = new LinkedList<>();
        String filePath = context.getRealPath("/data/reservations.txt");
        File file = new File(filePath);

        if (!file.exists()) return queue;

        try (BufferedReader reader = new BufferedReader(new FileReader(file))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length >= 8) {
                    String id = parts[0];
                    String hotelName = parts[1];
                    String date = parts[2];
                    String time = parts[3];
                    int guests = Integer.parseInt(parts[4]);
                    String name = parts[5];
                    String email = parts[6];
                    String phone = parts[7];
                    String tableType = (parts.length >= 9) ? parts[8] : "General";

                    Reservation r = new Reservation(id, hotelName, date, time, guests, name, email, phone,tableType);
                    queue.offer(r);
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return queue;
    }
    public static boolean isAvailable(String hotelName, String date, String time, ServletContext context) {
        Queue<Reservation> reservations = getAllReservations(context);

        for (Reservation r : reservations) {
            if (r.getHotelName().equalsIgnoreCase(hotelName)
                    && r.getDate().equals(date)
                    && r.getTime().equals(time)) {
                return false; // A reservation already exists at that time for that hotel
            }
        }

        return true; // No conflict found
    }

}
