<%@page import="com.oceanview.dao.RoomDAO" %>
    <%@page import="com.oceanview.model.Room" %>
        <%@page import="java.util.List" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Check Availability - Ocean View</title>
                    <link rel="stylesheet" href="css/dark-theme.css">
                    <link rel="stylesheet"
                        href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
                </head>

                <body>
                    <div class="navbar">
                        <div class="logo"><i class="fas fa-water"
                                style="color: var(--accent-light); margin-right: 8px;"></i> Ocean View Resort</div>
                        <div class="nav-links">
                            <a href="index.jsp">Home</a>
                            <% com.oceanview.model.User user=(com.oceanview.model.User) session.getAttribute("user"); if
                                (user !=null) { String dashboard="guestDashboard.jsp" ; if
                                (user.getRole().equals("Admin")) dashboard="adminDashboard.jsp" ; else if
                                (user.getRole().equals("Staff")) dashboard="staffDashboard.jsp" ; %>
                                <a href="<%= dashboard %>">Back to Dashboard</a>
                                <% } else { %>
                                    <a href="login.jsp">Login</a>
                                    <% } %>
                        </div>
                    </div>

                    <div class="container" style="max-width: 800px;">
                        <div class="card">
                            <h2><i class="fas fa-search"
                                    style="color: var(--accent-light); margin-right: 15px;"></i>Search Rooms</h2>
                            <form action="availableRooms.jsp" method="GET">
                                <div style="display: flex; gap: 20px;">
                                    <div style="flex: 1;">
                                        <label>Check-in Date</label>
                                        <input type="date" name="checkIn" id="checkInDate" required>
                                    </div>
                                    <div style="flex: 1;">
                                        <label>Check-out Date</label>
                                        <input type="date" name="checkOut" id="checkOutDate" required>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary" style="margin-top: 20px;"><i
                                        class="fas fa-calendar-check"></i> Find Rooms</button>
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
                                // If check-in is selected, minimum check-out is the day after check-in
                                if (this.value) {
                                    const checkInDate = new Date(this.value);
                                    checkInDate.setDate(checkInDate.getDate() + 1);
                                    checkOutInput.setAttribute('min', checkInDate.toISOString().split('T')[0]);

                                    // Reset checkout if it's now invalid
                                    if (checkOutInput.value && checkOutInput.value <= this.value) {
                                        checkOutInput.value = "";
                                    }
                                } else {
                                    // if cleared, checkout min is at least tomorrow
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