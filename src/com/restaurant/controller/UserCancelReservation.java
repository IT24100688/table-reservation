package com.restaurant.controller;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/cancel-reservation")
public class UserCancelReservation extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private static final String RESERVATIONS_FILE = "reservations.txt";

    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String userEmail = (String) session.getAttribute("email");

        if (userEmail == null || userEmail.isEmpty()) {
            response.sendRedirect("Signup.jsp");
            return;
        }

        // Get reservation ID from form
        String reservationId = request.getParameter("reservationId");
        System.out.println("Attempting to cancel reservation: " + reservationId + " for user: " + userEmail);

        // Get the reservations file
        String reservationsFilePath = getServletContext().getRealPath("/data/" + RESERVATIONS_FILE);
        File reservationsFile = new File(reservationsFilePath);

        // Read all reservations
        List<String> reservations = new ArrayList<>();
        boolean reservationCancelled = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(reservationsFile))) {
            String line;
            while ((line = reader.readLine()) != null) {
                // Format: RES1746962073022,City View Suites,2025-05-05,8:30 PM,8,Ranuda Perera,ranudaperera@gmail.com,0786903375,VIP Table
                String[] parts = line.split(",");

                // Only skip the specific reservation that matches both ID and user email
                if (parts.length >= 7 && parts[0].equals(reservationId) && parts[6].equals(userEmail)) {
                    reservationCancelled = true;
                    continue; // Skip this line
                }

                // Add all other lines
                reservations.add(line);
            }
        }

        // Write updated reservations back to file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(reservationsFile))) {
            for (String reservation : reservations) {
                writer.write(reservation);
                writer.newLine();
            }
        }

        if (reservationCancelled) {
            session.setAttribute("successMessage", "Reservation cancelled successfully");
        } else {
            session.setAttribute("errorMessage", "Could not find your reservation");
        }

        response.sendRedirect("user-dashboard");
    }
}

