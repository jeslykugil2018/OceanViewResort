<%@page import="com.oceanview.model.User" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% User user=(User) session.getAttribute("user"); if (user==null) { response.sendRedirect("login.jsp"); return;
            } %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Guest Support - Ocean View</title>
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
                            <a href="guestDashboard.jsp">Dashboard</a>
                            <button id="theme-toggle" class="btn btn-secondary"
                                style="padding: 0.5rem; width: 40px; height: 40px; border-radius: 50%;">
                                <i class="fas fa-moon"></i>
                            </button>
                            <a href="LogoutServlet" class="btn btn-secondary">Logout</a>
                        </div>
                    </div>
                </div>

                <div class="container">
                    <div style="margin-bottom: 4rem;">
                        <h1>Support Center</h1>
                        <p>Everything you need to know about your stay at Ocean View Resort.</p>
                    </div>

                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem;">
                        <div class="card">
                            <h3>Booking Your Stay</h3>
                            <p>Navigate to <strong>"Book Room"</strong> to view real-time availability. You can filter
                                by dates to find the perfect room for your vacation.</p>
                            <p>Once you confirm a booking, it will appear instantly on your dashboard and you'll receive
                                a confirmation email.</p>
                        </div>

                        <div class="card">
                            <h3>Managing Reservations</h3>
                            <p>Need to change your plans? You can cancel any <strong>Confirmed</strong> reservation
                                directly from your dashboard up to 24 hours before check-in.</p>
                            <p>Your dashboard tracks every booking: <strong>Confirmed</strong>, <strong>Checked
                                    In</strong>, or <strong>Cancelled</strong>.</p>
                        </div>

                        <div class="card">
                            <h3>Bills & Payments</h3>
                            <p>Click the <strong>"Bill PDF"</strong> button next to any reservation to download a
                                detailed breakdown of your charges.</p>
                            <p>All transactions are processed securely. Your invoice serves as a valid proof of payment
                                for all resort services.</p>
                        </div>
                    </div>

                    <div style="margin-top: 40px; text-align: center;">
                        <a href="guestDashboard.jsp" class="btn btn-primary"
                            style="padding: 15px 40px; font-size: 1.1em;">
                            <i class="fas fa-home"></i> Back to Dashboard
                        </a>
                    </div>
                </div>

                <jsp:include page="footer.jsp" />
                <script src="js/themeSwitcher.js"></script>
            </body>

            </html>