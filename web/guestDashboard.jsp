<%@page import="com.oceanview.model.User" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% User user=(User) session.getAttribute("user"); if (user==null) { response.sendRedirect("login.jsp"); return;
            } %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Guest Dashboard - Ocean View</title>
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
                            <a href="guestDashboard.jsp">Guest Dashboard</a>
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
                        <h1>Welcome, <%= user.getName() %>.</h1>
                        <p>Your sanctuary awaits. How may we assist you today?</p>
                    </div>

                    <div class="portal-grid">
                        <a href="checkAvailability.jsp" class="card portal-card">
                            <i class="fas fa-bed portal-icon"></i>
                            <h3>Book a New Room</h3>
                            <p>Explore our beautiful rooms and secure your next stay at Ocean View Resort.</p>
                        </a>

                        <a href="myReservations.jsp" class="card portal-card">
                            <i class="fas fa-calendar-check portal-icon"></i>
                            <h3>My Reservations</h3>
                            <p>View your upcoming bookings, cancel reservations, or download your invoices.</p>
                        </a>

                        <a href="guestHelp.jsp" class="card portal-card">
                            <i class="fas fa-umbrella-beach portal-icon"></i>
                            <h3>Guest Support</h3>
                            <p>Need help? Read our guest guide for booking tips and resort policies.</p>
                        </a>
                    </div>
                </div>

                <jsp:include page="footer.jsp" />
                <script src="js/themeSwitcher.js"></script>
            </body>

            </html>