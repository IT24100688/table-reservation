<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Update Profile</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
    <style>
        body {
            font-family: 'Poppins', sans-serif;
            margin: 0;
            background: #f6f5f7;
            padding: 30px;
        }

        .card {
            box-shadow: 0 0 20px rgba(0, 0, 0, 0.1);
            border: none;
        }

        .card-header {
            background: #141E30;
            color: white;
            font-weight: bold;
        }

        .btn-primary {
            background-color: #141E30;
            border: none;
        }

        .btn-primary:hover {
            background-color: #1823dd;
        }

        .btn-secondary {
            background-color: #6c757d;
            border: none;
        }
    </style>
</head>
<body>
<div class="container mt-5">
    <div class="row justify-content-center">
        <div class="col-md-6">
            <div class="card">
                <div class="card-header">
                    <h3>Update Your Profile</h3>
                </div>
                <div class="card-body">
                    <% if (request.getAttribute("error") != null) { %>
                    <div class="alert alert-danger">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>
                    <% if (request.getAttribute("message") != null) { %>
                    <div class="alert alert-success">
                        <%= request.getAttribute("message") %>
                    </div>
                    <% } %>

                    <form action="update-profile" method="post">
                        <div class="mb-3">
                            <label for="name" class="form-label">Name</label>
                            <input type="text" class="form-control" id="name" name="name"
                                   value="<%= session.getAttribute("name") != null ? session.getAttribute("name") : "" %>" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email</label>
                            <input type="email" class="form-control" id="email"
                                   value="<%= session.getAttribute("email") != null ? session.getAttribute("email") : "" %>" readonly>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone</label>
                            <input type="text" class="form-control" id="phone" name="phone"
                                   value="<%= session.getAttribute("phone") != null ? session.getAttribute("phone") : "" %>">
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <textarea class="form-control" id="address" name="address" rows="3"><%= session.getAttribute("address") != null ? session.getAttribute("address") : "" %></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">New Password (leave blank to keep current)</label>
                            <input type="password" class="form-control" id="password" name="password">
                        </div>
                        <div class="d-flex justify-content-between">
                            <button type="submit" class="btn btn-primary">Update Profile</button>
                            <a href="user-dashboard" class="btn btn-secondary">Cancel</a>
                        </div>
                    </form>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html>