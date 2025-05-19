<%@ page import="com.restaurant.model.HotelTableManager" %>
<%@ page import="java.util.Map" %>

<%
    String hotelName = request.getParameter("hotelName");
    String selectedDate = request.getParameter("selectedDate");
    String selectedTime = request.getParameter("selectedTime");
    String selectedGuests = request.getParameter("selectedGuests");

    // Get the manager from application scope
    HotelTableManager manager = (HotelTableManager) application.getAttribute("manager");

    // Redirect if manager is null
    if (manager == null) {
        response.sendRedirect(request.getContextPath() + "/InitServlet");
        return;
    }

    Map<String, Integer> tableCounts = manager.getTableCounts(hotelName);

    // Check if all table types have zero availability
    boolean allTablesUnavailable =
            (tableCounts.getOrDefault("VIP", 0) <= 0) &&
                    (tableCounts.getOrDefault("Family", 0) <= 0) &&
                    (tableCounts.getOrDefault("Outdoor", 0) <= 0);

    // Redirect to error page if all tables are unavailable
    if (allTablesUnavailable) {
        response.sendRedirect(request.getContextPath() + "/JSP/noTablesAvailable.jsp");
        return;
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Select Your Table | ReservEats</title>
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
            --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8fafc;
            color: #333;
            margin: 0;
            padding: 0;
        }

        .header {
            background: linear-gradient(to right, var(--primary-dark), var(--primary-light));
            color: white;
            padding: 40px 0;
            text-align: center;
            margin-bottom: 40px;
        }

        .header h1 {
            font-weight: 600;
            margin-bottom: 10px;
        }

        .header p {
            opacity: 0.9;
            font-weight: 300;
        }

        .container {
            max-width: 1200px;
            margin: 0 auto;
            padding: 0 20px;
        }

        .table-selection {
            display: flex;
            flex-wrap: wrap;
            gap: 30px;
            justify-content: center;
            margin-bottom: 50px;
        }

        .table-card {
            background: white;
            border-radius: 10px;
            box-shadow: var(--card-shadow);
            width: 320px;
            padding: 30px;
            text-align: center;
            transition: all 0.3s ease;
            border-top: 4px solid var(--primary-dark);
        }

        .table-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 20px rgba(0, 0, 0, 0.1);
        }

        .table-icon {
            font-size: 48px;
            color: var(--primary-dark);
            margin-bottom: 20px;
        }

        .table-card h3 {
            color: var(--primary-dark);
            font-weight: 600;
            margin-bottom: 15px;
        }

        .availability {
            font-size: 1.1rem;
            font-weight: 500;
            margin-bottom: 15px;
            color: var(--primary-light);
        }

        .no-availability {
            color: var(--accent-color);
        }

        .table-description {
            color: #666;
            margin-bottom: 25px;
            min-height: 60px;
        }

        .btn-book {
            background-color: var(--primary-dark);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 6px;
            font-weight: 500;
            transition: all 0.3s;
            width: 100%;
        }

        .btn-book:hover {
            background-color: var(--primary-light);
            transform: translateY(-2px);
        }

        .btn-book:disabled {
            background-color: #cccccc;
            cursor: not-allowed;
        }

        @media (max-width: 768px) {
            .table-card {
                width: 100%;
            }

            .header {
                padding: 30px 0;
            }
        }
    </style>
</head>
<body>
<div class="header">
    <div class="container">
        <h1>Select Your Table</h1>
        <p>Choose the perfect table for your dining experience at <%= hotelName %></p>
    </div>
</div>

<form action="reservationForm.jsp" method="post">
    <input type="hidden" name="hotelName" value="<%= hotelName %>">
    <input type="hidden" name="selectedDate" value="<%= selectedDate %>">
    <input type="hidden" name="selectedTime" value="<%= selectedTime %>">
    <input type="hidden" name="selectedGuests" value="<%= selectedGuests %>">

    <div class="container">
        <div class="table-selection">
            <!-- VIP Table -->
            <div class="table-card">
                <div class="table-icon">
                    <i class="fas fa-crown"></i>
                </div>
                <h3>VIP Table</h3>
                <div class="availability <%= tableCounts.getOrDefault("VIP", 0) <= 0 ? "no-availability" : "" %>">
                    Available: <%= tableCounts.getOrDefault("VIP", 0) %>
                </div>
                <p class="table-description">
                    Exclusive seating for special occasions. Enjoy privacy, premium service, and luxury ambiance.
                </p>
                <button type="submit" name="tableType" value="VIP" class="btn-book"
                        <%= tableCounts.getOrDefault("VIP", 0) <= 0 ? "disabled" : "" %>>
                    Book VIP Table
                </button>
            </div>

            <!-- Family Table -->
            <div class="table-card">
                <div class="table-icon">
                    <i class="fas fa-users"></i>
                </div>
                <h3>Family Table</h3>
                <div class="availability <%= tableCounts.getOrDefault("Family", 0) <= 0 ? "no-availability" : "" %>">
                    Available: <%= tableCounts.getOrDefault("Family", 0) %>
                </div>
                <p class="table-description">
                    Spacious and comfortable tables for families and groups. Perfect for sharing meals together.
                </p>
                <button type="submit" name="tableType" value="Family" class="btn-book"
                        <%= tableCounts.getOrDefault("Family", 0) <= 0 ? "disabled" : "" %>>
                    Book Family Table
                </button>
            </div>

            <!-- Outdoor Table -->
            <div class="table-card">
                <div class="table-icon">
                    <i class="fas fa-umbrella-beach"></i>
                </div>
                <h3>Outdoor Table</h3>
                <div class="availability <%= tableCounts.getOrDefault("Outdoor", 0) <= 0 ? "no-availability" : "" %>">
                    Available: <%= tableCounts.getOrDefault("Outdoor", 0) %>
                </div>
                <p class="table-description">
                    Enjoy the breeze while you savor your meal,
                    with comfortable seating and beautiful views of our outdoor space.
                </p>
                <button type="submit" name="tableType" value="Outdoor" class="btn-book"
                        <%= tableCounts.getOrDefault("Outdoor", 0) <= 0 ? "disabled" : "" %>>
                    Book Outdoor Table
                </button>
            </div>
        </div>
    </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>