<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>About Us - Ocean View Resort</title>
        <link rel="stylesheet" href="css/dark-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>

    <body>
        <div class="navbar">
            <div class="logo"><i class="fas fa-water" style="color: var(--accent-light); margin-right: 8px;"></i> Ocean View Resort</div>
            <div class="nav-links">
                <a href="index.jsp">Home</a>
                <a href="contact.jsp">Contact</a>
                <a href="login.jsp">Login</a>
            </div>
        </div>

        <div class="container">
            <div class="card">
                <h2>Welcome to Ocean View Resort – Your Home by the Sea!</h2>
                <p>Located in the heart of Galle, Ocean View Resort offers a perfect blend of comfort, luxury, and
                    breathtaking ocean views. Whether you’re here for a relaxing getaway, a family vacation, or a
                    romantic escape, our resort provides the ideal setting for an unforgettable stay.</p>
                <p>Our dedicated team ensures that every guest experiences the highest level of service, from seamless
                    room reservations to personalized assistance during your stay. With modern amenities, cozy rooms,
                    and a variety of room types to suit every preference, your comfort is our top priority.</p>

                <h3>Why Choose Ocean View Resort?</h3>
                <ul style="list-style: none; padding-left: 0;">
                    <li style="margin-bottom: 15px;"><i class="fas fa-umbrella-beach"
                            style="color: var(--accent-light); margin-right: 10px;"></i> Prime beachside location with
                        stunning ocean views</li>
                    <li style="margin-bottom: 15px;"><i class="fas fa-bed"
                            style="color: var(--accent-light); margin-right: 10px;"></i> Comfortable and spacious rooms
                        (Single, Double, Deluxe & Suite )</li>
                    <li style="margin-bottom: 15px;"><i class="fas fa-clock"
                            style="color: var(--accent-light); margin-right: 10px;"></i> Open 24/7 – we’re always ready
                        to welcome you</li>
                    <li style="margin-bottom: 15px;"><i class="fas fa-laptop-code"
                            style="color: var(--accent-light); margin-right: 10px;"></i> Efficient computerized
                        reservation system for smooth bookings</li>
                    <li style="margin-bottom: 15px;"><i class="fas fa-user-tie"
                            style="color: var(--accent-light); margin-right: 10px;"></i> Friendly and attentive staff to
                        cater to all your needs</li>
                </ul>

                <p style="font-style: italic; margin-top: 20px;">Experience the perfect combination of relaxation,
                    luxury, and hospitality at Ocean View Resort – where every stay feels like a dream come true.</p>
            </div>
        </div>
    
    <jsp:include page="footer.jsp" />
</body>

    </html>
