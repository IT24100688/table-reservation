package com.restaurant.controller;

import com.restaurant.model.Hotel;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.*;
@WebServlet("/edit-hotel")
public class EditHotelDetails extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String originalName = request.getParameter("originalName");
        String name = request.getParameter("name");
        String description = request.getParameter("description");
        String imageUrl = request.getParameter("imageUrl");
        String featuresRaw = request.getParameter("features");

        List<String> features = Arrays.asList(featuresRaw.split(","));

        String filePath = getServletContext().getRealPath("/data/hotels.txt");
        List<Hotel> hotels = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                Hotel hotel = new Hotel(line);
                if (!hotel.getName().equalsIgnoreCase(originalName)) {
                    hotels.add(hotel);  // Keep all hotels except the one being edited
                }
            }
        }

        // Add the updated hotel (even if name changed)
        Hotel updatedHotel = new Hotel(name, description, "Colombo", imageUrl, features);
        hotels.add(updatedHotel);

        // Overwrite the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (Hotel h : hotels) {
                writer.write(String.format("%s|%s|%s|%s|%s",
                        h.getName(),
                        h.getDescription(),
                        h.getLocation(),
                        h.getImageUrl(),
                        String.join(",", h.getFeatures())
                ));
                writer.newLine();
            }
        }

        response.sendRedirect("admin-dashboard");  // ✅ Redirect back to admin panel
    }
}
