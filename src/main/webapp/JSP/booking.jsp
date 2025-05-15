<%@ page import="com.restaurant.model.Hotel" %>
<%
    Hotel hotel = (Hotel) request.getAttribute("selectedHotel");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Book a Table | ReservEats</title>
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
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 20px;
        }

        .booking-container {
            display: flex;
            max-width: 900px;
            width: 100%;
            background: white;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            overflow: hidden;
        }

        .hotel-info {
            width: 40%;
            background: linear-gradient(to bottom, var(--primary-dark), var(--primary-light));
            color: white;
            padding: 40px;
            display: flex;
            flex-direction: column;
        }

        .hotel-info h1 {
            font-weight: 600;
            margin-bottom: 20px;
            font-size: 1.8rem;
        }

        .hotel-description {
            font-size: 0.95rem;
            line-height: 1.6;
            margin-bottom: 25px;
            opacity: 0.9;
        }

        .features-list {
            list-style: none;
            padding: 0;
            margin-top: auto;
        }

        .features-list li {
            margin-bottom: 10px;
            display: flex;
            align-items: center;
        }

        .features-list li i {
            margin-right: 10px;
            color: var(--text-light);
        }

        .booking-form {
            width: 60%;
            padding: 40px;
        }

        .form-title {
            color: var(--primary-dark);
            font-weight: 600;
            margin-bottom: 30px;
            text-align: center;
            font-size: 1.5rem;
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-label {
            font-weight: 500;
            color: var(--primary-dark);
            margin-bottom: 8px;
            display: block;
        }

        .form-control {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 6px;
            font-size: 1rem;
        }

        .form-control:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(36, 59, 85, 0.2);
        }

        .time-slots {
            display: flex;
            gap: 10px;
            margin: 20px 0;
            flex-wrap: wrap;
        }

        .time-slot {
            flex: 1;
            min-width: 100px;
            background-color: var(--primary-dark);
            color: white;
            border: none;
            padding: 10px;
            border-radius: 6px;
            cursor: pointer;
            transition: all 0.3s;
            text-align: center;
        }

        .time-slot:hover, .time-slot.active {
            background-color: var(--primary-light);
            transform: translateY(-2px);
        }

        .submit-btn {
            width: 100%;
            background-color: var(--primary-dark);
            color: white;
            border: none;
            padding: 12px;
            border-radius: 6px;
            font-weight: 500;
            font-size: 1rem;
            margin-top: 20px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .submit-btn:hover {
            background-color: var(--primary-light);
            transform: translateY(-2px);
        }

        @media (max-width: 768px) {
            .booking-container {
                flex-direction: column;
            }

            .hotel-info, .booking-form {
                width: 100%;
            }

            .hotel-info {
                padding-bottom: 30px;
            }
        }
    </style>
</head>
<body>
<form action="JSP/table.jsp" method="get">
    <input type="hidden" name="hotelName" value="<%= hotel != null ? hotel.getName() : "" %>">
    <input type="hidden" name="selectedTime" id="selectedTimeInput">
    <input type="hidden" name="selectedGuests" id="selectedGuestsInput">
    <input type="hidden" name="selectedDate" id="selectedDateInput">

    <div class="booking-container">
        <!-- Hotel Information Section -->
        <div class="hotel-info">
            <h1><%= hotel != null ? hotel.getName() : "Restaurant" %></h1>
            <p class="hotel-description">
                <%= hotel != null ? hotel.getDescription() : "Premium dining experience with exceptional service and ambiance." %>
            </p>

            <% if (hotel != null && !hotel.getFeatures().isEmpty()) { %>
            <ul class="features-list">
                <% for (String feature : hotel.getFeatures()) { %>
                <li><i class="fas fa-check-circle"></i> <%= feature %></li>
                <% } %>
            </ul>
            <% } %>
        </div>

        <!-- Booking Form Section -->
        <div class="booking-form">
            <h2 class="form-title"><i class="fas fa-calendar-alt me-2"></i>Make a Reservation</h2>

            <div class="form-group">
                <label for="guests" class="form-label">Number of Guests</label>
                <select id="guests" class="form-control">
                    <% for (int i = 1; i <= 10; i++) { %>
                    <option value="<%= i %>"><%= i %> <%= i == 1 ? "Person" : "People" %></option>
                    <% } %>
                </select>
            </div>

            <div class="form-group">
                <label for="date" class="form-label">Reservation Date</label>
                <input type="date" id="date" class="form-control" required>
            </div>

            <div class="form-group">
                <label class="form-label">Select Time Slot</label>
                <div class="time-slots">
                    <button type="button" class="time-slot">6:00 PM</button>
                    <button type="button" class="time-slot">6:30 PM</button>
                    <button type="button" class="time-slot">7:00 PM</button>
                    <button type="button" class="time-slot">7:30 PM</button>
                    <button type="button" class="time-slot">8:00 PM</button>
                    <button type="button" class="time-slot">8:30 PM</button>
                </div>
            </div>

            <button type="submit" class="submit-btn">
                <i class="fas fa-arrow-right me-2"></i>Proceed to Table Selection
            </button>
        </div>
    </div>
</form>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        // Set minimum date to today
        const today = new Date().toISOString().split('T')[0];
        document.getElementById('date').min = today;

        // Time slot selection
        const timeSlots = document.querySelectorAll('.time-slot');
        timeSlots.forEach(slot => {
            slot.addEventListener('click', function() {
                timeSlots.forEach(s => s.classList.remove('active'));
                this.classList.add('active');
                document.getElementById('selectedTimeInput').value = this.textContent.trim();
            });
        });

        // Form submission
        document.querySelector('form').addEventListener('submit', function(e) {
            const guests = document.getElementById('guests').value;
            const date = document.getElementById('date').value;
            const time = document.getElementById('selectedTimeInput').value;

            if (!time) {
                e.preventDefault();
                alert('Please select a time slot');
                return;
            }

            document.getElementById('selectedGuestsInput').value = guests;
            document.getElementById('selectedDateInput').value = date;
        });
    });
</script>
</body>
</html>