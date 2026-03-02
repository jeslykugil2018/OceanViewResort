<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Sign Up - Ocean View Resort</title>
        <link rel="stylesheet" href="css/base.css">
        <link rel="stylesheet" href="css/light-theme.css" id="theme-link">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                    <a href="index.jsp">Home</a>
                    <button id="theme-toggle" class="btn btn-secondary"
                        style="padding: 0.5rem; width: 40px; height: 40px; border-radius: 50%;">
                        <i class="fas fa-moon"></i>
                    </button>
                    <% com.oceanview.model.User user=(com.oceanview.model.User) session.getAttribute("user"); if (user
                        !=null) { String dashboard="guestDashboard.jsp" ; if (user.getRole().equals("Admin"))
                        dashboard="adminDashboard.jsp" ; else if (user.getRole().equals("Staff"))
                        dashboard="staffDashboard.jsp" ; %>
                        <a href="<%= dashboard %>">Dashboard</a>
                        <% } else { %>
                            <a href="login.jsp">Login</a>
                            <% } %>
                </div>
            </div>
        </div>

        <div class="container" style="max-width: 600px;">
            <div class="card">
                <h2 style="text-align: center;">
                    <%= (user !=null && user.getRole().equals("Admin")) ? "Create Staff Account" : "Create Your Account"
                        %>
                </h2>
                <p style="text-align: center; margin-bottom: 2rem;">Join Ocean View Resort today.</p>
                <% if (request.getAttribute("error") !=null) { %>
                    <div class="alert alert-error">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>

                        <form action="SignupServlet" method="POST">
                            <div class="form-group">
                                <label>Full Name</label>
                                <input type="text" name="name" required minlength="2">
                            </div>
                            <div class="form-group">
                                <label>Username</label>
                                <input type="text" name="username" required minlength="4">
                            </div>
                            <div class="form-group">
                                <label>Email Address</label>
                                <input type="email" name="email" required>
                            </div>
                            <div class="form-group">
                                <label>Contact Number</label>
                                <input type="tel" name="contact" required pattern="^[0-9]{10}$">
                            </div>
                            <div class="form-group">
                                <label>Address</label>
                                <textarea name="address" required minlength="5" style="height: 100px;"></textarea>
                            </div>
                            <div class="form-group">
                                <label>Password</label>
                                <input type="password" name="password" required minlength="6">
                            </div>

                            <% if (user !=null && user.getRole().equals("Admin")) { %>
                                <div class="form-group">
                                    <label>Assign Role</label>
                                    <select name="role">
                                        <option value="Staff">Staff</option>
                                        <option value="Admin">Admin</option>
                                    </select>
                                </div>
                                <% } else { %>
                                    <input type="hidden" name="role" value="Guest">
                                    <% } %>

                                        <button type="submit" class="btn btn-secondary"
                                            style="width: 100%; margin-top: 10px;">
                                            Create Account
                                        </button>
                        </form>
                        <p style="text-align: center; margin-top: 20px;">
                            Already a member? <a href="login.jsp">Login here</a>
                        </p>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
        <script src="js/themeSwitcher.js"></script>
    </body>

    </html>