package com.oceanview.service;

import com.oceanview.model.Reservation;
import java.util.Properties;
import jakarta.mail.*;
import jakarta.mail.internet.*;

/**
 * Service to handle email notifications for bookings.
 */
public class EmailService {

    // SMTP Configuration Placeholders
    // IMPORTANT: Replace these with your actual SMTP details
    private static final String SMTP_HOST = "smtp.gmail.com";
    private static final String SMTP_PORT = "587";
    private static final String SENDER_EMAIL = "your-email@gmail.com";
    private static final String SENDER_PASSWORD = "your-app-password"; // Use App Password for Gmail

    public static void sendBookingConfirmation(Reservation res, String recipientEmail) {
        Properties props = new Properties();
        props.put("mail.smtp.auth", "true");
        props.put("mail.smtp.starttls.enable", "true");
        props.put("mail.smtp.host", SMTP_HOST);
        props.put("mail.smtp.port", SMTP_PORT);

        Session session = Session.getInstance(props, new Authenticator() {
            @Override
            protected PasswordAuthentication getPasswordAuthentication() {
                return new PasswordAuthentication(SENDER_EMAIL, SENDER_PASSWORD);
            }
        });

        try {
            Message message = new MimeMessage(session);
            message.setFrom(new InternetAddress(SENDER_EMAIL));
            message.setRecipients(Message.RecipientType.TO, InternetAddress.parse(recipientEmail));
            message.setSubject("Booking Confirmation - Ocean View Resort");

            String content = "<h2>Reservation Confirmed!</h2>"
                    + "<p>Dear " + res.getGuestName() + ",</p>"
                    + "<p>Thank you for choosing Ocean View Resort. Here are your booking details:</p>"
                    + "<ul>"
                    + "<li><b>Reservation No:</b> #" + res.getGuestId() + "-" + System.currentTimeMillis() % 10000
                    + "</li>"
                    + "<li><b>Room Type:</b> " + res.getRoomType() + "</li>"
                    + "<li><b>Check-in:</b> " + res.getCheckIn() + "</li>"
                    + "<li><b>Check-out:</b> " + res.getCheckOut() + "</li>"
                    + "<li><b>Total Cost:</b> LKR " + res.getTotalCost() + "</li>"
                    + "</ul>"
                    + "<p>We look forward to seeing you!</p>";

            message.setContent(content, "text/html");

            // We simulate the send if credentials are not provided
            if (SENDER_EMAIL.equals("your-email@gmail.com")) {
                System.out.println("[EmailService Simulation] To: " + recipientEmail);
                System.out.println("[EmailService Simulation] Content: \n" + content);
            } else {
                Transport.send(message);
                System.out.println("[EmailService] Email sent to: " + recipientEmail);
            }

        } catch (MessagingException e) {
            System.err.println("[EmailService Error] Could not send email: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
