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
                            <title>Manage Inventory - Ocean View</title>
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
                                        <a href="adminDashboard.jsp">Dashboard</a>
                                        <button id="theme-toggle" class="btn btn-secondary"
                                            style="padding: 0.5rem; width: 40px; height: 40px; border-radius: 50%;">
                                            <i class="fas fa-moon"></i>
                                        </button>
                                        <a href="LogoutServlet" class="btn btn-secondary">Logout</a>
                                    </div>
                                </div>
                            </div>

                            <div class="container">
                                <div
                                    style="display: flex; justify-content: space-between; align-items: flex-end; margin-bottom: 3rem;">
                                    <div>
                                        <h1>Inventory Management</h1>
                                        <p>Maintain your resort's room listings and pricing.</p>
                                    </div>
                                    <button class="btn btn-primary" onclick="showAddModal()">
                                        Add New Room
                                    </button>
                                </div>

                                <div class="card" style="padding: 1.5rem;">
                                    <div class="table-container">
                                        <table>
                                            <thead>
                                                <tr>
                                                    <th>No.</th>
                                                    <th>Type</th>
                                                    <th>Status</th>
                                                    <th>Price (LKR)</th>
                                                    <th style="text-align: right;">Actions</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <% for (Room r : allRooms) { %>
                                                    <tr>
                                                        <td><strong>
                                                                <%= r.getRoomNumber() %>
                                                            </strong></td>
                                                        <td>
                                                            <%= r.getRoomType() %>
                                                        </td>
                                                        <td>
                                                            <% String status=r.getStatus(); String
                                                                badgeStyle="Available" .equals(status)
                                                                ? "background: var(--success-bg); color: var(--success-text);"
                                                                : "background: var(--error-bg); color: var(--error-text);"
                                                                ; %>
                                                                <span class="badge" style="<%= badgeStyle %>">
                                                                    <%= status %>
                                                                </span>
                                                        </td>
                                                        <td style="font-weight: 600;">
                                                            <%= String.format("%,.0f", r.getPricePerNight()) %>
                                                        </td>
                                                        <td style="text-align: right;">
                                                            <div
                                                                style="display: flex; gap: 10px; justify-content: flex-end;">
                                                                <button class="btn btn-secondary"
                                                                    style="padding: 0.4rem 0.8rem; font-size: 0.8rem;"
                                                                    onclick="showEditModal(<%= r.getRoomId() %>, '<%= r.getRoomNumber() %>', '<%= r.getRoomType() %>', '<%= r.getStatus() %>', <%= r.getPricePerNight() %>)">
                                                                    Edit
                                                                </button>
                                                                <form action="RoomServlet" method="POST"
                                                                    style="margin: 0;"
                                                                    onsubmit="return confirm('Archive this room?')">
                                                                    <input type="hidden" name="action" value="delete">
                                                                    <input type="hidden" name="roomId"
                                                                        value="<%= r.getRoomId() %>">
                                                                    <button type="submit" class="btn btn-secondary"
                                                                        style="padding: 0.4rem 0.8rem; font-size: 0.8rem; border-color: var(--error-text); color: var(--error-text);">
                                                                        Delete
                                                                    </button>
                                                                </form>
                                                            </div>
                                                        </td>
                                                    </tr>
                                                    <% } %>
                                            </tbody>
                                        </table>
                                    </div>
                                </div>
                            </div>

                            <!-- Add/Edit Room Modal -->
                            <div id="roomModal" class="modal"
                                style="display:none; position:fixed; z-index:2000; left:0; top:0; width:100%; height:100%; background: var(--bg-color); padding: 2rem;">
                                <div class="container" style="max-width: 500px;">
                                    <div class="card">
                                        <h2 id="modalTitle">Modify Room</h2>
                                        <p>Update inventory details below.</p>
                                        <form action="RoomServlet" method="POST" style="margin-top: 2rem;">
                                            <input type="hidden" name="action" id="formAction" value="add">
                                            <input type="hidden" name="roomId" id="roomIdInput">

                                            <div class="form-group">
                                                <label>Room Number</label>
                                                <input type="text" name="roomNumber" id="roomNumberInput" required
                                                    placeholder="e.g. 101">
                                            </div>

                                            <div class="form-group">
                                                <label>Room Category</label>
                                                <select name="roomType" id="roomTypeInput">
                                                    <option value="Single">Single</option>
                                                    <option value="Double">Double</option>
                                                    <option value="Deluxe">Deluxe</option>
                                                    <option value="Suite">Suite</option>
                                                </select>
                                            </div>

                                            <div class="form-group">
                                                <label>Availability Status</label>
                                                <select name="status" id="statusInput">
                                                    <option value="Available">Available</option>
                                                    <option value="Occupied">Occupied</option>
                                                    <option value="Maintenance">Maintenance</option>
                                                </select>
                                            </div>

                                            <div class="form-group">
                                                <label>Nightly Rate (LKR)</label>
                                                <input type="number" step="0.01" name="pricePerNight" id="priceInput"
                                                    required placeholder="0.00">
                                            </div>

                                            <div
                                                style="display:grid; grid-template-columns: 1fr 1fr; gap:10px; margin-top:2rem;">
                                                <button type="submit" class="btn btn-primary">Save Changes</button>
                                                <button type="button" class="btn btn-secondary"
                                                    onclick="hideModal()">Discard</button>
                                            </div>
                                        </form>
                                    </div>
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
                            <script src="js/themeSwitcher.js"></script>
                        </body>

                        </html>