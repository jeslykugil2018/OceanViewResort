<%@page import="com.oceanview.model.User" %>
    <%@page import="com.oceanview.model.Reservation" %>
        <%@page import="com.oceanview.dao.ReservationDAO" %>
            <%@page import="java.util.List" %>
                <%@page contentType="text/html" pageEncoding="UTF-8" %>
                    <% User user=(User) session.getAttribute("user"); if (user==null || (!user.getRole().equals("Staff")
                        && !user.getRole().equals("Admin"))) { response.sendRedirect("login.jsp"); return; }
                        ReservationDAO resDAO=new ReservationDAO(); List<Reservation> allReservations =
                        resDAO.getAllReservations();
                        %>
                        <!DOCTYPE html>
                        <html>

                        <head>
                            <title>Global Reservations - Ocean View</title>
                            <link rel="stylesheet" href="css/base.css">
                            <link rel="stylesheet" href="css/light-theme.css" id="theme-link">
                            <link rel="stylesheet"
                                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                                <div
                                    style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 3rem;">
                                    <div>
                                        <h1>All Reservations</h1>
                                        <p>Comprehensive overview of all guest reservations.</p>
                                    </div>
                                    <a href="walkinReservation.jsp" class="btn btn-primary">
                                        New Walk-in Booking
                                    </a>
                                </div>

                                <div class="card" style="padding: 1.5rem;">
                                    <div class="table-container">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>ID</th>
                                                    <th>Guest</th>
                                                    <th>Contact</th>
                                                    <th>Room</th>
                                                    <th>Stay</th>
                                                    <th>Total</th>
                                                    <th>Status</th>
                                                    <th style="text-align: right;">Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (Reservation r : allReservations) { %>
                                                    <tr>
                                                        <td>#<%= r.getReservationNumber() %>
                                                        </td>
                                                        <td><strong>
                                                                <%= r.getGuestName() !=null ? r.getGuestName()
                                                                    : "Guest #" + r.getGuestId() %>
                                                            </strong></td>
                                                        <td>
                                                            <%= r.getGuestContact() !=null ? r.getGuestContact() : "N/A"
                                                                %>
                                                        </td>
                                                        <td>
                                                            <%= r.getRoomType() %>
                                                        </td>
                                                        <td style="font-size: 0.85rem;">
                                                            <%= r.getCheckIn() %> - <%= r.getCheckOut() %>
                                                        </td>
                                                        <td style="font-weight: 600;">LKR <%= String.format("%,.0f",
                                                                r.getTotalCost()) %>
                                                        </td>
                                                        <td><span class="badge">
                                                                <%= r.getStatus() %>
                                                            </span></td>
                                                        <td style="text-align: right;">
                                                            <div
                                                                style="display: flex; gap: 8px; justify-content: flex-end;">
                                                                <form action="ReservationServlet" method="POST"
                                                                    style="margin: 0;">
                                                                    <input type="hidden" name="action" value="cancel">
                                                                    <input type="hidden" name="reservationNumber"
                                                                        value="<%= r.getReservationNumber() %>">
                                                                    <button type="submit" class="btn btn-secondary"
                                                                        style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">
                                                                        Cancel
                                                                    </button>
                                                                </form>
                                                                <a href="BillingServlet?reservationNumber=<%= r.getReservationNumber() %>"
                                                                    class="btn btn-primary"
                                                                    style="padding: 0.4rem 0.8rem; font-size: 0.8rem;">
                                                                    Bill PDF
                                                                </a>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>
                            </div>

                            <jsp:include page="footer.jsp" />
                            <script src="js/themeSwitcher.js"></script>
                        </body>

                        </html>