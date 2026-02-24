<%@page import="java.net.InetAddress" %>
    <%@page contentType="text/html" pageEncoding="UTF-8" %>
        <!DOCTYPE html>
        <html>

        <head>
            <title>Contact Us - Ocean View</title>
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
                        <a href="about.jsp">About</a>
                        <button id="theme-toggle" class="btn btn-secondary"
                            style="padding: 0.5rem; width: 40px; height: 40px; border-radius: 50%;">
                            <i class="fas fa-moon"></i>
                        </button>
                    </div>
                </div>
            </div>

            <div class="container" style="max-width: 650px;">
                <div class="card">
                    <h2>Get in Touch</h2>
                    <p>We're here to help. Send us a message and we'll respond shortly.</p>
                    <form action="MessageServlet" method="POST" style="margin-top: 2rem;">
                        <div class="form-group">
                            <label>Your Name</label>
                            <input type="text" name="name" required placeholder="John Doe">
                        </div>
                        <div class="form-group">
                            <label>Email Address</label>
                            <input type="email" name="email" required placeholder="john@example.com">
                        </div>
                        <div class="form-group">
                            <label>Subject</label>
                            <input type="text" name="subject" required placeholder="Question about booking">
                        </div>
                        <div class="form-group">
                            <label>Message</label>
                            <textarea name="message" rows="5" required placeholder="How can we assist you?"></textarea>
                        </div>
                        <button type="submit" class="btn btn-primary" style="width: 100%; margin-top: 10px;">
                            Send Message
                        </button>
                    </form>
                </div>

                <div class="card" style="margin-top: 30px; text-align: center;">
                    <h3>Book Instantly</h3>
                    <p style="margin-bottom: 2rem;">Scan to access our simplified booking portal.</p>
                    <div id="qrcode"
                        style="display: inline-block; background: white; padding: 20px; border-radius: 16px;">
                    </div>
                    <p
                        style="margin-top: 1.5rem; font-size: 0.8rem; font-weight: 600; text-transform: uppercase; color: var(--primary-color);">
                        Ocean View Direct</p>
                </div>
            </div>

            <script src="https://cdnjs.cloudflare.com/ajax/libs/qrcodejs/1.0.0/qrcode.min.js"></script>
            <script>
            // Detect internal server IP so the QR code works from mobile devices on the same network
            <%
                    String ipAddress = "localhost";
                try {
                    ipAddress = InetAddress.getLocalHost().getHostAddress();
                } catch (Exception e) {
                    // Fallback to localhost if IP cannot be detected
                }
                String contextPath = request.getContextPath();
                int port = request.getServerPort();
                String baseUrl = "http://" + ipAddress + ":" + port + contextPath;
            %>
            
            const bookingUrl = "<%= baseUrl %>/checkAvailability.jsp";
                console.log("QR Code URL:", bookingUrl);

                new QRCode(document.getElementById("qrcode"), {
                    text: bookingUrl,
                    width: 150,
                    height: 150,
                    colorDark: "#000000",
                    colorLight: "#ffffff",
                    correctLevel: QRCode.CorrectLevel.H
                });
            </script>

            <jsp:include page="footer.jsp" />
            <script src="js/themeSwitcher.js"></script>
        </body>

        </html>