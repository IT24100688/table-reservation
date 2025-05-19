package com.restaurant.controller;

import com.restaurant.model.Reservation;
import com.restaurant.service.MergeSort;
import com.restaurant.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;

@WebServlet("/delete-reservation")
public class DeleteReservationServlet extends HttpServlet {

    private static final String FILE_PATH = "/data/reservations.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reservationId = request.getParameter("reservationId");

        if (reservationId == null || reservationId.isEmpty()) {
            request.setAttribute("message", "Reservation ID is required");
            request.getRequestDispatcher("JSP/viewAllReservations.jsp").forward(request, response);
            return;
        }

        String path = getServletContext().getRealPath(FILE_PATH);
        Queue<Reservation> updatedQueue = new LinkedList<>();
        boolean reservationFound = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(path))) {
            String line;

            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");

                if (parts.length >= 9) {
                    // Skip the reservation to be deleted
                    if (parts[0].equals(reservationId)) {
                        reservationFound = true;
                        continue;
                    }

                    // Keep all other reservations
                    updatedQueue.add(new Reservation(
                            parts[0], parts[1], parts[2], parts[3],
                            Integer.parseInt(parts[4]), parts[5], parts[6], parts[7], parts[8]
                    ));
                }
            }
        }

        if (!reservationFound) {
            request.setAttribute("message", "Reservation not found");
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

        // Sort the reservations by proximity to current date
        List<Reservation> reservationList = new ArrayList<>(updatedQueue);
        MergeSort.sort(reservationList);
        Queue<Reservation> sortedQueue = new LinkedList<>(reservationList);

        request.setAttribute("message", "Reservation deleted successfully!");
        request.setAttribute("reservations", sortedQueue);
        request.getRequestDispatcher("JSP/viewAllReservations.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doPost(request, response);
    }
}
