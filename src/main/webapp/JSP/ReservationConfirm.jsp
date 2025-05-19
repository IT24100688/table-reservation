<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
    String reservationID = (String) session.getAttribute("reservationID");
    String hotel = (String) session.getAttribute("hotelName");
    String name = (String) session.getAttribute("name");
    String email = (String) session.getAttribute("email");
    String phone = (String) session.getAttribute("phone");
    String date = (String) session.getAttribute("date");
    String time = (String) session.getAttribute("time");
    String guests = (String) session.getAttribute("guests");
    String tableType = (String) session.getAttribute("tableType");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Reservation Confirmed</title>
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        :root {
            --dark-blue: #03045e;
            --deep-blue: #023e8a;
            --medium-blue: #0077b6;
            --teal-blue: #0096c7;
            --light-teal: #00b4d8;
            --sky-blue: #48cae4;
            --pale-blue: #90e0ef;
            --ice-blue: #ade8f4;
            --frost: #caf0f8;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background: linear-gradient(135deg, var(--dark-blue) 0%, var(--deep-blue) 100%);
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            padding: 2rem;
        }

        .confirmation-card {
            width: 100%;
            max-width: 700px;
            background: white;
            border-radius: 16px;
            overflow: hidden;
            box-shadow: 0 15px 30px rgba(0, 0, 0, 0.2);
            position: relative;
        }

        .confirmation-header {
            background: linear-gradient(135deg, var(--medium-blue) 0%, var(--teal-blue) 100%);
            color: white;
            padding: 2rem;
            text-align: center;
            position: relative;
        }

        .confirmation-header::after {
            content: '';
            position: absolute;
            bottom: -20px;
            left: 50%;
            transform: translateX(-50%);
            width: 0;
            height: 0;
            border-left: 20px solid transparent;
            border-right: 20px solid transparent;
            border-top: 20px solid var(--teal-blue);
        }

        .confirmation-header h2 {
            font-size: 2rem;
            font-weight: 600;
            margin-bottom: 0.5rem;
        }

        .confirmation-header .icon {
            font-size: 3rem;
            margin-bottom: 1rem;
            color: white;
            animation: bounce 1s infinite alternate;
        }

        @keyframes bounce {
            from { transform: translateY(0); }
            to { transform: translateY(-10px); }
        }

        .confirmation-id {
            background: var(--dark-blue);
            color: white;
            padding: 0.5rem 1rem;
            border-radius: 50px;
            display: inline-block;
            font-size: 0.9rem;
            margin-top: 1rem;
        }

        .confirmation-body {
            padding: 2.5rem;
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.5rem;
        }

        .detail-item {
            display: flex;
            align-items: flex-start;
            margin-bottom: 1rem;
        }

        .detail-icon {
            color: var(--teal-blue);
            font-size: 1.2rem;
            margin-right: 1rem;
            margin-top: 3px;
        }

        .detail-content {
            flex: 1;
        }

        .detail-label {
            font-size: 0.85rem;
            color: var(--deep-blue);
            font-weight: 500;
            margin-bottom: 0.25rem;
        }

        .detail-value {
            font-size: 1.1rem;
            font-weight: 600;
            color: var(--dark-blue);
        }

        .btn {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            padding: 0.75rem 1.5rem;
            border-radius: 50px;
            font-weight: 600;
            text-decoration: none;
            transition: all 0.3s ease;
            margin-top: 2rem;
            border: none;
            cursor: pointer;
        }

        .btn-primary {
            background: linear-gradient(135deg, var(--light-teal) 0%, var(--teal-blue) 100%);
            color: white;
            box-shadow: 0 4px 15px rgba(0, 180, 216, 0.3);
        }

        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 6px 20px rgba(0, 180, 216, 0.4);
        }

        .btn-primary i {
            margin-right: 0.5rem;
        }

        @media (max-width: 768px) {
            .confirmation-body {
                grid-template-columns: 1fr;
                padding: 1.5rem;
            }

            .confirmation-header {
                padding: 1.5rem;
            }

            .confirmation-header h2 {
                font-size: 1.5rem;
            }
        }
    </style>
</head>
<body>
<div class="confirmation-card">
    <div class="confirmation-header">
        <div class="icon">
            <i class="fas fa-check-circle"></i>
        </div>
        <h2>Reservation Confirmed!</h2>
        <div class="confirmation-id">Reservation ID: <%= reservationID %></div>
    </div>

    <div class="confirmation-body">
        <div class="detail-item">
            <div class="detail-icon">
                <i class="fas fa-hotel"></i>
            </div>
            <div class="detail-content">
                <div class="detail-label">Hotel</div>
                <div class="detail-value"><%= hotel %></div>
            </div>
        </div>

        <div class="detail-item">
            <div class="detail-icon">
                <i class="fas fa-calendar-day"></i>
            </div>
            <div class="detail-content">
                <div class="detail-label">Date</div>
                <div class="detail-value"><%= date %></div>
            </div>
        </div>

        <div class="detail-item">
            <div class="detail-icon">
                <i class="fas fa-clock"></i>
            </div>
            <div class="detail-content">
                <div class="detail-label">Time</div>
                <div class="detail-value"><%= time %></div>
            </div>
        </div>

        <div class="detail-item">
            <div class="detail-icon">
                <i class="fas fa-user-friends"></i>
            </div>
            <div class="detail-content">
                <div class="detail-label">Guests</div>
                <div class="detail-value"><%= guests %></div>
            </div>
        </div>

        <div class="detail-item">
            <div class="detail-icon">
                <i class="fas fa-chair"></i>
            </div>
            <div class="detail-content">
                <div class="detail-label">Table Type</div>
                <div class="detail-value"><%= tableType %></div>
            </div>
        </div>

        <div class="detail-item">
            <div class="detail-icon">
                <i class="fas fa-user"></i>
            </div>
            <div class="detail-content">
                <div class="detail-label">Name</div>
                <div class="detail-value"><%= name %></div>
            </div>
        </div>

        <div class="detail-item">
            <div class="detail-icon">
                <i class="fas fa-envelope"></i>
            </div>
            <div class="detail-content">
                <div class="detail-label">Email</div>
                <div class="detail-value"><%= email %></div>
            </div>
        </div>

        <div class="detail-item">
            <div class="detail-icon">
                <i class="fas fa-phone"></i>
            </div>
            <div class="detail-content">
                <div class="detail-label">Phone</div>
                <div class="detail-value"><%= phone %></div>
            </div>
        </div>
    </div>
</div>

<a href="<%= request.getContextPath() %>/JSP/feedback.jsp" class="btn btn-primary">
    <i class="fas fa-comment-alt"></i> Leave Feedback
</a>

</body>
</html>