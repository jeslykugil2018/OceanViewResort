<%@page import="com.oceanview.dao.RoomDAO" %>
    <%@page import="com.oceanview.model.Room" %>
        <%@page import="java.util.List" %>
            <%@page import="com.oceanview.model.User" %>
                <%@page contentType="text/html" pageEncoding="UTF-8" %>
                    <% User user=(User) session.getAttribute("user"); if (user==null || (!user.getRole().equals("Staff")
                        && !user.getRole().equals("Admin"))) { response.sendRedirect("login.jsp"); return; } RoomDAO
                        roomDAO=new RoomDAO(); List<Room> availableRooms = roomDAO.getAllRooms();
                        %>
                        <!DOCTYPE html>
                        <html>

                        <head>
                            <title>Walk-in Reservation - Ocean View</title>
                            <link rel="stylesheet" href="css/light-theme.css">
                            <link rel="stylesheet"
                                href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                        </head>

                        <body>
                            <div class="navbar">
                                <div class="logo"><i class="fas fa-water"
                                        style="color: var(--accent-light); margin-right: 8px;"></i> Ocean View Resort
                                </div>
                                <div class="nav-links">
                                    <% if(user.getRole().equals("Admin")) { %>
                                        <a href="adminDashboard.jsp">Back to Dashboard</a>
                                        <% } else { %>
                                            <a href="staffDashboard.jsp">Back to Dashboard</a>
                                            <% } %>
                                                <a href="LogoutServlet" class="btn btn-secondary"><i
                                                        class="fas fa-sign-out-alt"></i> Logout</a>
                                </div>
                            </div>

                            <div class="container" style="max-width: 900px;">
                                <div class="card">
                                    <h2><i class="fas fa-plus-circle"
                                            style="color: var(--accent-light); margin-right: 15px;"></i>New Walk-in
                                        Reservation</h2>
                                    <form action="ReservationServlet" method="POST">
                                        <input type="hidden" name="action" value="walkin">

                                        <div style="display: flex; gap: 30px; margin-top: 20px;">
                                            <!-- Guest Details -->
                                            <div style="flex: 1;">
                                                <h3>Guest Details</h3>
                                                <label>Full Name</label>
                                                <input type="text" name="guestName" required minlength="2"
                                                    title="Please enter full name (minimum 2 characters).">

                                                <label>Email (Username)</label>
                                                <input type="email" name="guestEmail" required
                                                    title="Please enter a valid email address.">

                                                <label>Contact Number</label>
                                                <input type="tel" name="guestContact" required pattern="^[0-9]{10}$"
                                                    title="Contact number must be exactly 10 digits.">

                                                <label>Address</label>
                                                <textarea name="guestAddress" required minlength="5"
                                                    title="Please provide a valid address."
                                                    style="width: 100%; height: 80px; background: rgba(255, 255, 255, 0.1); border: 1px solid rgba(255, 255, 255, 0.2); border-radius: 8px; color: white; padding: 10px; margin-bottom: 15px;"></textarea>
                                            </div>

                                            <!-- Booking Details -->
                                            <div style="flex: 1;">
                                                <h3>Booking Details</h3>
                                                <label>Select Room</label>
                                                <select name="roomId" required
                                                    style="width: 100%; padding: 10px; background: #2c3e50; color: white; border: 1px solid #34495e; border-radius: 8px; margin-bottom: 15px;">
                                                    <% for (Room r : availableRooms) { %>
                                                        <% if (r.getStatus().equals("Available")) { %>
                                                            <option value="<%= r.getRoomId() %>">
                                                                Room <%= r.getRoomNumber() %> (<%= r.getRoomType() %>) -
                                                                        LKR <%= String.format("%,.0f",
                                                                            r.getPricePerNight()) %>/night
                                                            </option>
                                                            <% } %>
                                                                <% } %>
                                                </select>

                                                <label>Check-in Date</label>
                                                <input type="date" name="checkIn" id="checkInDate" required>

                                                <label>Check-out Date</label>
                                                <input type="date" name="checkOut" id="checkOutDate" required>

                                                <div
                                                    style="background: rgba(255, 255, 255, 0.05); padding: 15px; border-radius: 8px; margin-top: 20px;">
                                                    <label
                                                        style="margin-bottom: 15px; display: block; font-weight: bold;">Optional
                                                        Services</label>
                                                    <div
                                                        style="display: flex; flex-direction: row; flex-wrap: wrap; gap: 20px;">
                                                        <label
                                                            style="display: flex; align-items: center; font-weight: normal; margin: 0;">
                                                            <input type="checkbox" name="breakfast">
                                                            Breakfast (LKR 500/day)
                                                        </label>
                                                        <label
                                                            style="display: flex; align-items: center; font-weight: normal; margin: 0;">
                                                            <input type="checkbox" name="spa">
                                                            Spa Treatment (LKR 5,000)
                                                        </label>
                                                        <label
                                                            style="display: flex; align-items: center; font-weight: normal; margin: 0;">
                                                            <input type="checkbox" name="pickup">
                                                            Airport Pickup (LKR 7,500)
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <button type="submit" class="btn btn-primary"
                                            style="width: 100%; margin-top: 30px; padding: 15px; font-size: 1.1em;">
                                            <i class="fas fa-check-double"></i> Confirm & Store Reservation
                                        </button>
                                    </form>
                                </div>
                            </div>

                            <script>
                                document.addEventListener("DOMContentLoaded", function () {
                                    const checkInInput = document.getElementById("checkInDate");
                                    const checkOutInput = document.getElementById("checkOutDate");

                                    // Set minimum Check-in date to today
                                    const today = new Date().toISOString().split('T')[0];
                                    checkInInput.setAttribute('min', today);

                                    checkInInput.addEventListener("change", function () {
                                        if (this.value) {
                                            const checkInDate = new Date(this.value);
                                            checkInDate.setDate(checkInDate.getDate() + 1);
                                            checkOutInput.setAttribute('min', checkInDate.toISOString().split('T')[0]);

                                            // Reset checkout if it's invalid
                                            if (checkOutInput.value && checkOutInput.value <= this.value) {
                                                checkOutInput.value = "";
                                            }
                                        } else {
                                            const tomorrow = new Date();
                                            tomorrow.setDate(tomorrow.getDate() + 1);
                                            checkOutInput.setAttribute('min', tomorrow.toISOString().split('T')[0]);
                                        }
                                    });
                                });
                            </script>

                            <jsp:include page="footer.jsp" />
                        </body>

                        </html>