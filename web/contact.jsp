<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Contact Us - Ocean View</title>
        <link rel="stylesheet" href="css/light-theme.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">
    </head>

    <body>
        <div class="navbar">
            <div class="logo"><i class="fas fa-water" style="color: var(--accent-light); margin-right: 8px;"></i> Ocean
                View Resort</div>
            <div class="nav-links">
                <a href="index.jsp">Home</a>
                <a href="about.jsp">About</a>
            </div>
        </div>

        <div class="container" style="max-width: 600px;">
            <div class="card">
                <h2><i class="fas fa-envelope-open-text" style="color: var(--accent-light); margin-right: 15px;"></i>Get
                    in Touch</h2>
                <form action="MessageServlet" method="POST">
                    <label>Name</label>
                    <input type="text" name="name" required minlength="2"
                        title="Please enter your full name (minimum 2 characters).">
                    <label>Email</label>
                    <input type="email" name="email" required title="Please enter a valid email address.">
                    <label>Subject</label>
                    <input type="text" name="subject" required minlength="3"
                        title="Subject must be at least 3 characters.">
                    <label>Message</label>
                    <textarea name="message" rows="5" required minlength="10"
                        title="Message must be at least 10 characters long."></textarea>
                    <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 20px;">Send
                        Message</button>
                </form>
            </div>

            <div class="card" style="margin-top: 30px; text-align: center;">
                <h3><i class="fas fa-qrcode" style="color: var(--accent-light); margin-right: 15px;"></i>Scan to Book
                </h3>
                <p style="margin-bottom: 20px; font-size: 0.9em; opacity: 0.8;">Scan this code to quickly access our
                    room booking portal.</p>
                <div id="qrcode"
                    style="display: flex; justify-content: center; background: white; padding: 15px; border-radius: 10px; width: fit-content; margin: 0 auto;">
                </div>
                <p style="margin-top: 15px; font-size: 0.8em; color: var(--accent-light);">Ocean View Resort - Instant
                    Booking</p>
            </div>
        </div>

        <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
        <script>
            new QRCode(document.getElementById("qrcode"), {
                text: window.location.origin + "/OceanView/index.jsp",
                width: 150,
                height: 150,
                colorDark: "#000000",
                colorLight: "#ffffff",
                correctLevel: QRCode.CorrectLevel.H
            });
        </script>

        <jsp:include page="footer.jsp" />
    </body>

    </html>