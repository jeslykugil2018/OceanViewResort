<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>About Us - Ocean View Resort</title>
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
            <div class="card">
                <h2>Our Story</h2>
                <p>Located in the heart of Galle, Ocean View Resort offers a perfect blend of comfort, luxury, and
                    breathtaking ocean views. Whether you’re here for a relaxing getaway, a family vacation, or a
                    romantic escape, our resort provides the ideal setting for an unforgettable stay.</p>
                <p>Our dedicated team ensures that every guest experiences the highest level of service, from seamless
                    room reservations to personalized assistance during your stay.</p>

                <h3 style="margin-top: 2.5rem;">The Ocean View Experience</h3>
                <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 1.5rem;">
                    <div style="display: flex; gap: 15px; align-items: start;">
                        <i class="fas fa-umbrella-beach" style="color: var(--primary-color);"></i>
                        <div>
                            <strong>Prime Location</strong>
                            <p style="font-size: 0.9rem;">Stunning ocean views from every room.</p>
                        </div>
                    </div>
                    <div style="display: flex; gap: 15px; align-items: start;">
                        <i class="fas fa-bed" style="color: var(--primary-color);"></i>
                        <div>
                            <strong>Luxury Suites</strong>
                            <p style="font-size: 0.9rem;">Spacious rooms designed for comfort.</p>
                        </div>
                    </div>
                    <div style="display: flex; gap: 15px; align-items: start;">
                        <i class="fas fa-clock" style="color: var(--primary-color);"></i>
                        <div>
                            <strong>Always Available</strong>
                            <p style="font-size: 0.9rem;">Our staff is ready to welcome you 24/7.</p>
                        </div>
                    </div>
                    <div style="display: flex; gap: 15px; align-items: start;">
                        <i class="fas fa-user-tie" style="color: var(--primary-color);"></i>
                        <div>
                            <strong>Personalized Service</strong>
                            <p style="font-size: 0.9rem;">Attentive staff catering to your every need.</p>
                        </div>
                    </div>
                </div>

                <p
                    style="margin-top: 3rem; text-align: center; font-weight: 500; color: var(--primary-color); letter-spacing: 0.05em; text-transform: uppercase; font-size: 0.8rem;">
                    A Touch of Paradise
                </p>
            </div>
        </div>

        <jsp:include page="footer.jsp" />
        <script src="js/themeSwitcher.js"></script>
    </body>

    </html>