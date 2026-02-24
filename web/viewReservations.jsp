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
                            <title>All Reservations - Ocean View</title>
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
                                    <a href="staffDashboard.jsp">Back to Dashboard</a>
                                    <a href="walkinReservation.jsp">Add Reservation</a>
                                    <a href="staffHelp.jsp" style="color: var(--accent-light);"><i
                                            class="fas fa-question-circle"></i> Help</a>
                                    <a href="LogoutServlet" class="btn btn-secondary"><i
                                            class="fas fa-sign-out-alt"></i> Logout</a>
                                </div>
                            </div>

                            <div class="container" style="max-width: 1200px;">
                                <div
                                    style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
                                    <h2><i class="fas fa-clipboard-list"
                                            style="color: var(--accent-light); margin-right: 15px;"></i>Global
                                        Reservation List</h2>
                                    <a href="walkinReservation.jsp" class="btn btn-primary"><i class="fas fa-plus"></i>
                                        New Walk-in</a>
                                </div>

                                <div class="card">
                                    <h3>Current Reservations</h3>
                                    <table>
                                        <tr>
                                            <th>Res #</th>
                                            <th>Guest Name</th>
                                            <th>Address</th>
                                            <th>Contact</th>
                                            <th>Room Type</th>
                                            <th>Check In</th>
                                            <th>Check Out</th>
                                            <th>Total</th>
                                            <th>Status</th>
                                            <th>Action</th>
                                        </tr>
                                        <% for (Reservation r : allReservations) { %>
                                            <tr>
                                                <td>
                                                    <%= r.getReservationNumber() %>
                                                </td>
                                                <td>
                                                    <%= r.getGuestName() !=null ? r.getGuestName() : "Guest #" +
                                                        r.getGuestId() %>
                                                </td>
                                                <td>
                                                    <%= r.getGuestAddress() !=null ? r.getGuestAddress() : "N/A" %>
                                                </td>
                                                <td>
                                                    <%= r.getGuestContact() !=null ? r.getGuestContact() : "N/A" %>
                                                </td>
                                                <td>
                                                    <%= r.getRoomType() !=null ? r.getRoomType() : "Room #" +
                                                        r.getRoomId() %>
                                                </td>
                                                <td>
                                                    <%= r.getCheckIn() %>
                                                </td>
                                                <td>
                                                    <%= r.getCheckOut() %>
                                                </td>
                                                <td>LKR <%= String.format("%.2f", r.getTotalCost()) %>
                                                </td>
                                                <td><span class="badge">
                                                        <%= r.getStatus() %>
                                                    </span></td>
                                                <td>
                                                    <form action="ReservationServlet" method="POST"
                                                        style="display:inline;">
                                                        <input type="hidden" name="action" value="cancel">
                                                        <input type="hidden" name="reservationNumber"
                                                            value="<%= r.getReservationNumber() %>">
                                                        <button type="submit" class="btn btn-secondary"
                                                            style="padding: 2px 6px; font-size: 0.75rem; line-height: 1.2; width: 90px; text-align: center; box-sizing: border-box; display: inline-block;">
                                                            <i class="fas fa-times-circle"></i> Cancel
                                                        </button>
                                                    </form>
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
                                    <a href="staffDashboard.jsp" class="btn btn-secondary">
                                        <i class="fas fa-arrow-left"></i> Return to Staff Dashboard
                                    </a>
                                </div>
                            </div>

                            <jsp:include page="footer.jsp" />
                        </body>

                        </html>