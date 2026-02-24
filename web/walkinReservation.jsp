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
                            <title>New Walk-in - Ocean View</title>
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
                                        <button id="theme-toggle" class="btn btn-secondary"
                                            style="padding: 0.5rem; width: 40px; height: 40px; border-radius: 50%;">
                                            <i class="fas fa-moon"></i>
                                        </button>
                                        <% if(user.getRole().equals("Admin")) { %>
                                            <a href="adminDashboard.jsp">Dashboard</a>
                                            <% } else { %>
                                                <a href="staffDashboard.jsp">Dashboard</a>
                                                <% } %>
                                                    <a href="LogoutServlet" class="btn btn-secondary">Logout</a>
                                    </div>
                                </div>
                            </div>

                            <div class="container" style="max-width: 900px;">
                                <div class="card">
                                    <h1>New Walk-in</h1>
                                    <p>Register a guest directly into the system.</p>
                                    <form action="ReservationServlet" method="POST" style="margin-top: 2rem;">
                                        <input type="hidden" name="action" value="walkin">

                                        <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 40px;">
                                            <!-- Guest Details -->
                                            <div>
                                                <h3 style="font-size: 1.1rem; margin-bottom: 1.5rem;">Guest Information
                                                </h3>
                                                <div class="form-group">
                                                    <label>Full Name</label>
                                                    <input type="text" name="guestName" required
                                                        placeholder="Guest Name">
                                                </div>

                                                <div class="form-group">
                                                    <label>Email Address</label>
                                                    <input type="email" name="guestEmail" required
                                                        placeholder="email@example.com">
                                                </div>

                                                <div class="form-group">
                                                    <label>Contact Number</label>
                                                    <input type="tel" name="guestContact" required
                                                        placeholder="07XXXXXXXX">
                                                </div>

                                                <div class="form-group">
                                                    <label>Resident Address</label>
                                                    <textarea name="guestAddress" required
                                                        style="height: 100px; resize: none;"
                                                        placeholder="Full Address"></textarea>
                                                </div>
                                            </div>

                                            <!-- Booking Details -->
                                            <div>
                                                <h3 style="font-size: 1.1rem; margin-bottom: 1.5rem;">Stay Details</h3>
                                                <div class="form-group">
                                                    <label>Room Assignment</label>
                                                    <select name="roomId" required>
                                                        <% for (Room r : availableRooms) { %>
                                                            <% if (r.getStatus().equals("Available")) { %>
                                                                <option value="<%= r.getRoomId() %>">
                                                                    Room <%= r.getRoomNumber() %> - <%= r.getRoomType()
                                                                            %> (LKR <%= String.format("%,.0f",
                                                                                r.getPricePerNight()) %>)
                                                                </option>
                                                                <% } %>
                                                                    <% } %>
                                                    </select>
                                                </div>

                                                <div
                                                    style="display: grid; grid-template-columns: 1fr 1fr; gap: 15px; margin-bottom: 1.5rem;">
                                                    <div class="form-group">
                                                        <label>Check-in</label>
                                                        <input type="date" name="checkIn" id="checkInDate" required>
                                                    </div>
                                                    <div class="form-group">
                                                        <label>Check-out</label>
                                                        <input type="date" name="checkOut" id="checkOutDate" required>
                                                    </div>
                                                </div>

                                                <div
                                                    style="background: var(--secondary-bg); padding: 1.5rem; border-radius: var(--border-radius-sm);">
                                                    <label style="margin-bottom: 1rem;">Special Services</label>
                                                    <div style="display: flex; flex-direction: column; gap: 12px;">
                                                        <label
                                                            style="display: flex; align-items: center; gap: 10px; font-weight: 400; cursor: pointer;">
                                                            <input type="checkbox" name="breakfast"
                                                                style="width: auto;">
                                                            <span>Breakfast (LKR 500/day)</span>
                                                        </label>
                                                        <label
                                                            style="display: flex; align-items: center; gap: 10px; font-weight: 400; cursor: pointer;">
                                                            <input type="checkbox" name="spa" style="width: auto;">
                                                            <span>Spa Treatment (LKR 5,000)</span>
                                                        </label>
                                                        <label
                                                            style="display: flex; align-items: center; gap: 10px; font-weight: 400; cursor: pointer;">
                                                            <input type="checkbox" name="pickup" style="width: auto;">
                                                            <span>Airport Pickup (LKR 7,500)</span>
                                                        </label>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>

                                        <button type="submit" class="btn btn-primary"
                                            style="width: 100%; margin-top: 3rem;">
                                            Confirm Guest Stay
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
                            <script src="js/themeSwitcher.js"></script>
                        </body>

                        </html>