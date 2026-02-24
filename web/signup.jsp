<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Sign Up - Ocean View Resort</title>
        <link rel="stylesheet" href="css/dark-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>

    <body>
        <div class="navbar">
            <div class="logo"><i class="fas fa-water" style="color: var(--accent-light); margin-right: 8px;"></i> Ocean
                View Resort</div>
            <div class="nav-links">
                <a href="index.jsp">Home</a>
                <% com.oceanview.model.User user=(com.oceanview.model.User) session.getAttribute("user"); if (user
                    !=null) { String dashboard="guestDashboard.jsp" ; if (user.getRole().equals("Admin"))
                    dashboard="adminDashboard.jsp" ; else if (user.getRole().equals("Staff"))
                    dashboard="staffDashboard.jsp" ; %>
                    <a href="<%= dashboard %>">Back to Dashboard</a>
                    <% } else { %>
                        <a href="login.jsp">Login</a>
                        <% } %>
            </div>
        </div>

        <div class="container" style="max-width: 500px; margin-top: 50px;">
            <div class="card">
                <h2 style="text-align: center;"><i class="fas fa-user-plus"
                        style="color: var(--accent-light); margin-right: 15px;"></i>
                    <%= (user !=null && user.getRole().equals("Admin")) ? "Create Staff Account" : "Join Us" %>
                </h2>
                <% if (request.getAttribute("error") !=null) { %>
                    <div class="alert alert-error">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>

                        <form action="SignupServlet" method="POST">
                            <label>Full Name</label>
                            <input type="text" name="name" required minlength="2"
                                title="Please enter your full name (minimum 2 characters).">
                            <label>Username</label>
                            <input type="text" name="username" required minlength="4" pattern="^[a-zA-Z0-9_]+$"
                                title="Username must be at least 4 characters long and contain only letters, numbers, and underscores.">
                            <label>Email</label>
                            <input type="email" name="email" required title="Please enter a valid email address.">
                            <label>Contact Number</label>
                            <input type="tel" name="contact" required pattern="^[0-9]{10}$"
                                title="Contact number must be exactly 10 digits.">
                            <label>Address</label>
                            <textarea name="address" required minlength="5" title="Please provide a valid address."
                                style="width: 100%; height: 60px; background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 8px; color: white; padding: 10px; margin-bottom: 15px;"></textarea>
                            <label>Password</label>
                            <input type="password" name="password" required minlength="6"
                                title="Password must be at least 6 characters long.">

                            <% if (user !=null && user.getRole().equals("Admin")) { %>
                                <label>Assign Role</label>
                                <select name="role"
                                    style="width: 100%; background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 8px; color: white; padding: 10px; margin-bottom: 15px;">
                                    <option value="Staff">Staff</option>
                                    <option value="Admin">Admin</option>
                                </select>
                                <% } else { %>
                                    <input type="hidden" name="role" value="Guest">
                                    <% } %>

                                        <button type="submit" class="btn btn-secondary"
                                            style="width: 100%; margin-top: 20px;"><i class="fas fa-user-check"></i>
                                            Create Account</button>
                        </form>
                        <p style="text-align: center; margin-top: 20px;">
                            Already a member? <a href="login.jsp">Login here</a>
                        </p>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

    </html>