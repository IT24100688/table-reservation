package com.restaurant.controller;

import com.restaurant.model.HotelTableManager;
import com.restaurant.model.Reservation;
import com.restaurant.service.ReservationService;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;

@WebServlet("/ReservationServlet")
public class ReservationServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String reservationId = "RES" + System.currentTimeMillis();

        // Get form parameters
        String date = request.getParameter("selectedDate");
        String time = request.getParameter("selectedTime");
        String guestParam = request.getParameter("selectedGuests");
        int guests = 1;

        try {
            if (guestParam != null && !guestParam.equals("null") && !guestParam.isEmpty()) {
                guests = Integer.parseInt(guestParam);
            }
        } catch (NumberFormatException e) {
            e.printStackTrace(); // fallback to default 1
        }

        // Get hotel name and other details
        HttpSession session = request.getSession();
        String hotelName = request.getParameter("hotelName");
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String phone = request.getParameter("phone");
        String tableType = request.getParameter("tableType");

        // Get the table type without "Table" suffix if present
        String tableCategory = tableType;
        if (tableType.endsWith(" Table")) {
            tableCategory = tableType.substring(0, tableType.length() - 6);
        }

        // Get hotel table manager
        HotelTableManager manager = (HotelTableManager) getServletContext().getAttribute("manager");

        // Check if the table is available
        int availableTables = manager.getAvailableCount(hotelName, tableCategory);

        if (availableTables <= 0) {
            // No tables available, redirect to error page
            response.sendRedirect(request.getContextPath() + "/JSP/noTablesAvailable.jsp");
            return;
        }

        Reservation reservation = new Reservation(
                reservationId, hotelName, date, time, guests, name, email, phone, tableType
        );

        if (ReservationService.isAvailable(hotelName, date, time, getServletContext())) {
            // Save the reservation
            ReservationService.saveReservation(reservation, getServletContext());

            // Decrease table count
            manager.removeTable(hotelName, tableCategory);

            // Save updated table counts
            saveTableDataToFile(manager);

            // Set session attributes for confirmation
            session.setAttribute("reservationID", reservationId);
            session.setAttribute("hotelName", hotelName);
            session.setAttribute("date", date);
            session.setAttribute("time", time);
            session.setAttribute("guests", String.valueOf(guests));
            session.setAttribute("name", name);
            session.setAttribute("email", email);
            session.setAttribute("phone", phone);
            session.setAttribute("tableType", tableType);

            response.sendRedirect("JSP/ReservationConfirm.jsp");
        } else {
            response.sendRedirect("JSP/fullyBooked.jsp");
        }
    }

    // Reuse the save method from ManageTablesServlet
    private void saveTableDataToFile(HotelTableManager manager) {
        String path = getServletContext().getRealPath("/data/tableData.txt");
        System.out.println("Saving to file: " + path);

        try (java.io.BufferedWriter writer = new java.io.BufferedWriter(new java.io.FileWriter(path))) {
            for (String hotel : manager.getAllHotelNames()) {
                java.util.Map<String, Integer> counts = manager.getTableCounts(hotel);

                int vip = counts.get("VIP") != null ? counts.get("VIP") : 0;
                int family = counts.get("Family") != null ? counts.get("Family") : 0;
                int outdoor = counts.get("Outdoor") != null ? counts.get("Outdoor") : 0;

                String line = hotel + "|VIP:" + vip + "|Family:" + family + "|Outdoor:" + outdoor;
                writer.write(line);
                writer.newLine();
            }
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
}