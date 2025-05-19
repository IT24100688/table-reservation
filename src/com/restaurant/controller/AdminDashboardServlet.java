package com.restaurant.controller;

import com.restaurant.model.Hotel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;

@WebServlet("/admin-dashboard")
public class AdminDashboardServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String filePath = getServletContext().getRealPath("/data/hotels.txt");
        List<Hotel> hotelList = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|", 5); // Split into exactly 5 parts
                if (parts.length >= 5) {
                    String name = parts[0];
                    String description = parts[1];
                    String location = parts[2];
                    String imageUrl = parts[3];
                    List<String> features = Arrays.asList(parts[4].split(","));
                    hotelList.add(new Hotel(name, description, location, imageUrl, features));
                }
            }
        }

        request.setAttribute("hotels", hotelList);
        request.getRequestDispatcher("JSP/adminDashboard.jsp").forward(request, response);
    }
}
