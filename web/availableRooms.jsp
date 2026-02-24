<%@page import="com.oceanview.dao.RoomDAO" %>
    <%@page import="com.oceanview.model.Room" %>
        <%@page import="java.util.List" %>
            <%@page contentType="text/html" pageEncoding="UTF-8" %>
                <% RoomDAO roomDAO=new RoomDAO(); List<Room> rooms = roomDAO.getAvailableRooms();
                    String checkIn = request.getParameter("checkIn");
                    String checkOut = request.getParameter("checkOut");
                    %>
                    <!DOCTYPE html>
                    <html>

                    <head>
                        <title>Available Rooms - Ocean View</title>
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

                        <div class="container">
                            <div style="margin-bottom: 3rem;">
                                <h1>Available Suites</h1>
                                <p>Refined options for your stay from <strong>
                                        <%= checkIn %>
                                    </strong> to <strong>
                                        <%= checkOut %>
                                    </strong>.</p>
                            </div>
                            <div
                                style="display: grid; grid-template-columns: repeat(auto-fit, minmax(280px, 1fr)); gap: 30px;">
                                <% if(rooms.isEmpty()) { %>
                                    <div class="alert alert-error" style="grid-column: 1 / -1;">No rooms are available
                                        for the selected dates.</div>
                                    <% } else { for (Room r : rooms) { %>
                                        <div class="card"
                                            style="padding: 0; overflow: hidden; display: flex; flex-direction: column;">
                                            <img src="images/<%= r.getRoomType() %>.png"
                                                alt="<%= r.getRoomType() %> Room"
                                                style="width: 100%; height: 200px; object-fit: cover;">
                                            <div
                                                style="padding: 2rem; display: flex; flex-direction: column; flex-grow: 1;">
                                                <h3 style="margin-bottom: 0.5rem;">
                                                    <%= r.getRoomType() %> Suite
                                                </h3>
                                                <p style="font-size: 0.85rem; margin-bottom: 1.5rem;">Room No. <%=
                                                        r.getRoomNumber() %>
                                                </p>

                                                <div style="margin-top: auto;">
                                                    <p
                                                        style="font-size: 1.5rem; font-weight: 800; color: var(--primary-color); margin-bottom: 0.25rem;">
                                                        LKR <%= String.format("%,.0f", r.getPricePerNight()) %>
                                                    </p>
                                                    <p
                                                        style="font-size: 0.75rem; text-transform: uppercase; letter-spacing: 0.05em; margin-bottom: 1.5rem;">
                                                        per night</p>
                                                    <a href="addReservation.jsp?roomId=<%= r.getRoomId() %>&checkIn=<%= checkIn %>&checkOut=<%= checkOut %>"
                                                        class="btn btn-primary" style="width: 100%;">
                                                        Reserve Now
                                                    </a>
                                                </div>
                                            </div>
                                        </div>
                                        <% } } %>
                            </div>
                        </div>

                        <jsp:include page="footer.jsp" />
                        <script src="js/themeSwitcher.js"></script>
                    </body>

                    </html>