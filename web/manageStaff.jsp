<%@page import="com.oceanview.model.User" %>
    <%@page import="com.oceanview.dao.UserDAO" %>
        <%@page import="java.util.List" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <% User user=(User) session.getAttribute("user"); if (user==null || !user.getRole().equals("Admin")) {
                    response.sendRedirect("login.jsp"); return; } UserDAO userDAO=new UserDAO(); List<User> staffList =
                    userDAO.getAllStaff();
                    %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <title>Staff Management - Ocean View</title>
                        <link rel="stylesheet" href="css/base.css">
                        <link rel="stylesheet" href="css/light-theme.css" id="theme-link">
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                        <script>
                            (function () {
                                const savedTheme = localStorage.getItem('ocean-view-theme') || 'light';
                                document.getElementById('theme-link').setAttribute('href', `css/${savedTheme}-theme.css`);
                            })();
                        </script>
                    </head>

                    <body>
                        <div class="navbar">
                            <div class="container">
                                <a href="index.jsp" class="logo">
                                    <i class="fas fa-water"></i> Ocean View Resort
                                </a>
                                <div class="nav-links">
                                    <a href="adminDashboard.jsp">Dashboard</a>
                                    <button id="theme-toggle" class="btn btn-secondary"
                                        style="padding: 0.5rem; width: 40px; height: 40px; border-radius: 50%;">
                                        <i class="fas fa-moon"></i>
                                    </button>
                                    <a href="LogoutServlet" class="btn btn-secondary">Logout</a>
                                </div>
                            </div>
                        </div>

                        <div class="container">
                            <div
                                style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 3rem;">
                                <div>
                                    <h1>Staff Management</h1>
                                    <p>Monitor and manage resort personnel and administrative access.</p>
                                </div>
                                <a href="signup.jsp" class="btn btn-primary">
                                    Register New Staff
                                </a>
                            </div>

                            <% if (request.getParameter("msg") !=null) { %>
                                <div class="alert alert-success"
                                    style="padding: 1rem; border-radius: 8px; margin-bottom: 2rem; background: var(--success-bg); color: var(--success-text); border: 1px solid var(--success-text);">
                                    <%= request.getParameter("msg") %>
                                </div>
                                <% } %>
                                    <% if (request.getParameter("error") !=null) { %>
                                        <div class="alert alert-error"
                                            style="padding: 1rem; border-radius: 8px; margin-bottom: 2rem; background: var(--error-bg); color: var(--error-text); border: 1px solid var(--error-text);">
                                            <%= request.getParameter("error") %>
                                        </div>
                                        <% } %>

                                            <div class="card" style="padding: 1.5rem;">
                                                <div class="table-container">
                                                    <table>
                                                        <thead>
                                                            <tr>
                                                                <th>Name</th>
                                                                <th>Username</th>
                                                                <th>Email</th>
                                                                <th>Role</th>
                                                                <th style="text-align: right;">Actions</th>
                                                            </tr>
                                                        </thead>
                                                        <tbody>
                                                            <% for (User s : staffList) { %>
                                                                <tr>
                                                                    <td><strong>
                                                                            <%= s.getName() %>
                                                                        </strong></td>
                                                                    <td>
                                                                        <%= s.getUsername() %>
                                                                    </td>
                                                                    <td>
                                                                        <%= s.getEmail() %>
                                                                    </td>
                                                                    <td>
                                                                        <% String sRole=s.getRole(); String
                                                                            sBadgeStyle="Admin" .equals(sRole)
                                                                            ? "background: var(--primary-color); color: white;"
                                                                            : "background: var(--secondary-bg); color: var(--text-primary);"
                                                                            ; %>
                                                                            <span class="badge"
                                                                                style="<%= sBadgeStyle %> opacity: 0.9;">
                                                                                <%= sRole %>
                                                                            </span>
                                                                    </td>
                                                                    <td style="text-align: right;">
                                                                        <div
                                                                            style="display: flex; gap: 10px; justify-content: flex-end;">
                                                                            <button class="btn btn-secondary"
                                                                                style="padding: 0.4rem 0.8rem; font-size: 0.8rem;"
                                                                                onclick="showEditModal(<%= s.getUserId() %>, '<%= s.getName() %>', '<%= s.getUsername() %>', '<%= s.getEmail() %>', '<%= s.getContact() %>', '<%= s.getAddress() %>', '<%= s.getRole() %>')">
                                                                                Edit
                                                                            </button>
                                                                            <% if (s.getUserId() !=user.getUserId()) {
                                                                                %>
                                                                                <form action="UserServlet" method="POST"
                                                                                    style="margin: 0;"
                                                                                    onsubmit="return confirm('Remove this user access?')">
                                                                                    <input type="hidden" name="action"
                                                                                        value="delete">
                                                                                    <input type="hidden" name="userId"
                                                                                        value="<%= s.getUserId() %>">
                                                                                    <button type="submit"
                                                                                        class="btn btn-secondary"
                                                                                        style="padding: 0.4rem 0.8rem; font-size: 0.8rem; border-color: var(--error-text); color: var(--error-text);">
                                                                                        Delete
                                                                                    </button>
                                                                                </form>
                                                                                <% } %>
                                                                        </div>
                                                                    </td>
                                                                </tr>
                                                                <% } %>
                                                        </tbody>
                                                    </table>
                                                </div>
                                            </div>
                        </div>

                        <!-- Edit User Modal -->
                        <div id="userModal" class="modal"
                            style="display:none; position:fixed; z-index:2000; left:0; top:0; width:100%; height:100%; background: var(--bg-color); padding: 2rem; overflow-y: auto;">
                            <div class="container" style="max-width: 500px; padding: 2rem 0;">
                                <div class="card">
                                    <h2 id="modalTitle">Edit Staff Account</h2>
                                    <p>Update personnel details below.</p>
                                    <form action="UserServlet" method="POST" style="margin-top: 2rem;">
                                        <input type="hidden" name="action" value="update">
                                        <input type="hidden" name="userId" id="userIdInput">

                                        <div class="form-group">
                                            <label>Full Name</label>
                                            <input type="text" name="name" id="nameInput" required>
                                        </div>

                                        <div class="form-group">
                                            <label>Username</label>
                                            <input type="text" name="username" id="usernameInput" required>
                                        </div>

                                        <div class="form-group">
                                            <label>Email Address</label>
                                            <input type="email" name="email" id="emailInput" required>
                                        </div>

                                        <div class="form-group">
                                            <label>Contact Number</label>
                                            <input type="tel" name="contact" id="contactInput" required>
                                        </div>

                                        <div class="form-group">
                                            <label>Resident Address</label>
                                            <textarea name="address" id="addressInput" required
                                                style="height: 80px;"></textarea>
                                        </div>

                                        <div class="form-group">
                                            <label>Access Role</label>
                                            <select name="role" id="roleInput">
                                                <option value="Staff">Staff</option>
                                                <option value="Admin">Admin</option>
                                            </select>
                                        </div>

                                        <div
                                            style="display:grid; grid-template-columns: 1fr 1fr; gap:10px; margin-top:2rem;">
                                            <button type="submit" class="btn btn-primary">Save Changes</button>
                                            <button type="button" class="btn btn-secondary"
                                                onclick="hideModal()">Discard</button>
                                        </div>
                                    </form>
                                </div>
                            </div>
                        </div>

                        <script>
                            function showEditModal(id, name, username, email, contact, address, role) {
                                document.getElementById('userIdInput').value = id;
                                document.getElementById('nameInput').value = name;
                                document.getElementById('usernameInput').value = username;
                                document.getElementById('emailInput').value = email;
                                document.getElementById('contactInput').value = contact;
                                document.getElementById('addressInput').value = address;
                                document.getElementById('roleInput').value = role;
                                document.getElementById('userModal').style.display = 'block';
                            }

                            function hideModal() {
                                document.getElementById('userModal').style.display = 'none';
                            }
                        </script>

                        <jsp:include page="footer.jsp" />
                        <script src="js/themeSwitcher.js"></script>
                    </body>

                    </html>