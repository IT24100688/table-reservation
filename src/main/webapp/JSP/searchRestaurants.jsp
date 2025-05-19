<%@ page import="java.util.List" %>
<%@ page import="com.restaurant.model.Hotel" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Hotel Reservation</title>
    <style>
        * {
            padding: 0;
            margin: 0;
            box-sizing: border-box;
            font-family: 'Poppins', sans-serif;
        }

        :root {
            --linear-grad: linear-gradient(to right, #141E30, #243B55);
            --grad-clr1: #141E30;
            --grad-clr2: #243B55;
            --accent-color: #d32f2f;
            --accent-hover: #b71c1c;
        }

        body {
            height: 100vh;
            background: #f6f5f7;
            display: flex;
            flex-direction: column;
            align-items: center;
            padding: 40px 0;
        }

        h1 {
            color: var(--grad-clr1);
            margin-bottom: 30px;
            font-size: 28px;
            font-weight: 600;
        }

        .container {
            display: flex;
            justify-content: center;
            gap: 30px;
            flex-wrap: wrap;
            max-width: 1200px;
            padding: 0 20px;
        }

        .hotel-card {
            background: white;
            display: flex;
            flex-direction: column;
            border-radius: 13px;
            box-shadow: 25px 30px 55px #5557;
            overflow: hidden;
            width: 350px;
            height: 450px;
            transition: transform 0.3s ease;
        }

        .hotel-card:hover {
            transform: translateY(-10px);
        }

        .hotel-card img {
            width: 100%;
            height: 220px;
            object-fit: cover;
        }

        .hotel-card .content {
            padding: 25px;
            flex-grow: 1;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
        }

        .hotel-card h3 {
            margin: 0 0 15px 0;
            color: var(--grad-clr1);
            font-size: 22px;
            font-weight: 600;
        }

        .hotel-card p {
            font-size: 15px;
            color: #666;
            line-height: 1.6;
            margin-bottom: 20px;
        }

        .book-btn {
            display: block;
            padding: 12px 25px;
            background: var(--grad-clr2);
            color: white;
            text-align: center;
            text-decoration: none;
            font-weight: 600;
            border-radius: 20px;
            border: none;
            font-size: 15px;
            cursor: pointer;
            letter-spacing: 0.5px;
            transition: all 0.3s ease;
            align-self: center;
            width: 80%;
            margin-top: auto;
        }

        .book-btn:hover {
            background: var(--grad-clr1);
            transform: scale(1.05);
        }

        .hotel-features {
            display: flex;
            justify-content: space-between;
            font-size: 13px;
            color: #888;
            margin-top: -10px;
            margin-bottom: 10px;
            flex-wrap: wrap;
            gap: 10px;
        }

        .feature {
            display: flex;
            align-items: center;
            gap: 5px;
        }

        .feature i {
            color: var(--accent-color);
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css">
</head>
<body>
<h1>Select Your Perfect Hotel</h1>
<div class="container">
    <%
        List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
        if (hotels != null && !hotels.isEmpty()) {
            for (Hotel hotel : hotels) {
    %>
    <div class="hotel-card">
        <img src="<%= hotel.getImageUrl() %>" alt="<%= hotel.getName() %>">
        <div class="content">
            <h3><%= hotel.getName() %></h3>
            <p><%= hotel.getDescription() %></p>
            <div class="hotel-features">
                <%
                    for (String feature : hotel.getFeatures()) {
                %>
                <div class="feature">
                    <i class="fas fa-check-circle"></i> <%= feature %>
                </div>
                <% } %>
            </div>

            <a href="booking?hotelName=<%= hotel.getName() %>" class="book-btn">Book Now</a>



        </div>
    </div>
    <%
        }
    } else {
    %>
    <p>No hotels found.</p>
    <%
        }
    %>
</div>
</body>
</html>
