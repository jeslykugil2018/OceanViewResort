<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Login - Ocean View Resort</title>
        <link rel="stylesheet" href="css/light-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>

    <body>
        <div class="navbar">
            <div class="logo"><i class="fas fa-water" style="color: var(--accent-light); margin-right: 8px;"></i> Ocean
                View Resort</div>
            <div class="nav-links">
                <a href="index.jsp">Home</a>
                <a href="signup.jsp">Sign Up</a>
            </div>
        </div>

        <div class="container" style="max-width: 400px; margin-top: 100px;">
            <div class="card">
                <h2 style="text-align: center;"><i class="fas fa-sign-in-alt"
                        style="color: var(--accent-light); margin-right: 15px;"></i>Login</h2>
                <% if (request.getAttribute("error") !=null) { %>
                    <div class="alert alert-error">
                        <%= request.getAttribute("error") %>
                    </div>
                    <% } %>
                        <% if (request.getParameter("msg") !=null) { %>
                            <div class="alert alert-success">
                                <%= request.getParameter("msg") %>
                            </div>
                            <% } %>

                                <form action="LoginServlet" method="POST">
                                    <label>Email</label>
                                    <input type="email" name="email" required placeholder="example@email.com">
                                    <label>Password</label>
                                    <input type="password" name="password" required placeholder="••••••••">
                                    <button type="submit" class="btn btn-primary"
                                        style="width: 100%; margin-top: 20px;"><i class="fas fa-key"></i> Sign
                                        In</button>
                                </form>
                                <p style="text-align: center; margin-top: 20px;">
                                    Don't have an account? <a href="signup.jsp">Register</a>
                                </p>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
    </body>

    </html>