<%@page import="com.oceanview.model.User" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% User user=(User) session.getAttribute("user"); if (user==null || (!user.getRole().equals("Staff") &&
            !user.getRole().equals("Admin"))) { response.sendRedirect("login.jsp"); return; } %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Staff Guidelines - Ocean View</title>
                <link rel="stylesheet" href="css/light-theme.css">
                <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
            </head>

            <body>
                <div class="navbar">
                    <div class="logo"><i class="fas fa-water"
                            style="color: var(--accent-light); margin-right: 8px;"></i> Ocean View Resort</div>
                    <div class="nav-links">
                        <a href="staffDashboard.jsp">Back to Dashboard</a>
                        <a href="LogoutServlet" class="btn btn-secondary"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </div>
                </div>

                <div class="container">
                    <div style="text-align: center; margin-bottom: 40px;">
                        <h1 style="color: var(--accent-light); font-size: 2.5em;"><i class="fas fa-book-reader"></i>
                            Staff Guidelines & Manual</h1>
                        <p style="opacity: 0.7;">Comprehensive guide for managing the Ocean View Reservation System</p>
                    </div>

                    <div class="card" style="border-left: 5px solid var(--accent-light);">
                        <h3><i class="fas fa-plus-circle"
                                style="color: var(--accent-light); margin-right: 15px;"></i>Reservation Management</h3>
                        <div
                            style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; margin-top: 20px;">
                            <div>
                                <h4 style="color: var(--accent-secondary); margin-bottom: 10px;">Walk-in Bookings</h4>
                                <p style="line-height: 1.6; opacity: 0.9;">To create a walk-in reservation, navigate to
                                    <strong>"Add Reservation"</strong>. Collect the guest's full details (Name, Email,
                                    Contact, Address). The system will check for existing profiles using the email
                                    provided.
                                </p>
                            </div>
                            <div>
                                <h4 style="color: var(--accent-secondary); margin-bottom: 10px;">Cancellations</h4>
                                <p style="line-height: 1.6; opacity: 0.9;">Reservations can be canceled directly from
                                    the dashboard. Once canceled, the room status is automatically reverted to
                                    <strong>'Available'</strong>.
                                </p>
                            </div>
                        </div>
                    </div>

                    <div class="card" style="margin-top: 30px; border-left: 5px solid var(--accent-secondary);">
                        <h3><i class="fas fa-file-invoice-dollar"
                                style="color: var(--accent-secondary); margin-right: 15px;"></i>Billing & Finance</h3>
                        <div
                            style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 30px; margin-top: 20px;">
                            <div>
                                <h4 style="color: var(--accent-secondary); margin-bottom: 10px;">Generating Invoices
                                </h4>
                                <p style="line-height: 1.6; opacity: 0.9;">Invoices are created as PDF documents. Go to
                                    the Guest Dashboard view for a specific reservation and select <strong>"View
                                        Bill"</strong> to download the PDF.</p>
                            </div>
                            <div>
                                <h4 style="color: var(--accent-secondary); margin-bottom: 10px;">Pricing Snapshots</h4>
                                <p style="line-height: 1.6; opacity: 0.9;">The system takes a snapshot of room rates and
                                    guest details at the time of booking. Changes to room prices later will not affect
                                    existing confirmed reservations.</p>
                            </div>
                        </div>
                    </div>

                    <div class="card" style="margin-top: 30px; border-left: 5px solid #2ecc71;">
                        <h3><i class="fas fa-shield-alt" style="color: #2ecc71; margin-right: 15px;"></i>Best Practices
                        </h3>
                        <ul style="line-height: 2; opacity: 0.9; padding-left: 20px;">
                            <li>Always verify the guest's email address to maintain accurate historical records.</li>
                            <li>Ensure check-in and check-out dates are entered correctly to avoid pricing
                                discrepancies.</li>
                            <li>Promptly cancel reservations if a guest does not show up to keep room availability
                                accurate.</li>
                            <li>Use the dashboard search/sort features (where available) to quickly locate reservations.
                            </li>
                        </ul>
                    </div>

                    <div style="margin-top: 40px; text-align: center;">
                        <a href="staffDashboard.jsp" class="btn btn-primary"
                            style="padding: 15px 40px; font-size: 1.1em;">
                            <i class="fas fa-arrow-left"></i> Return to Staff Console
                        </a>
                    </div>
                </div>

                <jsp:include page="footer.jsp" />
            </body>

            </html>