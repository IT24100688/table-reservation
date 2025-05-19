<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.*, com.restaurant.model.Reservation, com.restaurant.model.User, com.restaurant.service.ReservationService" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>User Dashboard</title>
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            background: #f6f5f7;
            display: flex;
            height: 100vh;
        }
        input[readonly] {
            cursor: not-allowed;
            background-color: #f0f0f0;
            /* Optional: add more styling to visually indicate read-only status */
        }


        .sidebar {
            width: 220px;
            background: #141E30;
            color: white;
            display: flex;
            flex-direction: column;
            padding: 30px 15px;
        }

        .sidebar h2 {
            text-align: center;
            margin-bottom: 30px;
        }

        .nav-link {
            background: none;
            color: white;
            border: none;
            padding: 12px 15px;
            text-align: left;
            font-size: 16px;
            cursor: pointer;
            transition: 0.2s ease;
        }

        .nav-link:hover {
            background: #1823dd;
            border-radius: 5px;
        }

        .content {
            flex: 1;
            padding: 30px;
        }

        .section {
            background: white;
            padding: 25px;
            border-radius: 10px;
            box-shadow: 0 0 20px #ccc;
            display: none;
        }

        .section.active {
            display: block;
        }

        label, input {
            display: block;
            margin-bottom: 10px;
        }

        input {
            padding: 8px;
            width: 100%;
            border-radius: 4px;
            border: 1px solid #ccc;
        }

        .btn {
            margin-top: 10px;
            padding: 10px 15px;
            background-color: #141E30;
            color: white;
            border: none;
            border-radius: 4px;
            font-weight: bold;
            cursor: pointer;
        }

        .btn:hover {
            background-color: #1823dd;
        }

        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 15px;
        }

        th, td {
            padding: 12px;
            border-bottom: 1px solid #ddd;
            text-align: center;
        }

        th {
            background-color: #243B55;
            color: white;
        }

        .cancel-btn {
            background: crimson;
            color: white;
            padding: 6px 12px;
            border: none;
            border-radius: 4px;
            cursor: pointer;
        }

        .cancel-btn:hover {
            background: darkred;
        }

        .message {
            padding: 10px;
            margin-bottom: 15px;
            border-radius: 5px;
        }

        .success {
            background-color: #d4edda;
            color: #155724;
            border: 1px solid #c3e6cb;
        }

        .error {
            background-color: #f8d7da;
            color: #721c24;
            border: 1px solid #f5c6cb;
        }
    </style>
</head>
<body>

<div class="sidebar">
    <h2>My Profile</h2>
    <button class="nav-link" onclick="showSection('account')">Account</button>
    <button class="nav-link" onclick="showSection('reservations')">Reservations</button>
</div>

<%
    // Get user information from session
    String userName = (String) session.getAttribute("name");
    String userEmail = (String) session.getAttribute("email");
    String userPhone = (String) session.getAttribute("phone");
    String userAddress = (String) session.getAttribute("address");

    // Create user object with session data
    User user = null;
    if (userEmail != null) {
        user = new User(
                userName != null ? userName : "",
                userEmail,
                userPhone != null ? userPhone : "",
                "",  // password not needed here
                userAddress != null ? userAddress : ""
        );
    }

    List<Reservation> userReservations = new ArrayList<>();

    if (user != null) {
        Queue<Reservation> allReservations = ReservationService.getAllReservations(application);
        for (Reservation r : allReservations) {
            if (r.getEmail().equalsIgnoreCase(user.getEmail())) {
                userReservations.add(r);
            }
        }
    }

    // Check for success or error messages
    String successMessage = (String) session.getAttribute("successMessage");
    String errorMessage = (String) request.getAttribute("errorMessage");

    // Clear success message after displaying
    if (successMessage != null) {
        session.removeAttribute("successMessage");
    }
%>


<div class="content">
    <% if (successMessage != null) { %>
    <div class="message success">
        <%= successMessage %>
    </div>
    <% } %>

    <% if (errorMessage != null) { %>
    <div class="message error">
        <%= errorMessage %>
    </div>
    <% } %>

    <!-- Account Section -->
    <div id="account" class="section active">
        <h2>Account Details</h2>
        <div class="account-info">
            <div class="form-group">
                <label>Full Name</label>
                <input type="text" value="<%= user != null && user.getName() != null ? user.getName() : "" %>" readonly>
            </div>

            <div class="form-group">
                <label>Email</label>
                <input type="email" value="<%= user != null ? user.getEmail() : "" %>" readonly>
            </div>

            <div class="form-group">
                <label>Phone</label>
                <input type="text" value="<%= user != null && user.getPhone() != null ? user.getPhone() : "" %>" readonly>
            </div>

            <div class="form-group">
                <label>Address</label>
                <input type="text" value="<%= user != null && user.getAddress() != null ? user.getAddress() : "No address provided" %>" readonly>
            </div>

            <div class="mt-3">
                <a href="<%= request.getContextPath() %>/update-profile" class="btn btn-primary">Update Profile</a>
            </div>
        </div>
    </div>



    <!-- Reservations Section -->
    <div id="reservations" class="section">
        <h2>Ongoing Reservations</h2>

        <% if (userReservations != null && !userReservations.isEmpty()) { %>
        <table>
            <thead>
            <tr>
                <th>Reservation ID</th>
                <th>Hotel</th>
                <th>Date</th>
                <th>Time</th>
                <th>Guests</th>
                <th>Table Type</th>
                <th>Action</th>
            </tr>
            </thead>
            <tbody>
            <% for (Reservation r : userReservations) { %>
            <tr>
                <td><%= r.getReservationId() %></td>
                <td><%= r.getHotelName() %></td>
                <td><%= r.getDate() %></td>
                <td><%= r.getTime() %></td>
                <td><%= r.getGuests() %></td>
                <td><%= r.gettableType() != null ? r.gettableType() : "Not selected" %></td>
                <td>
                    <form action="<%= request.getContextPath() %>/cancel-reservation" method="post" onsubmit="return confirm('Cancel this reservation?');">
                        <input type="hidden" name="reservationId" value="<%= r.getReservationId() %>">
                        <button type="submit" class="cancel-btn">Cancel</button>
                    </form>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
        <% } else { %>
        <p>No reservations found.</p>
        <% } %>

    </div>

</div>

<script>
    function showSection(id) {
        document.querySelectorAll('.section').forEach(div => {
            div.classList.remove('active');
        });
        document.getElementById(id).classList.add('active');
    }
</script>

</body>
</html>
