package com.restaurant.controller;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.*;

@WebServlet("/SignUpServlet")
public class SignUpServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String number = request.getParameter("number");
        String password = request.getParameter("password");

        // Resolve file path relative to the deployed context
        String filePath = getServletContext().getRealPath("/data/users.txt");

        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(name + "|" + email + "|" + number + "|" + password);
            writer.newLine();
        }

        response.sendRedirect("JSP/Signup.jsp");
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.sendRedirect("jsp/Signup.jsp");
    }
}
