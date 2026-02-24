<%@page import="com.oceanview.dao.RoomDAO" %>
    <%@page import="com.oceanview.model.Room" %>
        <%@page import="java.util.List" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <!DOCTYPE html>
                <html>

                <head>
                    <title>Check Availability - Ocean View</title>
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
                                <a href="index.jsp">Home</a>
                                <button id="theme-toggle" class="btn btn-secondary"
                                    style="padding: 0.5rem; width: 40px; height: 40px; border-radius: 50%;">
                                    <i class="fas fa-moon"></i>
                                </button>
                                <% com.oceanview.model.User user=(com.oceanview.model.User)
                                    session.getAttribute("user"); if (user !=null) { String
                                    dashboard="guestDashboard.jsp" ; if (user.getRole().equals("Admin"))
                                    dashboard="adminDashboard.jsp" ; else if (user.getRole().equals("Staff"))
                                    dashboard="staffDashboard.jsp" ; %>
                                    <a href="<%= dashboard %>">Dashboard</a>
                                    <% } else { %>
                                        <a href="login.jsp">Login</a>
                                        <% } %>
                            </div>
                        </div>
                    </div>

                    <div class="container" style="max-width: 600px;">
                        <div class="card">
                            <h2>Find Your Room</h2>
                            <p>Select your dates to explore our available luxury suites.</p>
                            <form action="availableRooms.jsp" method="GET" style="margin-top: 2rem;">
                                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px;">
                                    <div class="form-group">
                                        <label>Arrival Date</label>
                                        <input type="date" name="checkIn" id="checkInDate" required>
                                    </div>
                                    <div class="form-group">
                                        <label>Departure Date</label>
                                        <input type="date" name="checkOut" id="checkOutDate" required>
                                    </div>
                                </div>
                                <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 10px;">
                                    Search Availability
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
                    <script src="js/themeSwitcher.js"></script>
                </body>

                </html>