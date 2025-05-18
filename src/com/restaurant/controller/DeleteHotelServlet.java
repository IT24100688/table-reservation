package com.restaurant.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/delete-hotel")
public class DeleteHotelServlet extends HttpServlet {

    private static final String HOTELS_FILE = "/data/hotels.txt";
    private static final String TABLE_DATA_FILE = "/data/tableData.txt";

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String hotelName = request.getParameter("hotelName");

        if (hotelName == null || hotelName.isEmpty()) {
            request.setAttribute("message", "Hotel name is required");
            request.getRequestDispatcher("JSP/hotelList.jsp").forward(request, response);
            return;
        }

        // Delete from hotels.txt
        deleteFromFile(getServletContext().getRealPath(HOTELS_FILE), hotelName);

        // Delete from tableData.txt
        deleteFromFile(getServletContext().getRealPath(TABLE_DATA_FILE), hotelName);

        // Also need to update the HotelTableManager in the ServletContext
        updateHotelTableManager(hotelName);

        request.setAttribute("message", "Hotel deleted successfully!");
        response.sendRedirect("admin-dashboard");
    }

    private void deleteFromFile(String filePath, String hotelName) throws IOException {
        List<String> remainingLines = new ArrayList<>();

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split("\\|");
                // Skip the line if it starts with the hotel name
                if (parts.length > 0 && !parts[0].equals(hotelName)) {
                    remainingLines.add(line);
                }
            }
        }

        // Write the remaining lines back to the file
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath))) {
            for (String line : remainingLines) {
                writer.write(line);
                writer.newLine();
            }
        }
    }

    private void updateHotelTableManager(String hotelName) {
        // Get the current manager from context
        com.restaurant.model.HotelTableManager manager =
                (com.restaurant.model.HotelTableManager) getServletContext().getAttribute("manager");

        if (manager != null) {
            // Remove the hotel from the manager
            manager.removeHotel(hotelName);

            // Update the context
            getServletContext().setAttribute("manager", manager);
        }
    }
}
