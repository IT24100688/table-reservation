package com.restaurant.controller;


import com.restaurant.model.Hotel;
import com.restaurant.utils.FileUtil;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;
import java.util.List;

@WebServlet("/booking")
public class BookingServlet extends HttpServlet {
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String hotelName = request.getParameter("hotelName");
        if (hotelName == null || hotelName.isEmpty()) {
            response.sendRedirect("JSP/searchRestaurants.jsp");
            return;
        }

        String filePath = getServletContext().getRealPath("/data/hotels.txt");
        BufferedReader reader = new BufferedReader(new FileReader(filePath));
        String line;
        Hotel hotel = null;

        while ((line = reader.readLine()) != null) {
            Hotel h = new Hotel(line);
            if (h.getName().equalsIgnoreCase(hotelName)) {
                hotel = h;
                break;
            }
        }
        reader.close();

        if (hotel == null) {
            response.sendRedirect("JSP/searchRestaurants.jsp");
            return;
        }

        request.setAttribute("selectedHotel", hotel);
        request.getRequestDispatcher("JSP/booking.jsp").forward(request, response);
    }
}

