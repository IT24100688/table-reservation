<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>

<%
    String filePath = application.getRealPath("/") + "data/feedbacks.txt";
    File file = new File(filePath);
    String feedbacks = "";

    if (file.exists()) {
        BufferedReader reader = new BufferedReader(new FileReader(file));
        String line;
        while ((line = reader.readLine()) != null) {
            feedbacks += line + "<br>";
        }
        reader.close();
    } else {
        feedbacks = "No feedback yet.";
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User Feedback | ReservEats</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-dark: #141E30;
            --primary-light: #243B55;
            --accent-color: #d32f2f;
            --accent-hover: #b71c1c;
            --text-light: #f8f9fa;
            --sidebar-width: 250px;
            --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8fafc;
            color: #333;
        }

        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            background: linear-gradient(to bottom, var(--primary-dark), var(--primary-light));
            color: white;
            position: fixed;
            padding: 20px 0;
            box-shadow: 2px 0 10px rgba(0, 0, 0, 0.1);
            z-index: 1000;
        }

        .sidebar-brand {
            padding: 10px 20px;
            margin-bottom: 30px;
            text-align: center;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }

        .sidebar-brand h3 {
            color: white;
            font-weight: 600;
            margin: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }

        .sidebar-brand i {
            margin-right: 10px;
            font-size: 1.5rem;
        }

        .sidebar-menu {
            list-style: none;
            padding: 0 15px;
        }

        .sidebar-menu li {
            margin-bottom: 5px;
            border-radius: 5px;
            overflow: hidden;
        }

        .sidebar-menu a {
            display: flex;
            align-items: center;
            color: rgba(255, 255, 255, 0.8);
            padding: 12px 15px;
            text-decoration: none;
            transition: all 0.3s;
            border-left: 3px solid transparent;
            font-weight: 500;
        }

        .sidebar-menu a:hover, .sidebar-menu a.active {
            background: rgba(255, 255, 255, 0.1);
            border-left: 3px solid var(--accent-color);
            color: white;
            transform: translateX(5px);
        }

        .sidebar-menu i {
            margin-right: 12px;
            width: 20px;
            text-align: center;
            font-size: 1.1rem;
        }

        .main-content {
            margin-left: var(--sidebar-width);
            padding: 30px;
            min-height: 100vh;
        }

        .page-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 30px;
            padding-bottom: 15px;
            border-bottom: 1px solid #eaeaea;
        }

        .page-header h2 {
            color: var(--primary-dark);
            font-weight: 600;
            margin: 0;
        }

        .feedback-container {
            background: white;
            border-radius: 10px;
            box-shadow: var(--card-shadow);
            padding: 30px;
        }

        .feedback-item {
            margin-bottom: 25px;
            padding-bottom: 25px;
            border-bottom: 1px solid #f0f0f0;
        }

        .feedback-item:last-child {
            margin-bottom: 0;
            padding-bottom: 0;
            border-bottom: none;
        }

        .no-feedback {
            text-align: center;
            padding: 50px;
            color: #6c757d;
        }

        .no-feedback i {
            font-size: 3rem;
            margin-bottom: 20px;
            color: #dee2e6;
        }

        @media (max-width: 768px) {
            .sidebar {
                width: 70px;
                overflow: hidden;
            }
            .sidebar-brand h3 span {
                display: none;
            }
            .sidebar-menu a span {
                display: none;
            }
            .sidebar-menu i {
                margin-right: 0;
                font-size: 1.3rem;
            }
            .main-content {
                margin-left: 70px;
                padding: 20px;
            }
        }
    </style>
</head>
<body>

<!-- Sidebar -->
<div class="sidebar">
    <div class="sidebar-brand">
        <h3><i class="fas fa-utensils"></i> <span>ReservEats</span></h3>
    </div>
    <ul class="sidebar-menu">

        <li><a href="<%=request.getContextPath()%>/admin-dashboard"><i class="fas fa-hotel"></i> <span>Manage Hotels</span></a></li>
        <li><a href="<%= request.getContextPath() %>/admin/table-availability"><i class="fas fa-chair"></i> <span>Table Availability</span></a></li>
        <li><a href="<%= request.getContextPath() %>/ViewAllReservationsServlet"><i class="fas fa-calendar-check"></i> <span>Reservations</span></a></li>
        <li><a href="<%= request.getContextPath() %>/JSP/viewFeedback.jsp" class="active"><i class="fas fa-comment-dots"></i> <span>Feedbacks</span></a></li>
        <li><a href="<%= request.getContextPath()%>/JSP/Logout.jsp"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a></li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="page-header">
        <h2><i class="fas fa-comment-dots me-2"></i>Customer Feedback</h2>
    </div>

    <div class="feedback-container">
        <% if (file.exists()) {
            String[] feedbackList = feedbacks.split("<br>");
            for (String feedback : feedbackList) {
                if (!feedback.trim().isEmpty()) {
        %>
        <div class="feedback-item">
            <%= feedback %>
        </div>
        <%      }
        }
        } else { %>
        <div class="no-feedback">
            <i class="fas fa-comment-slash"></i>
            <h4>No Feedback Yet</h4>
            <p>Customer feedback will appear here when submitted</p>
        </div>
        <% } %>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Add active class to current menu item
    document.addEventListener('DOMContentLoaded', function() {
        const currentPage = window.location.pathname.split('/').pop();
        const menuItems = document.querySelectorAll('.sidebar-menu a');

        menuItems.forEach(item => {
            if (item.getAttribute('href').includes(currentPage)) {
                item.classList.add('active');
            }
        });
    });
</script>
</body>
</html>