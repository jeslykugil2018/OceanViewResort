<%@page import="com.oceanview.model.User" %>
    <%@page import="com.oceanview.model.Reservation" %>
        <%@page import="com.oceanview.dao.ReservationDAO" %>
            <%@page import="java.util.List" %>
                <%@page contentType="text/html" pageEncoding="UTF-8" %>
                    <% User user=(User) session.getAttribute("user"); if (user==null) {
                        response.sendRedirect("login.jsp"); return; } ReservationDAO resDAO=new ReservationDAO();
                        List<Reservation> myReservations = resDAO.getReservationsByGuest(user.getUserId());
                        %>
                        <!DOCTYPE html>
                        <html>

                        <head>
                            <title>My Reservations - Ocean View</title>
                            <link rel="stylesheet" href="css/dark-theme.css">
                            <link rel="stylesheet"
                                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                        </head>

                        <body>
                            <div class="navbar">
                                <div class="logo"><i class="fas fa-water"
                                        style="color: var(--accent-light); margin-right: 8px;"></i> Ocean View Resort
                                </div>
                                <div class="nav-links">
                                    <a href="guestDashboard.jsp">Back to Dashboard</a>
                                    <a href="checkAvailability.jsp">Book Room</a>
                                    <a href="guestHelp.jsp" style="color: var(--accent-light);"><i
                                            class="fas fa-question-circle"></i> Help</a>
                                    <a href="LogoutServlet" class="btn btn-secondary"><i
                                            class="fas fa-sign-out-alt"></i> Logout</a>
                                </div>
                            </div>

                            <div class="container" style="max-width: 1000px;">
                                <div
                                    style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
                                    <h2><i class="fas fa-calendar-check"
                                            style="color: var(--accent-light); margin-right: 15px;"></i>My Bookings</h2>
                                    <a href="checkAvailability.jsp" class="btn btn-primary"><i class="fas fa-plus"></i>
                                        New Reservation</a>
                                </div>

                                <div class="card">
                                    <h3>Your Reservation History</h3>
                                    <table>
                                        <tr>
                                            <th>Res #</th>
                                            <th>Room #</th>
                                            <th>Check In</th>
                                            <th>Check Out</th>
                                            <th>Status</th>
                                            <th>Total</th>
                                            <th>Action</th>
                                        </tr>
                                        <% if (myReservations.isEmpty()) { %>
                                            <tr>
                                                <td colspan="7"
                                                    style="text-align: center; padding: 40px; opacity: 0.6;">You have no
                                                    active or past reservations.</td>
                                            </tr>
                                            <% } %>
                                                <% for (Reservation r : myReservations) { %>
                                                    <tr>
                                                        <td>
                                                            <%= r.getReservationNumber() %>
                                                        </td>
                                                        <td>
                                                            <%= r.getRoomId() %>
                                                        </td>
                                                        <td>
                                                            <%= r.getCheckIn() %>
                                                        </td>
                                                        <td>
                                                            <%= r.getCheckOut() %>
                                                        </td>
                                                        <td><span class="badge">
                                                                <%= r.getStatus() %>
                                                            </span></td>
                                                        <td>LKR <%= String.format("%.2f", r.getTotalCost()) %>
                                                        </td>
                                                        <td>
                                                            <% if (r.getStatus().equals("Confirmed")) { %>
                                                                <form action="ReservationServlet" method="POST"
                                                                    style="display:inline;">
                                                                    <input type="hidden" name="action" value="cancel">
                                                                    <input type="hidden" name="reservationNumber"
                                                                        value="<%= r.getReservationNumber() %>">
                                                                    <button type="submit" class="btn btn-secondary"
                                                                        style="padding: 2px 6px; font-size: 0.75rem; line-height: 1.2; width: 90px; text-align: center; box-sizing: border-box; display: inline-block;"><i
                                                                            class="fas fa-times-circle"></i>
                                                                        Cancel</button>
                                                                </form>
                                                                <% } %>
                                                                    <a href="BillingServlet?reservationNumber=<%= r.getReservationNumber() %>"
                                                                        class="btn btn-primary"
                                                                        style="padding: 2px 6px; font-size: 0.75rem; margin-left: 15px; display: inline-block; line-height: 1.2; width: 90px; text-align: center; box-sizing: border-box;"><i
                                                                            class="fas fa-file-pdf"></i> Bill PDF</a>
                                                        </td>
                                                    </tr>
                                                    <% } %>
                                    </table>
                                </div>

                                <div style="margin-top: 30px; text-align: center;">
                                    <a href="guestDashboard.jsp" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left"></i> Return to Guest Dashboard
                                    </a>
                                </div>
                            </div>

                            <jsp:include page="footer.jsp" />
                        </body>

                        </html>