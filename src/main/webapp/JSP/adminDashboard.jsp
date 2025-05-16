<%@ page import="com.restaurant.model.Hotel" %>
<%@ page import="java.util.List" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard | ReservEats</title>
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
            overflow-x: hidden;
        }

        .sidebar {
            width: var(--sidebar-width);
            height: 100vh;
            background: linear-gradient(to bottom, var(--primary-dark), var(--primary-light));
            color: white;
            position: fixed;
            padding: 20px 0;
            transition: all 0.3s;
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

        .btn-primary {
            background-color: var(--primary-light);
            border: none;
        }

        .btn-primary:hover {
            background-color: var(--primary-dark);
        }

        .btn-danger-custom {
            background-color: var(--accent-color);
            border: none;
            padding: 8px 20px;
            border-radius: 30px;
            font-weight: 500;
            transition: all 0.3s;
        }

        .btn-danger-custom:hover {
            background-color: var(--accent-hover);
            transform: translateY(-2px);
        }

        .table-container {
            background: white;
            border-radius: 10px;
            box-shadow: var(--card-shadow);
            padding: 20px;
            overflow: hidden;
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

        .table img {
            width: 80px;
            height: 60px;
            object-fit: cover;
            border-radius: 4px;
            box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1);
        }

        .action-buttons .btn {
            margin-right: 8px;
            padding: 5px 12px;
            font-size: 0.85rem;
        }

        .delete-btn {
            background-color: #f44336;
            color: white;
            border: none;
            padding: 5px 12px;
            border-radius: 4px;
            cursor: pointer;
            transition: all 0.3s;
        }

        .delete-btn:hover {
            background-color: #d32f2f;
            transform: translateY(-2px);
        }

        .modal-header {
            background: linear-gradient(to right, var(--primary-dark), var(--primary-light));
            color: white;
        }

        .modal-title {
            font-weight: 500;
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

        /* Responsive adjustments */
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

        <li><a href="admin-dashboard" class="active"><i class="fas fa-hotel"></i> <span>Manage Hotels</span></a></li>
        <li><a href="<%= request.getContextPath() %>/admin/table-availability"><i class="fas fa-chair"></i> <span>Table Availability</span></a></li>
        <li><a href="<%= request.getContextPath() %>/ViewAllReservationsServlet"><i class="fas fa-calendar-check"></i> <span>Reservations</span></a></li>
        <li><a href="<%= request.getContextPath() %>/JSP/viewFeedback.jsp"><i class="fas fa-comment-dots"></i> <span>Feedbacks</span></a></li>
        <li><a href="JSP/Logout.jsp"><i class="fas fa-sign-out-alt"></i> <span>Logout</span></a></li>
    </ul>
</div>

<!-- Main Content -->
<div class="main-content">
    <div class="page-header">
        <h2><i class="fas fa-hotel me-2"></i>Restaurant Management</h2>
        <button class="btn btn-success" data-bs-toggle="modal" data-bs-target="#addHotelModal">
            <i class="fas fa-plus-circle me-2"></i> Add Restaurant
        </button>
    </div>

    <div class="table-container">
        <table class="table table-hover">
            <thead>
            <tr>
                <th>#</th>
                <th>Restaurant Name</th>
                <th>Description</th>
                <th>Features</th>
                <th>Image</th>
                <th>Actions</th>
            </tr>
            </thead>
            <tbody>
            <%
                List<Hotel> hotels = (List<Hotel>) request.getAttribute("hotels");
                if (hotels != null && !hotels.isEmpty()) {
                    int counter = 1;
                    for (Hotel hotel : hotels) {
                        String modalId = "editModal" + counter;
            %>
            <tr>
                <td><%= counter %></td>
                <td><strong><%= hotel.getName() %></strong></td>
                <td><%= hotel.getDescription() %></td>
                <td>
                    <div class="d-flex flex-wrap gap-2">
                        <% for (String feature : hotel.getFeatures()) { %>
                        <span class="badge bg-primary"><%= feature %></span>
                        <% } %>
                    </div>
                </td>
                <td>
                    <img src="<%= hotel.getImageUrl() %>" alt="<%= hotel.getName() %>" class="img-thumbnail">
                </td>
                <td class="action-buttons">
                    <button class="btn btn-primary btn-sm" data-bs-toggle="modal" data-bs-target="#<%= modalId %>">
                        <i class="fas fa-edit"></i> Edit
                    </button>
                    <form action="<%= request.getContextPath() %>/delete-hotel" method="post" onsubmit="return confirm('Are you sure you want to delete this restaurant?');" class="d-inline">
                        <input type="hidden" name="hotelName" value="<%= hotel.getName() %>">
                        <button type="submit" class="delete-btn">
                            <i class="fas fa-trash-alt"></i> Delete
                        </button>
                    </form>
                </td>
            </tr>

            <!-- Edit Modal -->
            <div class="modal fade" id="<%= modalId %>" tabindex="-1">
                <div class="modal-dialog modal-lg">
                    <div class="modal-content">
                        <form method="POST" action="edit-hotel">
                            <div class="modal-header">
                                <h5 class="modal-title">Edit <%= hotel.getName() %></h5>
                                <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                            </div>
                            <div class="modal-body">
                                <input type="hidden" name="originalName" value="<%= hotel.getName() %>"/>
                                <div class="row">
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Name</label>
                                        <input type="text" name="name" class="form-control" value="<%= hotel.getName() %>" required>
                                    </div>
                                    <div class="col-md-6 mb-3">
                                        <label class="form-label">Image URL</label>
                                        <input type="text" name="imageUrl" class="form-control" value="<%= hotel.getImageUrl() %>">
                                    </div>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Description</label>
                                    <textarea name="description" class="form-control" rows="3" required><%= hotel.getDescription() %></textarea>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Features (comma-separated)</label>
                                    <input type="text" name="features" class="form-control" value="<%= String.join(",", hotel.getFeatures()) %>" required>
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
                    counter++;
                }
            } else {
            %>
            <tr>
                <td colspan="6" class="no-data">
                    <i class="fas fa-hotel"></i>
                    <h4>No Restaurants Found</h4>
                    <p>Click "Add Restaurant" to create your first entry</p>
                </td>
            </tr>
            <% } %>
            </tbody>
        </table>
    </div>
</div>

<!-- Add Hotel Modal -->
<div class="modal fade" id="addHotelModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <form method="POST" action="add-hotel">
                <div class="modal-header">
                    <h5 class="modal-title">Add New Restaurant</h5>
                    <button type="button" class="btn-close btn-close-white" data-bs-dismiss="modal"></button>
                </div>
                <div class="modal-body">
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Restaurant Name</label>
                            <input type="text" name="name" class="form-control" required>
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Location</label>
                            <input type="text" name="location" class="form-control" required>
                        </div>
                    </div>
                    <div class="mb-3">
                        <label class="form-label">Description</label>
                        <textarea name="description" class="form-control" rows="3" required></textarea>
                    </div>
                    <div class="row">
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Image URL</label>
                            <input type="text" name="imageUrl" class="form-control">
                        </div>
                        <div class="col-md-6 mb-3">
                            <label class="form-label">Features (comma-separated)</label>
                            <input type="text" name="features" class="form-control" placeholder="e.g., Free WiFi,Pool,Spa" required>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Cancel</button>
                    <button type="submit" class="btn btn-primary">Add Restaurant</button>
                </div>
            </form>
        </div>
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