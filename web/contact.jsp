<%@page contentType="text/html" pageEncoding="UTF-8" %>
    <!DOCTYPE html>
    <html>

    <head>
        <title>Contact Us - Ocean View</title>
        <link rel="stylesheet" href="css/dark-theme.css">
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
        </div>

        <jsp:include page="footer.jsp" />
    </body>

    </html>