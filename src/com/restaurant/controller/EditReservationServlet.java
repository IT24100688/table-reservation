package com.restaurant.controller;

import com.restaurant.model.Reservation;
import com.restaurant.service.MergeSort;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

@WebServlet("/EditReservationServlet")
public class EditReservationServlet extends HttpServlet {

    private static final String FILE_PATH = "/data/reservations.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reservationId = request.getParameter("reservationId");
        String hotelName = request.getParameter("hotelName"); // Get hotel name from form
        String date = request.getParameter("date");
        String time = request.getParameter("time");
        int guests = 0;

        try {
            guests = Integer.parseInt(request.getParameter("guests"));
        } catch (NumberFormatException e) {
            // Handle invalid number format
            request.setAttribute("message", "Invalid number of guests!");
            request.getRequestDispatcher("JSP/viewAllReservations.jsp").forward(request, response);
            return;
        }

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String tableType = request.getParameter("tableType");

        // Debug output
        System.out.println("Editing reservation: " + reservationId);
        System.out.println("New values: date=" + date + ", time=" + time + ", guests=" + guests);

        String path = getServletContext().getRealPath(FILE_PATH);
        Queue<Reservation> updatedQueue = new LinkedList<>();
        boolean reservationFound = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
            String line;

            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");

                if (parts.length >= 9) {
                    if (parts[0].equals(reservationId)) {
                        // Replace with updated reservation
                        reservationFound = true;
                        Reservation updated = new Reservation(
                                reservationId,
                                parts[1],  // Keep original hotel name if not provided
                                date,
                                time,
                                guests,
                                name,
                                email,
                                phone,
                                tableType
                        );
                        updatedQueue.add(updated);
                        System.out.println("Updated reservation: " + updated.toFileString());
                    } else {
                        // Keep existing reservation
                        try {
                            Reservation existing = new Reservation(
                                    parts[0], parts[1], parts[2], parts[3],
                                    Integer.parseInt(parts[4]), parts[5], parts[6], parts[7], parts[8]
                            );
                            updatedQueue.add(existing);
                        } catch (NumberFormatException e) {
                            // Handle invalid number format in existing record
                            System.out.println("Warning: Skipping invalid reservation record: " + line);
                        }
                    }
                } else {
                    System.out.println("Warning: Skipping invalid line format: " + line);
                }
            }
        }

        if (!reservationFound) {
            request.setAttribute("message", "Reservation not found!");
            request.getRequestDispatcher("JSP/viewAllReservations.jsp").forward(request, response);
            return;
        }

        // Write updated queue back to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(path))) {
            for (Reservation r : updatedQueue) {
                writer.write(r.toFileString());
                writer.newLine();
            }
        }

        // After updating the reservations
        List<Reservation> reservationList = new ArrayList<>(updatedQueue);
        MergeSort.sort(reservationList); // Use the public sort method
        Queue<Reservation> sortedQueue = new LinkedList<>(reservationList);

        request.setAttribute("message", "Reservation updated successfully!");
        request.setAttribute("reservations", sortedQueue); // Use the sorted queue
        request.getRequestDispatcher("JSP/viewAllReservations.jsp").forward(request, response);

    }
}
