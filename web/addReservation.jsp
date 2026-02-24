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
                        <title>Complete Reservation - Ocean View</title>
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
                                    <a href="guestDashboard.jsp">Dashboard</a>
                                    <button id="theme-toggle" class="btn btn-secondary"
                                        style="padding: 0.5rem; width: 40px; height: 40px; border-radius: 50%;">
                                        <i class="fas fa-moon"></i>
                                    </button>
                                </div>
                            </div>
                        </div>

                        <div class="container" style="max-width: 600px;">
                            <div class="card">
                                <h2>Complete Your Reservation</h2>
                                <p>You're one step away from paradise.</p>

                                <div
                                    style="background: var(--secondary-bg); padding: 1.5rem; border-radius: var(--border-radius-sm); margin-bottom: 2rem;">
                                    <p style="font-size: 0.9rem; margin-bottom: 0.5rem;"><strong
                                            style="color: var(--text-primary);">Suite:</strong>
                                        <%= room.getRoomType() %> (No. <%= room.getRoomNumber() %>)
                                    </p>
                                    <p style="font-size: 0.9rem; margin-bottom: 0.5rem;"><strong
                                            style="color: var(--text-primary);">Rate:</strong> LKR <%=
                                            String.format("%,.0f", room.getPricePerNight()) %> / night</p>
                                    <p style="font-size: 0.9rem; margin: 0;"><strong
                                            style="color: var(--text-primary);">Stay:</strong>
                                        <%= checkIn %> to <%= checkOut %>
                                    </p>
                                </div>

                                <form action="ReservationServlet" method="POST" id="bookingForm">
                                    <input type="hidden" name="action" value="add">
                                    <input type="hidden" name="guestId" value="<%= user.getUserId() %>">
                                    <input type="hidden" name="roomId" value="<%= roomId %>">
                                    <input type="hidden" id="checkInDate" name="checkIn" value="<%= checkIn %>">
                                    <input type="hidden" id="checkOutDate" name="checkOut" value="<%= checkOut %>">

                                    <h3 style="margin-top: 2rem; font-size: 1.1rem;">Special Services</h3>
                                    <div style="display: flex; flex-direction: column; gap: 12px; margin-bottom: 2rem;">
                                        <label
                                            style="display: flex; align-items: center; gap: 10px; font-weight: 400; cursor: pointer;">
                                            <input type="checkbox" name="breakfast" style="width: auto;">
                                            <span>Luxury Breakfast Buffet (LKR 500/day)</span>
                                        </label>
                                        <label
                                            style="display: flex; align-items: center; gap: 10px; font-weight: 400; cursor: pointer;">
                                            <input type="checkbox" name="spa" style="width: auto;">
                                            <span>Signature Spa Experience (LKR 5,000)</span>
                                        </label>
                                        <label
                                            style="display: flex; align-items: center; gap: 10px; font-weight: 400; cursor: pointer;">
                                            <input type="checkbox" name="pickup" style="width: auto;">
                                            <span>VIP Airport Chauffeur (LKR 7,500)</span>
                                        </label>
                                    </div>

                                    <button type="submit" class="btn btn-primary" style="width: 100%;">
                                        Confirm Your Stay
                                    </button>
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
                        <script src="js/themeSwitcher.js"></script>
                    </body>

                    </html>