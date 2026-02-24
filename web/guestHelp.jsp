<%@page import="com.oceanview.model.User" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% User user=(User) session.getAttribute("user"); if (user==null) { response.sendRedirect("login.jsp"); return;
            } %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Guest Guidelines - Ocean View</title>
                <link rel="stylesheet" href="css/dark-theme.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            </head>

            <body>
                <div class="navbar">
                    <div class="logo"><i class="fas fa-water" style="color: var(--accent-light); margin-right: 8px;"></i> Ocean View Resort</div>
                    <div class="nav-links">
                        <a href="guestDashboard.jsp">Back to Dashboard</a>
                        <a href="LogoutServlet" class="btn btn-secondary"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </div>
                </div>

                <div class="container">
                    <div style="text-align: center; margin-bottom: 40px;">
                        <h1 style="color: var(--accent-light); font-size: 2.5em;"><i class="fas fa-umbrella-beach"></i>
                            Guest Support & Help</h1>
                        <p style="opacity: 0.7;">Everything you need to know about your stay at Ocean View Resort</p>
                    </div>

                    <div class="card" style="border-left: 5px solid var(--accent-light);">
                        <h3><i class="fas fa-calendar-plus"
                                style="color: var(--accent-light); margin-right: 15px;"></i>Booking Your Stay</h3>
                        <div
                            style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; margin-top: 20px;">
                            <div>
                                <h4 style="color: var(--accent-secondary); margin-bottom: 10px;">Finding a Room</h4>
                                <p style="line-height: 1.6; opacity: 0.9;">Navigate to <strong>"Book Room"</strong> to
                                    view real-time availability. You can filter by dates to find the perfect room for
                                    your vacation.</p>
                            </div>
                            <div>
                                <h4 style="color: var(--accent-secondary); margin-bottom: 10px;">Confirmation</h4>
                                <p style="line-height: 1.6; opacity: 0.9;">Once you confirm a booking, it will appear
                                    instantly on your dashboard. You'll also receive a confirmation email with your
                                    reservation details.</p>
                            </div>
                        </div>
                    </div>

                    <div class="card" style="margin-top: 30px; border-left: 5px solid var(--accent-secondary);">
                        <h3><i class="fas fa-tasks"
                                style="color: var(--accent-secondary); margin-right: 15px;"></i>Managing Reservations
                        </h3>
                        <div
                            style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; margin-top: 20px;">
                            <div>
                                <h4 style="color: var(--accent-secondary); margin-bottom: 10px;">Cancellations</h4>
                                <p style="line-height: 1.6; opacity: 0.9;">Need to change your plans? You can cancel any
                                    <strong>Confirmed</strong> reservation directly from your dashboard up to 24 hours
                                    before check-in.</p>
                            </div>
                            <div>
                                <h4 style="color: var(--accent-secondary); margin-bottom: 10px;">Status Updates</h4>
                                <p style="line-height: 1.6; opacity: 0.9;">Your dashboard shows the current status of
                                    every booking: <strong>Confirmed</strong>, <strong>Checked In</strong>, or
                                    <strong>Cancelled</strong>.</p>
                            </div>
                        </div>
                    </div>

                    <div class="card" style="margin-top: 30px; border-left: 5px solid #e74c3c;">
                        <h3><i class="fas fa-file-pdf" style="color: #e74c3c; margin-right: 15px;"></i>Bills & Payments
                        </h3>
                        <div
                            style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; margin-top: 20px;">
                            <div>
                                <h4 style="color: var(--accent-secondary); margin-bottom: 10px;">Download Invoice</h4>
                                <p style="line-height: 1.6; opacity: 0.9;">Click the <strong>"Bill PDF"</strong> button
                                    next to any reservation to download a detailed breakdown of your charges, including
                                    tax and service fees.</p>
                            </div>
                            <div>
                                <h4 style="color: var(--accent-secondary); margin-bottom: 10px;">Secure Payments</h4>
                                <p style="line-height: 1.6; opacity: 0.9;">All transactions are processed securely. Your
                                    invoice serves as a valid proof of payment for all resort services.</p>
                            </div>
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
</body>

            </html>
