<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%
    String name = request.getParameter("name");
    String feedback = request.getParameter("feedback");
    String rating = request.getParameter("rating");

    if (name != null && !name.isEmpty()) {
        // Path to save feedbacks file
        String filePath = application.getRealPath("/data/feedbacks.txt");

        try {
            FileWriter writer = new FileWriter(filePath, true);
            BufferedWriter bufferedWriter = new BufferedWriter(writer);

            // Constructing the feedback entry
            String feedbackEntry = name + ":" + rating + ":" + (feedback.isEmpty() ? "No feedback given" : feedback) + "\n";

            // Writing to file
            bufferedWriter.write(feedbackEntry);
            bufferedWriter.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback Submitted | ReservEats</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Poppins:wght@300;400;500;600&display=swap" rel="stylesheet">
    <style>
        :root {
            --primary-dark: #141E30;
            --primary-light: #243B55;
            --accent-color: #d32f2f;
            --accent-hover: #b71c1c;
            --success-color: #4CAF50;
            --success-hover: #388E3C;
        }

        body {
            font-family: 'Poppins', sans-serif;
            background-color: #f8fafc;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        .confirmation-card {
            background: white;
            border-radius: 12px;
            box-shadow: 0 6px 18px rgba(0, 0, 0, 0.1);
            padding: 40px;
            text-align: center;
            max-width: 500px;
            width: 90%;
            margin: 20px;
        }

        .confirmation-icon {
            font-size: 60px;
            color: var(--success-color);
            margin-bottom: 20px;
        }

        h2 {
            color: var(--primary-dark);
            font-weight: 600;
            margin-bottom: 15px;
        }

        .success-message {
            color: var(--success-color);
            font-size: 1.2rem;
            font-weight: 500;
            margin-bottom: 25px;
        }

        .feedback-details {
            background-color: #f8f9fa;
            border-radius: 8px;
            padding: 20px;
            margin: 25px 0;
            text-align: left;
        }

        .detail-row {
            margin-bottom: 10px;
        }

        .detail-label {
            font-weight: 500;
            color: var(--primary-dark);
        }

        .btn-return {
            background-color: var(--primary-dark);
            color: white;
            border: none;
            padding: 12px 30px;
            border-radius: 30px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s;
            display: inline-block;
            margin-top: 15px;
        }

        .btn-return:hover {
            background-color: var(--primary-light);
            transform: translateY(-2px);
            color: white;
        }

        .stars {
            color: #FFC107;
            font-size: 1.2rem;
            margin-top: 5px;
        }
    </style>
</head>
<body>

<div class="confirmation-card">
    <div class="confirmation-icon">
        <i class="fas fa-check-circle"></i>
    </div>
    <h2>Thank You for Your Feedback!</h2>
    <p class="success-message">We appreciate you taking the time to share your experience with us.</p>

    <% if (name != null && !name.isEmpty()) { %>
    <div class="feedback-details">
        <div class="detail-row">
            <span class="detail-label">Name:</span> <%= name %>
        </div>
        <div class="detail-row">
            <span class="detail-label">Rating:</span>
            <div class="stars">
                <%
                    int stars = rating != null ? Integer.parseInt(rating) : 0;
                    for (int i = 0; i < 5; i++) {
                        if (i < stars) {
                %>
                <i class="fas fa-star"></i>
                <%  } else { %>
                <i class="far fa-star"></i>
                <%  }
                } %>
            </div>
        </div>
        <div class="detail-row">
            <span class="detail-label">Feedback:</span>
            <%= feedback != null && !feedback.isEmpty() ? feedback : "No feedback given" %>
        </div>
    </div>
    <% } %>

    <a href="<%= request.getContextPath() %>" class="btn-return">
        <i class="fas fa-arrow-left me-2"></i>Return to Home
    </a>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>