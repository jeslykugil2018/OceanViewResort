<%@page import="com.oceanview.model.User" %>
    <%@page import="com.oceanview.dao.RoomDAO" %>
        <%@page import="com.oceanview.model.Room" %>
            <%@page import="java.util.List" %>
                <%@page contentType="text/html" pageEncoding="UTF-8" %>
                    <% User user=(User) session.getAttribute("user"); if (user==null || !user.getRole().equals("Admin"))
                        { response.sendRedirect("login.jsp"); return; } RoomDAO roomDAO=new RoomDAO(); List<Room>
                        allRooms = roomDAO.getAllRooms();
                        %>
                        <!DOCTYPE html>
                        <html>

                        <head>
                            <title>Manage Rooms - Ocean View</title>
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
                                    <a href="adminDashboard.jsp">Back to Dashboard</a>
                                    <a href="signup.jsp">Create Staff</a>
                                    <a href="LogoutServlet" class="btn btn-secondary"><i
                                            class="fas fa-sign-out-alt"></i> Logout</a>
                                </div>
                            </div>

                            <div class="container">
                                <% if (request.getParameter("msg") !=null) { %>
                                    <div class="alert alert-success">
                                        <%= request.getParameter("msg") %>
                                    </div>
                                    <% } %>
                                        <% if (request.getParameter("error") !=null) { %>
                                            <div class="alert alert-error">
                                                <%= request.getParameter("error") %>
                                            </div>
                                            <% } %>

                                                <div
                                                    style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px;">
                                                    <h2><i class="fas fa-bed"
                                                            style="color: var(--accent-light); margin-right: 15px;"></i>Room
                                                        Management
                                                        Inventory</h2>
                                                    <button class="btn btn-primary" onclick="showAddModal()"><i
                                                            class="fas fa-plus-circle"></i> Add New
                                                        Room</button>
                                                </div>

                                                <div class="card">
                                                    <h3>Resort Room Inventory</h3>
                                                    <table>
                                                        <tr>
                                                            <th>Room #</th>
                                                            <th>Type</th>
                                                            <th>Status</th>
                                                            <th>Price (LKR)</th>
                                                            <th>Action</th>
                                                        </tr>
                                                        <% for (Room r : allRooms) { %>
                                                            <tr>
                                                                <td>
                                                                    <%= r.getRoomNumber() %>
                                                                </td>
                                                                <td>
                                                                    <%= r.getRoomType() %>
                                                                </td>
                                                                <td>
                                                                    <% String rStatus=r.getStatus(); String
                                                                        rColor="#e74c3c" ; if
                                                                        ("Available".equals(rStatus)) { rColor="#2ecc71"
                                                                        ; } else if ("Occupied".equals(rStatus)) {
                                                                        rColor="#e67e22" ; } %>
                                                                        <span class="badge"
                                                                            style="background: <%= rColor %>;">
                                                                            <%= rStatus %>
                                                                        </span>
                                                                </td>
                                                                <td>
                                                                    <%= String.format("%.2f", r.getPricePerNight()) %>
                                                                </td>
                                                                <td>
                                                                    <button class="btn btn-primary"
                                                                        style="padding: 5px 10px;"
                                                                        onclick="showEditModal(<%= r.getRoomId() %>, '<%= r.getRoomNumber() %>', '<%= r.getRoomType() %>', '<%= r.getStatus() %>', <%= r.getPricePerNight() %>)">
                                                                        <i class="fas fa-edit"></i> Edit
                                                                    </button>
                                                                    <form action="RoomServlet" method="POST"
                                                                        style="display:inline;"
                                                                        onsubmit="return confirm('Are you sure you want to delete this room?')">
                                                                        <input type="hidden" name="action"
                                                                            value="delete">
                                                                        <input type="hidden" name="roomId"
                                                                            value="<%= r.getRoomId() %>">
                                                                        <button type="submit" class="btn btn-secondary"
                                                                            style="padding: 5px 10px;">
                                                                            <i class="fas fa-trash-alt"></i> Delete
                                                                        </button>
                                                                    </form>
                                                                </td>
                                                            </tr>
                                                            <% } %>
                                                    </table>
                                                </div>

                                                <div style="margin-top: 30px; text-align: center;">
                                                    <a href="adminDashboard.jsp" class="btn btn-secondary">
                                                        <i class="fas fa-arrow-left"></i> Return to Admin Dashboard
                                                    </a>
                                                </div>
                            </div>

                            <!-- Add/Edit Room Modal -->
                            <div id="roomModal" class="modal"
                                style="display:none; position:fixed; z-index:1000; left:0; top:0; width:100%; height:100%; background: rgba(0,0,0,0.8);">
                                <div class="card" style="width: 400px; margin: 100px auto;">
                                    <h3 id="modalTitle">Add New Room</h3>
                                    <form action="RoomServlet" method="POST">
                                        <input type="hidden" name="action" id="formAction" value="add">
                                        <input type="hidden" name="roomId" id="roomIdInput">

                                        <label>Room Number</label>
                                        <input type="text" name="roomNumber" id="roomNumberInput" required
                                            pattern="^[a-zA-Z0-9]+$"
                                            title="Room Number can only contain letters and numbers (e.g., 101, A20).">

                                        <label>Room Type</label>
                                        <select name="roomType" id="roomTypeInput"
                                            style="width:100%; padding:10px; background:rgba(255,255,255,0.1); color:white; border:1px solid rgba(255,255,255,0.2); border-radius:8px; margin-bottom:15px;">
                                            <option value="Single">Single</option>
                                            <option value="Double">Double</option>
                                            <option value="Deluxe">Deluxe</option>
                                            <option value="Suite">Suite</option>
                                        </select>

                                        <label>Status</label>
                                        <select name="status" id="statusInput"
                                            style="width:100%; padding:10px; background:rgba(255,255,255,0.1); color:white; border:1px solid rgba(255,255,255,0.2); border-radius:8px; margin-bottom:15px;">
                                            <option value="Available">Available</option>
                                            <option value="Occupied">Occupied</option>
                                            <option value="Maintenance">Maintenance</option>
                                        </select>

                                        <label>Price per Night (LKR)</label>
                                        <input type="number" step="0.01" name="pricePerNight" id="priceInput" required
                                            min="1.0" title="Price must be a positive number.">

                                        <div style="display:flex; gap:10px; margin-top:20px;">
                                            <button type="submit" class="btn btn-primary" style="flex:1;">Save
                                                Room</button>
                                            <button type="button" class="btn btn-secondary" style="flex:1;"
                                                onclick="hideModal()">Cancel</button>
                                        </div>
                                    </form>
                                </div>
                            </div>

                            <script>
                                function showAddModal() {
                                    document.getElementById('modalTitle').innerText = 'Add New Room';
                                    document.getElementById('formAction').value = 'add';
                                    document.getElementById('roomIdInput').value = '';
                                    document.getElementById('roomNumberInput').value = '';
                                    document.getElementById('roomTypeInput').value = 'Single';
                                    document.getElementById('statusInput').value = 'Available';
                                    document.getElementById('priceInput').value = '';
                                    document.getElementById('roomModal').style.display = 'block';
                                }

                                function showEditModal(id, number, type, status, price) {
                                    document.getElementById('modalTitle').innerText = 'Edit Room #' + number;
                                    document.getElementById('formAction').value = 'update';
                                    document.getElementById('roomIdInput').value = id;
                                    document.getElementById('roomNumberInput').value = number;
                                    document.getElementById('roomTypeInput').value = type;
                                    document.getElementById('statusInput').value = status;
                                    document.getElementById('priceInput').value = price;
                                    document.getElementById('roomModal').style.display = 'block';
                                }

                                function hideModal() {
                                    document.getElementById('roomModal').style.display = 'none';
                                }
                            </script>

                            <jsp:include page="footer.jsp" />
                        </body>

                        </html>