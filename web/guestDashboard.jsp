<%@page import="com.oceanview.model.User" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% User user=(User) session.getAttribute("user"); if (user==null) { response.sendRedirect("login.jsp"); return;
            } %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Guest Dashboard - Ocean View</title>
                <link rel="stylesheet" href="css/dark-theme.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                <style>
                    .portal-grid {
                        display: grid;
                        grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
                        gap: 30px;
                        margin-top: 40px;
                    }

                    .portal-card {
                        transition: transform 0.3s ease, box-shadow 0.3s ease;
                        cursor: pointer;
                        text-decoration: none;
                        color: inherit;
                        display: flex;
                        flex-direction: column;
                        align-items: center;
                        text-align: center;
                        padding: 40px 20px;
                    }

                    .portal-card:hover {
                        transform: translateY(-10px);
                        box-shadow: 0 15px 30px rgba(0, 0, 0, 0.4);
                        border-color: var(--accent-light);
                    }

                    .portal-icon {
                        font-size: 3em;
                        color: var(--accent-light);
                        margin-bottom: 20px;
                    }

                    .portal-card h3 {
                        margin-bottom: 15px;
                        color: var(--accent-secondary);
                    }

                    .portal-card p {
                        opacity: 0.8;
                        font-size: 0.95em;
                        line-height: 1.5;
                    }
                </style>
            </head>

            <body>
                <div class="navbar">
                    <div class="logo"><i class="fas fa-water" style="color: var(--accent-light); margin-right: 8px;"></i> Ocean View Resort</div>
                    <div class="nav-links">
                        <a href="guestDashboard.jsp" class="active">Guest Dashboard</a>
                        <a href="LogoutServlet" class="btn btn-secondary"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </div>
                </div>

                <div class="container">
                    <div style="margin-bottom: 40px;">
                        <h1 style="font-size: 2.5em;">Welcome, <span style="color: var(--accent-light);">
                                <%= user.getName() %>
                            </span>!</h1>
                        <p style="opacity: 0.7; font-size: 1.1em;">We're delighted to have you with us. How can we help
                            you today?</p>
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
</body>

            </html>
