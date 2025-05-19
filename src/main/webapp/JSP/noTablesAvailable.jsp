<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>No Tables Available | ReservEats</title>
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

        .error-container {
            background: white;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            padding: 40px;
            text-align: center;
            max-width: 600px;
            width: 100%;
        }

        .error-icon {
            font-size: 60px;
            color: var(--accent-color);
            margin-bottom: 20px;
        }

        .error-title {
            font-size: 24px;
            color: var(--primary-dark);
            font-weight: 600;
            margin-bottom: 15px;
        }

        .error-message {
            color: #666;
            margin-bottom: 30px;
            line-height: 1.6;
        }

        .btn-primary {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            padding: 10px 25px;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-primary:hover {
            background-color: var(--primary-light);
            border-color: var(--primary-light);
            transform: translateY(-2px);
        }
    </style>
</head>
<body>
<div class="error-container">
    <div class="error-icon">
        <i class="fas fa-chair-office"></i>
    </div>
    <h1 class="error-title">No Tables Available</h1>
    <p class="error-message">
        We're sorry, but there are currently no tables available of the selected type.
        Please choose a different table type or try again later.
    </p>
    <div class="d-flex justify-content-center gap-3">
        <a href="<%= request.getContextPath() %>/index.jsp" class="btn btn-primary">
            <i class="fas fa-home me-2"></i>Back to Home
        </a>
        <a href="javascript:history.back()" class="btn btn-outline-primary">
            <i class="fas fa-arrow-left me-2"></i>Go Back
        </a>
    </div>
</div>
</body>
</html>