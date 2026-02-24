<%@page import="com.oceanview.model.User" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <% User user=(User) session.getAttribute("user"); if (user==null || !user.getRole().equals("Admin")) {
            response.sendRedirect("login.jsp"); return; } %>
            <!DOCTYPE html>
            <html>

            <head>
                <title>Admin Dashboard - Ocean View</title>
                <link rel="stylesheet" href="css/light-theme.css">
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
                    <div class="logo"><i class="fas fa-water"
                            style="color: var(--accent-light); margin-right: 8px;"></i> Ocean View Resort</div>
                    <div class="nav-links">
                        <a href="adminDashboard.jsp" class="active">Admin Dashboard</a>
                        <a href="LogoutServlet" class="btn btn-secondary"><i class="fas fa-sign-out-alt"></i> Logout</a>
                    </div>
                </div>

                <div class="container">
                    <div style="margin-bottom: 40px;">
                        <h1 style="font-size: 2.5em;">Administrator Control Panel</h1>
                        <p style="opacity: 0.7; font-size: 1.1em;">Welcome back, <span
                                style="color: var(--accent-light);">
                                <%= user.getName() %>
                            </span>. Access high-level system controls below.</p>
                    </div>

                    <div class="portal-grid">
                        <a href="manageRooms.jsp" class="card portal-card">
                            <i class="fas fa-hotel portal-icon"></i>
                            <h3>Manage Resort Rooms</h3>
                            <p>Add, edit, or remove rooms from the resort inventory and update pricing.</p>
                        </a>

                        <a href="signup.jsp" class="card portal-card">
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
            </body>

            </html>