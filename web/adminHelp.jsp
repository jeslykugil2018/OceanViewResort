<%@page import="com.oceanview.model.User" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% User user=(User) session.getAttribute("user"); if (user==null || !user.getRole().equals("Admin")) {
            response.sendRedirect("login.jsp"); return; } %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Admin Protocols - Ocean View</title>
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
                            <a href="adminDashboard.jsp">Dashboard</a>
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
                        <h1>Administration Console</h1>
                        <p>High-level management protocols for the Ocean View infrastructure.</p>
                    </div>

                    <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(350px, 1fr)); gap: 2rem;">
                        <div class="card">
                            <h3>Inventory Management</h3>
                            <p>Maintain the resort's high-standard room inventory. Add, modify, or retire suites based
                                on seasonal performance and maintenance state.</p>
                            <p>Room data integrity directly impacts global booking availability.</p>
                        </div>

                        <div class="card">
                            <h3>Personnel Administration</h3>
                            <p>Register and manage staff credentials. Ensure all operators are correctly assigned to
                                their respective organizational roles.</p>
                            <p>System access is audited to maintain resort operational standards.</p>
                        </div>

                        <div class="card">
                            <h3>Operations Integrity</h3>
                            <p>Access global reservation registries to oversee resort occupancy and revenue trends.
                                Verify that all transactions align with confirmed bookings.</p>
                            <p>Audit logs provide a transparent record of all critical system events.</p>
                        </div>
                    </div>
                </div>

                <jsp:include page="footer.jsp" />
                <script src="js/themeSwitcher.js"></script>
            </body>

            </html>