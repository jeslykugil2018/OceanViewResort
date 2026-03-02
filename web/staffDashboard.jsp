<%@page import="com.oceanview.model.User" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% User user=(User) session.getAttribute("user"); if (user==null || (!user.getRole().equals("Staff") &&
            !user.getRole().equals("Admin"))) { response.sendRedirect("login.jsp"); return; } %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Staff Dashboard - Ocean View</title>
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
                            <a href="staffDashboard.jsp">Staff Dashboard</a>
                            <button id="theme-toggle" class="btn btn-secondary"
                                style="padding: 0.5rem; width: 40px; height: 40px; border-radius: 50%;">
                                <i class="fas fa-moon"></i>
                            </button>
                            <a href="LogoutServlet" class="btn btn-secondary">Logout</a>
                        </div>
                    </div>
                </div>

                <div class="container">
                    <div style="margin-bottom: 60px;">
                        <h1>Staff Portal</h1>
                        <p>Welcome back, <span style="color: var(--primary-color); font-weight: 600;">
                                <%= user.getName() %>
                            </span>. Access operational tools below.</p>
                    </div>

                    <div class="portal-grid">
                        <a href="viewReservations.jsp" class="card portal-card">
                            <i class="fas fa-list-alt portal-icon"></i>
                            <h3>View All Reservations</h3>
                            <p>Access the global list of all bookings, monitor check-ins, and manage cancellations.</p>
                        </a>

                        <a href="walkinReservation.jsp" class="card portal-card">
                            <i class="fas fa-user-plus portal-icon"></i>
                            <h3>Add Walk-in Booking</h3>
                            <p>Register new guests arriving at the resort and book rooms immediately.</p>
                        </a>

                        <a href="staffHelp.jsp" class="card portal-card">
                            <i class="fas fa-info-circle portal-icon"></i>
                            <h3>Staff Guidelines</h3>
                            <p>Read the operational manual for reservation management and resort policies.</p>
                        </a>
                    </div>

                    <% if(user.getRole().equals("Admin")) { %>
                        <div style="margin-top: 50px; text-align: center;">
                            <a href="adminDashboard.jsp" class="btn btn-secondary" style="padding: 12px 30px;">
                                <i class="fas fa-user-shield"></i> Switch to Admin Panel
                            </a>
                        </div>
                        <% } %>
                </div>

                <jsp:include page="footer.jsp" />
                <script src="js/themeSwitcher.js"></script>
            </body>

            </html>