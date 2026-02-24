<%@page import="com.oceanview.model.User" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% User user=(User) session.getAttribute("user"); String role=(user !=null) ? user.getRole() : "Guest" ; %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Help & Support - Ocean View</title>
                <link rel="stylesheet" href="css/dark-theme.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            </head>

            <body>
                <div class="navbar">
                    <div class="logo"><i class="fas fa-water"
                            style="color: var(--accent-light); margin-right: 8px;"></i> Ocean View Resort</div>
                    <div class="nav-links">
                        <a href="index.jsp">Home</a>
                    </div>
                </div>

                <div class="container">
                    <div class="card">
                        <h2><i class="fas fa-question-circle"
                                style="color: var(--accent-light); margin-right: 15px;"></i>Help Center</h2>

                        <% if (role.equals("Guest")) { %>
                            <h3><i class="fas fa-user" style="margin-right: 10px;"></i>Guest Instructions</h3>
                            <ul>
                                <li><strong>Booking:</strong> Go to "Check Availability", select your dates, choose a
                                    room, and follow the prompts.</li>
                                <li><strong>Cancellations:</strong> You can cancel your reservation from your dashboard
                                    at least 24 hours in advance.</li>
                                <li><strong>Billing:</strong> Download your PDF bill from the dashboard after a
                                    confirmed booking.</li>
                            </ul>
                            <% } else { %>
                                <h3><i class="fas fa-user-cog" style="margin-right: 10px;"></i>Staff & Admin
                                    Instructions</h3>
                                <ul>
                                    <li><strong>Room Management:</strong> Admins can add or edit room details from the
                                        Admin Dashboard.</li>
                                    <li><strong>Reservations:</strong> Staff can view and cancel any reservation from
                                        the Staff Dashboard.</li>
                                    <li><strong>Reports:</strong> Admins can generate summaries of all bookings.</li>
                                </ul>
                                <% } %>
                    </div>
                </div>

                <jsp:include page="footer.jsp" />
            </body>

            </html>