<%@page import="com.oceanview.model.User" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% User user=(User) session.getAttribute("user"); if (user==null || !user.getRole().equals("Admin")) {
            response.sendRedirect("login.jsp"); return; } %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Admin Dashboard - Ocean View</title>
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
                            <a href="adminDashboard.jsp">Admin Dashboard</a>
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
                        <h1>Admin Portal</h1>
                        <p>Welcome back, <span style="color: var(--primary-color); font-weight: 600;">
                                <%= user.getName() %>
                            </span>. Orchestrate your resort's operations below.</p>
                    </div>

                    <div class="portal-grid">
                        <a href="manageRooms.jsp" class="card portal-card">
                            <i class="fas fa-hotel portal-icon"></i>
                            <h3>Manage Resort Rooms</h3>
                            <p>Add, edit, or remove rooms from the resort inventory and update pricing.</p>
                        </a>

                        <a href="manageStaff.jsp" class="card portal-card">
                            <i class="fas fa-users-cog portal-icon"></i>
                            <h3>Staff Accounts</h3>
                            <p>Register new staff members and manage roles within the reservation system.</p>
                        </a>

                        <a href="viewReservations.jsp" class="card portal-card">
                            <i class="fas fa-chart-line portal-icon"></i>
                            <h3>System Auditor</h3>
                            <p>View all system reservations and audit guest activities across the resort.</p>
                        </a>

                        <a href="adminHelp.jsp" class="card portal-card">
                            <i class="fas fa-user-shield portal-icon"></i>
                            <h3>Admin Manual</h3>
                            <p>Read the specialized administrative guide for system maintenance and oversight.</p>
                        </a>
                    </div>

                    <div style="margin-top: 50px; text-align: center;">
                        <a href="staffDashboard.jsp" class="btn btn-secondary" style="padding: 12px 30px;">
                            <i class="fas fa-exchange-alt"></i> Switch to Staff View
                        </a>
                    </div>
                </div>

                <jsp:include page="footer.jsp" />
                <script src="js/themeSwitcher.js"></script>
            </body>

            </html>