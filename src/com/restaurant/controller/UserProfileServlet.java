package com.restaurant.controller;

import com.restaurant.model.User;
import com.restaurant.model.Reservation;
import com.restaurant.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/user-dashboard")
public class UserProfileServlet extends HttpServlet {
    private final String USERS_FILE = "/data/users.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("Signup.jsp");
            return;
        }

        // Get user's email from session
        String userEmail = (String) session.getAttribute("email");

        System.out.println("Loading dashboard for user: " + userEmail);

        // Get user's reservations
        Queue<Reservation> allReservations = ReservationService.getAllReservations(getServletContext());
        List<Reservation> userReservations = new ArrayList<>();

        // Filter reservations for current user
        for (Reservation r : allReservations) {
            if (r.getEmail().equalsIgnoreCase(userEmail)) {
                userReservations.add(r);
            }
        }

        // Get user's details from users.txt to ensure we have the latest data
        String filePath = getServletContext().getRealPath(USERS_FILE);

        System.out.println("Looking for user data at: " + filePath);

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = User.fromLine(line);
                if (user != null && user.getEmail().equalsIgnoreCase(userEmail)) {
                    // Set user details in session
                    session.setAttribute("name", user.getName());
                    session.setAttribute("phone", user.getPhone());
                    session.setAttribute("address", user.getAddress());

                    System.out.println("User found in dashboard: " + user.getName());
                    System.out.println("Address loaded: " + user.getAddress());
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error reading user file: " + e.getMessage());
        }

        // Set reservations in request and forward to profile page
        request.setAttribute("reservations", userReservations);
        request.getRequestDispatcher("JSP/userProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Handle form submissions if needed
        doGet(request, response);
    }
}