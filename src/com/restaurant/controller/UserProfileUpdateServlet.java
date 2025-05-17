package com.restaurant.controller;

import com.restaurant.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/update-profile")
public class UserProfileUpdateServlet extends HttpServlet {

    private final String USERS_FILE = "/data/users.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Display the update form with current user data
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("Signup.jsp");
            return;
        }

        // Get user's email from session
        String userEmail = (String) session.getAttribute("email");

        // Get user's details from users.txt to ensure we have the latest data
        String filePath = getServletContext().getRealPath(USERS_FILE);

        System.out.println("Profile update GET - Looking for user data at: " + filePath);

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = User.fromLine(line);
                if (user != null && user.getEmail().equalsIgnoreCase(userEmail)) {
                    // Set user details in session
                    session.setAttribute("name", user.getName());
                    session.setAttribute("phone", user.getPhone());
                    session.setAttribute("address", user.getAddress());

                    System.out.println("Profile update form - Address loaded: " + user.getAddress());
                    break;
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error reading user file in profile update GET: " + e.getMessage());
        }

        // Forward to the update profile JSP
        request.getRequestDispatcher("JSP/updateProfile.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("email") == null) {
            response.sendRedirect("Signup.jsp");
            return;
        }

        // Get current user email (for identification)
        String currentEmail = (String) session.getAttribute("email");

        // Get updated profile information
        String name = request.getParameter("name");
        String phone = request.getParameter("phone");
        String address = request.getParameter("address");
        String password = request.getParameter("password");

        System.out.println("Processing profile update for: " + currentEmail);
        System.out.println("New address received: " + address);

        // Load all users
        String filePath = getServletContext().getRealPath(USERS_FILE);
        List<User> users = loadUsers(filePath);

        // Find and update the current user
        boolean userFound = false;
        for (int i = 0; i < users.size(); i++) {
            User user = users.get(i);
            if (user.getEmail().equalsIgnoreCase(currentEmail)) {
                // Update user information
                user.setName(name);
                user.setPhone(phone);
                user.setAddress(address); // Set the address from the form
                if (password != null && !password.trim().isEmpty()) {
                    user.setPassword(password);
                }
                users.set(i, user);
                userFound = true;

                // Update session attributes
                session.setAttribute("name", name);
                session.setAttribute("phone", phone);
                session.setAttribute("address", address);

                System.out.println("User found and updated. New address: " + user.getAddress());
                break;
            }
        }

        if (userFound) {
            // Save all users back to file
            saveUsers(users, filePath);
            session.setAttribute("successMessage", "Profile updated successfully!");
        } else {
            request.setAttribute("errorMessage", "User not found!");
            System.out.println("User not found with email: " + currentEmail);
        }

        // Redirect to user dashboard
        response.sendRedirect("user-dashboard");
    }

    private List<User> loadUsers(String filePath) {
        List<User> users = new ArrayList<>();
        File file = new File(filePath);

        if (!file.exists()) {
            System.out.println("Users file does not exist at: " + filePath);
            try {
                file.getParentFile().mkdirs();
                file.createNewFile();
                System.out.println("Created new users file");
            } catch (IOException e) {
                e.printStackTrace();
            }
            return users;
        }

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                User user = User.fromLine(line);
                if (user != null) {
                    users.add(user);
                    System.out.println("Loaded user: " + user.getEmail() + ", Address: " + user.getAddress());
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error loading users: " + e.getMessage());
        }
        return users;
    }

    private void saveUsers(List<User> users, String filePath) {
        try (PrintWriter writer = new PrintWriter(new FileWriter(filePath))) {
            for (User user : users) {
                writer.println(user.toFileFormat());
            }
            System.out.println("Saved " + users.size() + " users to file with pipe separator");
        } catch (IOException e) {
            e.printStackTrace();
            System.out.println("Error saving users to file: " + e.getMessage());
        }
    }
}
