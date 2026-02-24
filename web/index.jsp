<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Ocean View Resort - Home</title>
        <link rel="stylesheet" href="css/dark-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>

    <body>
        <div class="navbar">
            <div class="logo"><i class="fas fa-water" style="color: var(--accent-light); margin-right: 8px;"></i> Ocean View Resort</div>
            <div class="nav-links">
                <a href="index.jsp">Home</a>
                <a href="about.jsp">About</a>
                <a href="contact.jsp">Contact</a>
                <a href="login.jsp" class="btn btn-primary">Login</a>
            </div>
        </div>

        <div class="container">
            <div class="card" style="text-align: center; padding: 100px 20px;">
                <h1>Experience Luxury at Ocean View</h1>
                <p style="font-size: 1.2rem; color: var(--text-secondary);">Your perfect getaway by the sea. Book your
                    stay today.</p>
                <div style="margin-top: 30px;">
                    <a href="signup.jsp" class="btn btn-secondary">Sign Up Now</a>
                    <a href="checkAvailability.jsp" class="btn btn-primary">Check Availability</a>
                </div>
            </div>

            <div style="display: grid; grid-template-columns: repeat(auto-fit, minmax(300px, 1fr)); gap: 20px;">
                <div class="card" style="text-align: center;">
                    <i class="fas fa-water fa-3x" style="color: var(--accent-light); margin-bottom: 15px;"></i>
                    <h3>Vibrant Views</h3>
                    <p>Every room offers a breathtaking view of the ocean.</p>
                </div>
                <div class="card" style="text-align: center;">
                    <i class="fas fa-concierge-bell fa-3x" style="color: var(--accent-light); margin-bottom: 15px;"></i>
                    <h3>Premium Amenities</h3>
                    <p>Enjoy our spa, pool, and fine dining experiences.</p>
                </div>
                <div class="card" style="text-align: center;">
                    <i class="fas fa-star fa-3x" style="color: var(--accent-light); margin-bottom: 15px;"></i>
                    <h3>World Class Service</h3>
                    <p>Our staff is dedicated to making your stay unforgettable.</p>
                </div>
            </div>
        </div>
    
    <jsp:include page="footer.jsp" />
</body>

    </html>
