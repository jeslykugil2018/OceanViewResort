package com.oceanview.controller;

import com.oceanview.dao.MessageDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/MessageServlet")
public class MessageServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String subject = request.getParameter("subject");
        String message = request.getParameter("message");

        try {
            MessageDAO dao = new MessageDAO();
            if (dao.saveMessage(name, email, subject, message)) {
                response.sendRedirect("contact.jsp?msg=Message sent successfully");
            } else {
                response.sendRedirect("contact.jsp?error=Failed to send message");
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
