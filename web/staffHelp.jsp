<%@page import="com.oceanview.model.User" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% User user=(User) session.getAttribute("user"); if (user==null || (!user.getRole().equals("Staff") &&
            !user.getRole().equals("Admin"))) { response.sendRedirect("login.jsp"); return; } %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Staff Protocols - Ocean View</title>
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
                            <a href="staffDashboard.jsp">Dashboard</a>
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
                        <h1>Operational Manual</h1>
                        <p>Comprehensive procedures for the Ocean View Management System.</p>
                    </div>

                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 2rem;">
                        <div class="card">
                            <h3>Reservation Management</h3>
                            <p>To create a walk-in booking, use <strong>"New Walk-in"</strong>. Ensure guest contact
                                details are accurately captured for automated confirmations.</p>
                            <p>Cancellations instantly update room inventory for immediate re-booking.</p>
                        </div>

                        <div class="card">
                            <h3>Billing Protocols</h3>
                            <p>Invoices are generated as high-fidelity PDFs. Always offer a digital copy to guests upon
                                check-out or payment.</p>
                            <p>System pricing snapshots ensure historical rate integrity for existing bookings.</p>
                        </div>

                        <div class="card" style="grid-column: 1 / -1;">
                            <h3>Operational Guidelines</h3>
                            <ul style="display: grid; grid-template-columns: 1fr 1fr; gap: 1rem; padding-left: 1rem;">
                                <li>Verify guest identity and email during registration.</li>
                                <li>Maintain real-time room status updates for housekeeping.</li>
                                <li>Handle guest data with premium confidentiality.</li>
                                <li>Escalate technical discrepancies to administration.</li>
                            </ul>
                        </div>
                    </div>

                    <div style="margin-top: 40px; text-align: center;">
                        <a href="staffDashboard.jsp" class="btn btn-primary"
                            style="padding: 15px 40px; font-size: 1.1em;">
                            <i class="fas fa-arrow-left"></i> Return to Staff Console
                        </a>
                    </div>
                </div>

                <jsp:include page="footer.jsp" />
                <script src="js/themeSwitcher.js"></script>
            </body>

            </html>