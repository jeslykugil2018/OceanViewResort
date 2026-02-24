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
                        <link rel="stylesheet" href="css/dark-theme.css">
                    </head>

                    <body>
                        <div class="navbar">
                            <div class="logo"><i class="fas fa-water"
                                    style="color: var(--accent-light); margin-right: 8px;"></i> Ocean View Resort</div>
                            <div class="nav-links">
                                <a href="index.jsp">Home</a>
                                <% com.oceanview.model.User user=(com.oceanview.model.User)
                                    session.getAttribute("user"); if (user !=null) { String
                                    dashboard="guestDashboard.jsp" ; if (user.getRole().equals("Admin"))
                                    dashboard="adminDashboard.jsp" ; else if (user.getRole().equals("Staff"))
                                    dashboard="staffDashboard.jsp" ; %>
                                    <a href="<%= dashboard %>">Back to Dashboard</a>
                                    <% } else { %>
                                        <a href="login.jsp">Login</a>
                                        <% } %>
                            </div>
                        </div>

                        <div class="container" style="max-width: 1200px;">
                            <h2><i class="fas fa-door-open"
                                    style="color: var(--accent-light); margin-right: 15px;"></i>Rooms Available from <%=
                                    checkIn %> to <%= checkOut %>
                            </h2>
                            <div style="display: grid; grid-template-columns: repeat(4, 1fr); gap: 20px;">
                                <% if(rooms.isEmpty()) { %>
                                    <div class="alert alert-error" style="grid-column: 1 / -1;">No rooms are available
                                        for the selected dates.</div>
                                    <% } else { for (Room r : rooms) { %>
                                        <div class="card"
                                            style="display: flex; flex-direction: column; padding: 0; overflow: hidden; height: 100%;">
                                            <img src="images/<%= r.getRoomType() %>.png"
                                                alt="<%= r.getRoomType() %> Room"
                                                style="width: 100%; height: 200px; object-fit: cover;">
                                            <div
                                                style="padding: 20px; display: flex; flex-direction: column; flex-grow: 1;">
                                                <h3
                                                    style="margin-top: 0; margin-bottom: 10px; color: var(--accent-light); font-size: 1.3rem;">
                                                    <%= r.getRoomType() %> Room
                                                </h3>
                                                <p style="margin: 0 0 10px 0; color: var(--text-secondary);">Room No:
                                                    <strong style="color: var(--text-primary);">
                                                        <%= r.getRoomNumber() %>
                                                    </strong></p>
                                                <div
                                                    style="margin-top: auto; border-top: 1px solid rgba(255,255,255,0.1); padding-top: 15px; text-align: center;">
                                                    <p
                                                        style="font-size: 1.25rem; color: var(--accent-secondary); margin: 0; font-weight: bold;">
                                                        LKR <%= String.format("%,.0f", r.getPricePerNight()) %>
                                                    </p>
                                                    <p
                                                        style="font-size: 0.8rem; color: var(--text-secondary); margin-bottom: 15px; margin-top: 5px;">
                                                        per night</p>
                                                    <a href="addReservation.jsp?roomId=<%= r.getRoomId() %>&checkIn=<%= checkIn %>&checkOut=<%= checkOut %>"
                                                        class="btn btn-primary"
                                                        style="display: block; width: 100%; box-sizing: border-box;"><i
                                                            class="fas fa-bookmark"></i> Book Now</a>
                                                </div>
                                            </div>
                                        </div>
                                        <% } } %>
                            </div>
                        </div>

                        <jsp:include page="footer.jsp" />
                    </body>

                    </html>