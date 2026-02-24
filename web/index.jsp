<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Ocean View Resort - Home</title>
        <link rel="stylesheet" href="css/base.css">
        <link rel="stylesheet" href="css/light-theme.css" id="theme-link">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
        <!-- Blocking Theme Script -->
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
                    <a href="about.jsp">About</a>
                    <a href="contact.jsp">Contact</a>
                    <button id="theme-toggle" class="btn btn-secondary"
                        style="padding: 0.5rem; width: 40px; height: 40px; border-radius: 50%;">
                        <i class="fas fa-moon"></i>
                    </button>
                    <a href="login.jsp" class="btn btn-primary">Login</a>
                </div>
            </div>
        </div>

        <div class="container">
            <div class="card" style="text-align: center; padding: 120px 0;">
                <h1>Experience Luxury</h1>
                <p>Simple. Clean. World-Class Hospitality.</p>
                <div style="margin-top: 40px; display: flex; gap: 20px; justify-content: center;">
                    <a href="signup.jsp" class="btn btn-secondary">Sign Up Now</a>
                    <a href="checkAvailability.jsp" class="btn btn-primary">Book Your Stay</a>
                </div>
            </div>

            <div class="portal-grid" style="margin-top: 60px; gap: 60px;">
                <div class="card" style="text-align: center;">
                    <i class="fas fa-water fa-2x" style="color: var(--primary-color); margin-bottom: 20px;"></i>
                    <h3>Vibrant Views</h3>
                    <p>Breathtaking ocean panoramas from every room.</p>
                </div>
                <div class="card" style="text-align: center;">
                    <i class="fas fa-concierge-bell fa-2x"
                        style="color: var(--primary-color); margin-bottom: 20px;"></i>
                    <h3>Premium Service</h3>
                    <p>24/7 dedication to your absolute comfort.</p>
                </div>
                <div class="card" style="text-align: center;">
                    <i class="fas fa-star fa-2x" style="color: var(--primary-color); margin-bottom: 20px;"></i>
                    <h3>Quiet Luxury</h3>
                    <p>Experience the finest amenities in a serene setting.</p>
                </div>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
        <script src="js/themeSwitcher.js"></script>
    </body>

    </html>