package com.oceanview.controller;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/SignupServlet")
public class SignupServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String contact = request.getParameter("contact");
        String address = request.getParameter("address");
        String password = request.getParameter("password");
        String role = request.getParameter("role"); // Admin can create Staff/Admin, Guest registers themselves

        if (role == null)
            role = "Guest";

        try {
            UserDAO userDAO = new UserDAO();

            if (userDAO.isUsernameTaken(username)) {
                request.setAttribute("error", "Username '" + username + "' is already taken.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            if (userDAO.isEmailTaken(email)) {
                request.setAttribute("error", "Email '" + email + "' is already registered.");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
                return;
            }

            User user = new User(0, name, username, email, contact, address, password, role);

            if (userDAO.registerUser(user)) {
                if (role.equals("Guest")) {
                    response.sendRedirect("login.jsp?msg=Signup successful, please login");
                } else {
                    response.sendRedirect("adminDashboard.jsp?msg=User created successfully");
                }
            } else {
                request.setAttribute("error", "Registration failed");
                request.getRequestDispatcher("signup.jsp").forward(request, response);
            }
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
