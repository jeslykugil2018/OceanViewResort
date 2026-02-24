<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Login - Ocean View Resort</title>
        <link rel="stylesheet" href="css/base.css">
        <link rel="stylesheet" href="css/light-theme.css" id="theme-link">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
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
                    <a href="signup.jsp">Sign Up</a>
                </div>
            </div>
        </div>

        <div class="container" style="max-width: 450px;">
            <div class="card">
                <h2 style="text-align: center;">Welcome Back</h2>
                <p style="text-align: center; margin-bottom: 2rem;">Please enter your details to sign in.</p>
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
                                    <div class="form-group">
                                        <label>Email Address</label>
                                        <input type="email" name="email" required placeholder="name@company.com">
                                    </div>
                                    <div class="form-group">
                                        <label>Password</label>
                                        <input type="password" name="password" required placeholder="••••••••">
                                    </div>
                                    <button type="submit" class="btn btn-primary"
                                        style="width: 100%; margin-top: 10px;">
                                        Sign In
                                    </button>
                                </form>
                                <p style="text-align: center; margin-top: 20px;">
                                    Don't have an account? <a href="signup.jsp">Register</a>
                                </p>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
        <script src="js/themeSwitcher.js"></script>
    </body>

    </html>