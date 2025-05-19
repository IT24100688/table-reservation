package com.restaurant.controller;

import java.io.*;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        // Path to credentials file (relative to webapp)
        String filePath = getServletContext().getRealPath("/data/AdminPasswords.txt");

        boolean isAuthenticated = false;

        try (BufferedReader reader = new BufferedReader(new FileReader(filePath))) {
            String line;
            while ((line = reader.readLine()) != null) {
                String[] parts = line.split(",");
                if (parts.length == 2) {
                    String fileUsername = parts[0].trim();
                    String filePassword = parts[1].trim();

                    if (username.equals(fileUsername) && password.equals(filePassword)) {
                        isAuthenticated = true;
                        break;
                    }
                }
            }
        }

        if (isAuthenticated) {
            HttpSession session = request.getSession();
            session.setAttribute("admin", true);

            // ✅ Redirect to servlet (which loads hotels and forwards to adminDashboard.jsp)
            response.sendRedirect("admin-dashboard");
        } else {
            // ❌ Show error in login page
            response.sendRedirect("JSP/adminLogin.jsp?error=invalid+username+or+password");
        }
    }
}
