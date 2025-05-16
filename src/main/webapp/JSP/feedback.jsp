<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Feedback Form | ReservEats</title>
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
            --star-color: #FFC107;
            --card-shadow: 0 4px 12px rgba(0, 0, 0, 0.08);
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

        .feedback-card {
            background: white;
            border-radius: 12px;
            box-shadow: var(--card-shadow);
            padding: 40px;
            width: 100%;
            max-width: 600px;
            margin: 20px;
        }

        .feedback-title {
            color: var(--primary-dark);
            font-weight: 600;
            margin-bottom: 30px;
            text-align: center;
            font-size: 1.8rem;
        }

        .form-label {
            font-weight: 500;
            color: var(--primary-dark);
            margin-bottom: 8px;
        }

        .form-control {
            padding: 12px 15px;
            border: 1px solid #ddd;
            border-radius: 8px;
            margin-bottom: 20px;
            font-size: 1rem;
        }

        .form-control:focus {
            border-color: var(--primary-light);
            box-shadow: 0 0 0 3px rgba(36, 59, 85, 0.2);
        }

        textarea.form-control {
            min-height: 120px;
            resize: vertical;
        }

        .rating-container {
            margin: 25px 0;
            text-align: center;
        }

        .rating-label {
            display: block;
            margin-bottom: 15px;
            font-weight: 500;
            color: var(--primary-dark);
        }

        .stars {
            display: flex;
            justify-content: center;
            direction: rtl;
        }

        .stars input[type="radio"] {
            display: none;
        }

        .stars label {
            font-size: 36px;
            color: #ddd;
            margin: 0 5px;
            cursor: pointer;
            transition: all 0.2s;
        }

        .stars label:hover,
        .stars label:hover ~ label,
        .stars input[type="radio"]:checked ~ label {
            color: var(--star-color);
        }

        .submit-btn {
            background-color: var(--primary-dark);
            color: white;
            border: none;
            padding: 14px 28px;
            border-radius: 8px;
            font-weight: 500;
            font-size: 1.1rem;
            width: 100%;
            margin-top: 15px;
            transition: all 0.3s;
            cursor: pointer;
        }

        .submit-btn:hover {
            background-color: var(--primary-light);
            transform: translateY(-2px);
        }

        .submit-btn:active {
            transform: translateY(0);
        }

        @media (max-width: 576px) {
            .feedback-card {
                padding: 30px 20px;
            }

            .feedback-title {
                font-size: 1.5rem;
            }

            .stars label {
                font-size: 30px;
            }
        }
    </style>
</head>
<body>

<div class="feedback-card">
    <h2 class="feedback-title"><i class="fas fa-comment-dots me-2"></i>Share Your Experience</h2>

    <form action="submitFeedback.jsp" method="post">
        <div class="mb-3">
            <label for="name" class="form-label">Your Name</label>
            <input type="text" class="form-control" id="name" name="name" required placeholder="Enter your name">
        </div>

        <div class="mb-3">
            <label for="feedback" class="form-label">Your Feedback (Optional)</label>
            <textarea class="form-control" id="feedback" name="feedback" placeholder="Tell us about your experience..."></textarea>
        </div>

        <div class="rating-container">
            <span class="rating-label">Rate Your Experience</span>
            <div class="stars">
                <input type="radio" id="star5" name="rating" value="5">
                <label for="star5" title="Excellent">★</label>

                <input type="radio" id="star4" name="rating" value="4">
                <label for="star4" title="Very Good">★</label>

                <input type="radio" id="star3" name="rating" value="3">
                <label for="star3" title="Good">★</label>

                <input type="radio" id="star2" name="rating" value="2">
                <label for="star2" title="Fair">★</label>

                <input type="radio" id="star1" name="rating" value="1" required>
                <label for="star1" title="Poor">★</label>
            </div>
        </div>

        <button type="submit" class="submit-btn">
            <i class="fas fa-paper-plane me-2"></i>Submit Feedback
        </button>
    </form>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.3/dist/js/bootstrap.bundle.min.js"></script>
<script>
    // Enhance star rating interaction
    document.querySelectorAll('.stars label').forEach(star => {
        star.addEventListener('click', function() {
            // Set aria-pressed for accessibility
            this.setAttribute('aria-pressed', 'true');
            const siblings = [...this.parentElement.children];
            const index = siblings.indexOf(this);
            siblings.forEach((sib, i) => {
                if (i >= index) {
                    sib.setAttribute('aria-pressed', 'true');
                } else {
                    sib.setAttribute('aria-pressed', 'false');
                }
            });
        });
    });
</script>
</body>
</html>