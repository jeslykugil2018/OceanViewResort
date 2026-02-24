<%@page import="com.oceanview.dao.RoomDAO" %>
    <%@page import="com.oceanview.model.Room" %>
        <%@page import="com.oceanview.model.User" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <% User user=(User) session.getAttribute("user"); if (user==null) { response.sendRedirect("login.jsp");
                    return; } int roomId=Integer.parseInt(request.getParameter("roomId")); String
                    checkIn=request.getParameter("checkIn"); String checkOut=request.getParameter("checkOut"); RoomDAO
                    roomDAO=new RoomDAO(); Room room=roomDAO.getRoomById(roomId); %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <title>Book Room - Ocean View</title>
                        <link rel="stylesheet" href="css/dark-theme.css">
                        <link rel="stylesheet"
                            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                    </head>

                    <body>
                        <div class="navbar">
                            <div class="logo"><i class="fas fa-water"
                                    style="color: var(--accent-light); margin-right: 8px;"></i> Ocean View Resort</div>
                            <div class="nav-links">
                                <a href="guestDashboard.jsp">Dashboard</a>
                            </div>
                        </div>

                        <div class="container" style="max-width: 600px;">
                            <div class="card">
                                <h2><i class="fas fa-check-double"
                                        style="color: var(--accent-light); margin-right: 15px;"></i>Complete Your
                                    Booking</h2>
                                <p><strong>Room:</strong>
                                    <%= room.getRoomType() %> (No. <%= room.getRoomNumber() %>)
                                </p>
                                <p><strong>Price:</strong> LKR <%= String.format("%,.0f", room.getPricePerNight()) %> /
                                        night</p>
                                <p><strong>Stay:</strong>
                                    <%= checkIn %> to <%= checkOut %>
                                </p>

                                <form action="ReservationServlet" method="POST" id="bookingForm">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="guestId" value="<%= user.getUserId() %>">
                                    <input type="hidden" name="roomId" value="<%= roomId %>">
                                    <input type="hidden" id="checkInDate" name="checkIn" value="<%= checkIn %>">
                                    <input type="hidden" id="checkOutDate" name="checkOut" value="<%= checkOut %>">

                                    <h3><i class="fas fa-concierge-bell" style="margin-right: 10px;"></i>Optional
                                        Services</h3>
                                    <div
                                        style="display: flex; flex-direction: row; flex-wrap: wrap; gap: 20px; margin-bottom: 20px;">
                                        <label
                                            style="display: flex; align-items: center; font-weight: normal; margin: 0;">
                                            <input type="checkbox" name="breakfast">
                                            Luxury Breakfast (LKR 500/day)
                                        </label>
                                        <label
                                            style="display: flex; align-items: center; font-weight: normal; margin: 0;">
                                            <input type="checkbox" name="spa">
                                            Full Spa Package (LKR 5000)
                                        </label>
                                        <label
                                            style="display: flex; align-items: center; font-weight: normal; margin: 0;">
                                            <input type="checkbox" name="pickup">
                                            Airport Pickup (LKR 7500)
                                        </label>
                                    </div>

                                    <button type="submit" class="btn btn-primary" style="width: 100%;"><i
                                            class="fas fa-calendar-check"></i> Confirm
                                        Reservation</button>
                                </form>
                            </div>
                        </div>

                        <script>
                            document.addEventListener("DOMContentLoaded", function () {
                                const checkInInput = document.getElementById("checkInDate").value;
                                const checkOutInput = document.getElementById("checkOutDate").value;

                                const form = document.getElementById("bookingForm");

                                form.addEventListener("submit", function (event) {
                                    if (checkInInput && checkOutInput) {
                                        if (checkOutInput <= checkInInput) {
                                            event.preventDefault();
                                            alert("Invalid dates! Check-out date must be after Check-in date.");
                                            window.location.href = "checkAvailability.jsp";
                                        }
                                    }
                                });
                            });
                        </script>

                        <jsp:include page="footer.jsp" />
                    </body>

                    </html>