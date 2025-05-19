<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.restaurant.model.HotelTableManager" %>
<%@ page import="java.util.*" %>

<%
    HotelTableManager manager = (HotelTableManager) application.getAttribute("manager");
    Set<String> hotels = null;

    if (manager != null) {
        hotels = manager.getAllHotelNames();
    } else {
        // Handle case when manager is not available
        response.sendRedirect(request.getContextPath() + "/InitServlet");
        return;
    }
%>

<!DOCTYPE html>
<html>
<head>
    <title>Table Availability | ReservEats</title>
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

        .table-container {
            background: white;
            border-radius: 10px;
            box-shadow: var(--card-shadow);
            padding: 20px;
            overflow-x: auto;
        }

        .table thead {
            background: linear-gradient(to right, var(--primary-dark), var(--primary-light));
            color: white;
        }

        .table th {
            font-weight: 500;
            padding: 15px;
        }

        .table td {
            padding: 12px 15px;
            vertical-align: middle;
        }

        .table-type {
            display: inline-block;
            padding: 6px 12px;
            border-radius: 20px;
            font-size: 0.8rem;
            font-weight: 500;
            margin-left: 8px;
        }

        .table-type.vip {
            background-color: rgba(237, 137, 54, 0.1);
            color: #ed8936;
        }

        .table-type.family {
            background-color: rgba(72, 187, 120, 0.1);
            color: #48bb78;
        }

        .table-type.outdoor {
            background-color: rgba(66, 153, 225, 0.1);
            color: #4299e1;
        }

        .count-badge {
            display: inline-flex;
            align-items: center;
            justify-content: center;
            width: 28px;
            height: 28px;
            border-radius: 50%;
            background-color: var(--primary-light);
            color: white;
            font-weight: 600;
        }

        .form-inline {
            display: flex;
            gap: 10px;
            align-items: center;
        }

        .form-select {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            min-width: 100px;
        }

        .form-input {
            padding: 8px 12px;
            border: 1px solid #ddd;
            border-radius: 4px;
            width: 70px;
        }

        .btn-sm {
            padding: 8px 12px;
            font-size: 0.85rem;
        }

        .hotel-name {
            font-weight: 600;
            color: var(--primary-dark);
        }

        .no-data {
            text-align: center;
            padding: 50px;
            color: #6c757d;
        }

        .no-data i {
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
            }
            .form-inline {
                flex-wrap: wrap;
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
        <li><a href="<%= request.getContextPath() %>/admin/table-availability" class="active"><i class="fas fa-chair"></i> <span>Table Availability</span></a></li>
        <li><a href="<%= request.getContextPath() %>/ViewAllReservationsServlet"><i class="fas fa-calendar-check"></i> <span>Reservations</span></a></li>
        <li><a href="<%= request.getContextPath() %>/JSP/viewFeedback.jsp"><i class="fas fa-comment-dots"></i> <span>Feedbacks</span></a></li>
        <li><a href="<%= request.getContextPath()%>/JSP/Logout.jsp"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a></li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="page-header">
        <h2><i class="fas fa-chair me-2"></i>Table Availability Management</h2>
    </div>

    <div class="table-container">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>Restaurant</th>
                <th>Outdoor Tables</th>
                <th>VIP Tables</th>
                <th>Family Tables</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <% if (hotels != null && !hotels.isEmpty()) {
                for (String hotel : hotels) {
                    Map<String, Integer> counts = manager.getTableCounts(hotel);
            %>
            <tr>
                <td class="hotel-name"><%= hotel %></td>
                <td>
                    <span class="count-badge"><%= counts.get("Outdoor") != null ? counts.get("Outdoor") : 0 %></span>
                    <span class="table-type outdoor">Outdoor</span>
                </td>
                <td>
                    <span class="count-badge"><%= counts.get("VIP") != null ? counts.get("VIP") : 0 %></span>
                    <span class="table-type vip">VIP</span>
                </td>
                <td>
                    <span class="count-badge"><%= counts.get("Family") != null ? counts.get("Family") : 0 %></span>
                    <span class="table-type family">Family</span>
                </td>
                <td>
                    <form action="<%= request.getContextPath() %>/ManageTablesServlet" method="post" class="form-inline">
                        <input type="hidden" name="hotelName" value="<%= hotel %>">
                        <select name="tableType" class="form-select">
                            <option value="VIP">VIP</option>
                            <option value="Family">Family</option>
                            <option value="Outdoor">Outdoor</option>
                        </select>
                        <input type="number" name="count" value="1" min="1" required class="form-input">
                        <button type="submit" name="action" value="add" class="btn btn-primary btn-sm">
                            <i class="fas fa-plus"></i> Add
                        </button>
                        <button type="submit" name="action" value="remove" class="btn btn-danger btn-sm">
                            <i class="fas fa-minus"></i> Remove
                        </button>
                    </form>
                </td>
            </tr>
            <% }
            } else { %>
            <tr>
                <td colspan="5" class="no-data">
                    <i class="fas fa-table"></i>
                    <h4>No Restaurants Found</h4>
                    <p>Add restaurants first to manage their tables</p>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
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