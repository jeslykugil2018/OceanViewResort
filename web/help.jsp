<%@page import="com.oceanview.model.User" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% User user=(User) session.getAttribute("user"); String role=(user !=null) ? user.getRole() : "Guest" ; %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Help - Ocean View Resort</title>
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
                        </div>
                    </div>
                </div>

                <div class="container">
                    <div class="card">
                        <h2>Help Center</h2>
                        <p>Guidance for using the Ocean View management system.</p>

                        <% if (role.equals("Guest")) { %>
                            <div style="margin-top: 2rem;">
                                <h3>Guest Experience</h3>
                                <ul style="list-style: none; padding: 0; margin-top: 1rem;">
                                    <li style="margin-bottom: 1rem;">
                                        <strong>Booking:</strong> Navigate to "Check Availability" to secure your stay.
                                    </li>
                                    <li style="margin-bottom: 1rem;">
                                        <strong>Management:</strong> View or cancel your bookings via the Dashboard.
                                    </li>
                                    <li style="margin-bottom: 1rem;">
                                        <strong>Invoices:</strong> Download professional PDF receipts post-booking.
                                    </li>
                                </ul>
                            </div>
                            <% } else { %>
                                <div style="margin-top: 2rem;">
                                    <h3>Staff & Admin Operations</h3>
                                    <ul style="list-style: none; padding: 0; margin-top: 1rem;">
                                        <li style="margin-bottom: 1rem;">
                                            <strong>Inventory:</strong> Manage rooms and pricing from the Admin Panel.
                                        </li>
                                        <li style="margin-bottom: 1rem;">
                                            <strong>Bookings:</strong> Oversee all reservations and guest arrivals.
                                        </li>
                                        <li style="margin-bottom: 1rem;">
                                            <strong>Security:</strong> Maintain audit logs and staff permissions.
                                        </li>
                                    </ul>
                                </div>
                                <% } %>
                    </div>
                </div>

                <jsp:include page="footer.jsp" />
                <script src="js/themeSwitcher.js"></script>
            </body>

            </html>