<%@ page import="java.util.Queue" %>
<%@ page import="com.restaurant.model.Reservation" %>
<%
    Queue<Reservation> reservations = (Queue<Reservation>) request.getAttribute("reservations");
    String msg = (String) request.getAttribute("message");
%>
<!DOCTYPE html>
<html>
<head>
    <title>View Reservations | ReservEats</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
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
            color: #2d3748;
            margin: 0;
            padding: 0;
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

        .action-buttons .btn {
            margin-right: 8px;
            padding: 5px 12px;
            font-size: 0.85rem;
        }

        .badge-status {
            padding: 6px 10px;
            border-radius: 20px;
            font-weight: 500;
            font-size: 0.75rem;
        }

        .badge-confirmed {
            background-color: #4caf50;
            color: white;
        }

        .badge-pending {
            background-color: #ff9800;
            color: white;
        }

        .badge-cancelled {
            background-color: #f44336;
            color: white;
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

        <li><a href="admin-dashboard"><i class="fas fa-hotel"></i> <span>Manage Hotels</span></a></li>
        <li><a href="<%= request.getContextPath() %>/admin/table-availability"><i class="fas fa-chair"></i> <span>Table Availability</span></a></li>
        <li><a href="<%= request.getContextPath() %>/ViewAllReservationsServlet" class="active"><i class="fas fa-calendar-check"></i> <span>Reservations</span></a></li>
        <li><a href="<%= request.getContextPath() %>/JSP/viewFeedback.jsp"><i class="fas fa-comment-dots"></i> <span>Feedbacks</span></a></li>
        <li><a href="<%= request.getContextPath()%>/JSP/Logout.jsp"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a></li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="page-header">
        <h2><i class="fas fa-calendar-check me-2"></i>Reservation Management</h2>
    </div>

    <% if (msg != null) { %>
    <div class="alert alert-success alert-dismissible fade show" role="alert">
        <%= msg %>
        <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
    </div>
    <% } %>

    <div class="table-container">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>ID</th>
                <th>Restaurant</th>
                <th>Date</th>
                <th>Time</th>
                <th>Guests</th>
                <th>Customer</th>
                <th>Contact</th>
                <th>Table Type</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                if (reservations != null && !reservations.isEmpty()) {
                    int count = 0;
                    for (Reservation r : reservations) {
                        count++;
            %>
            <tr>
                <td><%= r.getReservationId() %></td>
                <td><strong><%= r.getHotelName() %></strong></td>
                <td><%= r.getDate() %></td>
                <td><%= r.getTime() %></td>
                <td><%= r.getGuests() %></td>
                <td>
                    <strong><%= r.getName() %></strong><br>
                    <small class="text-muted"><%= r.getEmail() %></small>
                </td>
                <td><%= r.getPhone() %></td>
                <td><span class="badge bg-primary"><%= r.gettableType() %></span></td>
                <td class="action-buttons">
                    <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#editModal<%= count %>">
                        <i class="fas fa-edit"></i>
                    </button>
                    <form action="delete-reservation" method="post" style="display:inline;">
                        <input type="hidden" name="reservationId" value="<%= r.getReservationId() %>"/>
                        <button class="btn btn-danger btn-sm" onclick="return confirm('Are you sure you want to delete this reservation?')">
                            <i class="fas fa-trash-alt"></i>
                        </button>
                    </form>
                </td>
            </tr>

            <!-- Edit Modal -->
            <div class="modal fade" id="editModal<%= count %>" tabindex="-1" aria-labelledby="modalLabel<%= count %>" aria-hidden="true">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <form action="EditReservationServlet" method="post">
                            <div class="modal-header">
                                <h5 class="modal-title" id="modalLabel<%= count %>">Edit Reservation #<%= r.getReservationId() %></h5>
                                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="reservationId" value="<%= r.getReservationId() %>">
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Date</label>
                                        <input type="date" name="date" class="form-control" value="<%= r.getDate() %>" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Time</label>
                                        <input type="time" name="time" class="form-control" value="<%= r.getTime() %>" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Restaurant Name</label>
                                        <input type="text" name="HotelName" class="form-control" value="<%= r.getHotelName() %>" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Table Type</label>
                                        <input type="text" name="tableType" class="form-control" value="<%= r.gettableType() %>" required>
                                    </div>
                                </div>
                                <div class="row">
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Guests</label>
                                        <input type="number" name="guests" class="form-control" value="<%= r.getGuests() %>" required>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Customer Name</label>
                                        <input type="text" name="name" class="form-control" value="<%= r.getName() %>" required>
                                    </div>
                                    <div class="col-md-4 mb-3">
                                        <label class="form-label">Phone</label>
                                        <input type="text" name="phone" class="form-control" value="<%= r.getPhone() %>" required>
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" name="email" class="form-control" value="<%= r.getEmail() %>" required>
                                </div>
                            </div>
                            <div class="modal-footer">
                                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                                <button type="submit" class="btn btn-primary">Save Changes</button>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
            <%
                } // end for
            } else {
            %>
            <tr>
                <td colspan="9" class="no-data">
                    <i class="fas fa-calendar-times"></i>
                    <h4>No Reservations Found</h4>
                    <p>When reservations are made, they will appear here</p>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
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