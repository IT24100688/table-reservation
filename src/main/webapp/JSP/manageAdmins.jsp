<%@ page import="java.util.List" %>
<%@ page import="com.restaurant.model.Admin" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Super Admin Dashboard</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f0f0f0; }
        h2 { color: #333; }
        form { margin-bottom: 20px; background: white; padding: 20px; border-radius: 8px; box-shadow: 0 0 10px #ccc; }
        input { padding: 8px; margin: 5px; width: 200px; }
        button { padding: 10px; background: #141E30; color: white; border: none; border-radius: 5px; }
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: center; }
        th { background: #243B55; color: white; }
    </style>
</head>
<body>
<h2>Super Admin Panel</h2>

<!-- Add Admin Form -->
<form action="add-admin" method="post">
    <h3>Add New Admin</h3>
    <input type="text" name="username" placeholder="Username" required>
    <input type="password" name="password" placeholder="Password" required>
    <button type="submit">Add Admin</button>
</form>

<!-- Remove Admin Form -->
<form action="remove-admin" method="post">
    <h3>Remove Admin by Username</h3>
    <input type="text" name="username" placeholder="Username to remove" required>
    <button type="submit">Remove Admin</button>
</form>

<!-- Admin List -->
<h3>Current Admins</h3>
<%
    List<Admin> admins = (List<Admin>) request.getAttribute("admins");
    if (admins != null && !admins.isEmpty()) {
%>
<table>
    <tr>
        <th>Username</th>
        <th>Password</th>
    </tr>
    <% for (Admin a : admins) { %>
    <tr>
        <td><%= a.getUsername() %></td>
        <td><%= a.getPassword() %></td>
    </tr>
    <% } %>
</table>
<% } else { %>
<p>No admins found.</p>
<% } %>

</body>
</html>
