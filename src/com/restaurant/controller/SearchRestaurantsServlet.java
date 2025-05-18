package com.restaurant.controller;

import com.restaurant.utils.FileUtil;
import com.restaurant.model.Hotel;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;


@WebServlet("/search-restaurants")
public class SearchRestaurantsServlet extends HttpServlet {
    private static final String FILE_PATH = "/data/hotels.txt";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullPath = getServletContext().getRealPath(FILE_PATH);
        List<Hotel> hotels = FileUtil.readHotelsFromFile(fullPath);

        request.setAttribute("hotels", hotels);
        request.getRequestDispatcher("/JSP/searchRestaurants.jsp").forward(request, response);
    }
}


