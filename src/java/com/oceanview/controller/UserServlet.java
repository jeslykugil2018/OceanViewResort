package com.oceanview.controller;

import com.oceanview.dao.UserDAO;
import com.oceanview.model.User;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("user");

        if (currentUser == null || !currentUser.getRole().equals("Admin")) {
            response.sendRedirect("login.jsp");
            return;
        }

        String action = request.getParameter("action");
        String userIdStr = request.getParameter("userId");

        if (userIdStr == null || action == null) {
            response.sendRedirect("manageStaff.jsp");
            return;
        }

        int userId = Integer.parseInt(userIdStr);

        try {
            UserDAO userDAO = new UserDAO();

            if ("delete".equals(action)) {
                if (userDAO.deleteUser(userId)) {
                    response.sendRedirect("manageStaff.jsp?msg=User deleted successfully");
                } else {
                    response.sendRedirect("manageStaff.jsp?error=Failed to delete user");
                }
            } else if ("update".equals(action)) {
                String name = request.getParameter("name");
                String username = request.getParameter("username");
                String email = request.getParameter("email");
                String contact = request.getParameter("contact");
                String address = request.getParameter("address");
                String role = request.getParameter("role");

                User updatedUser = new User(userId, name, username, email, contact, address, null, role);

                if (userDAO.updateUser(updatedUser)) {
                    response.sendRedirect("manageStaff.jsp?msg=User updated successfully");
                } else {
                    response.sendRedirect("manageStaff.jsp?error=Failed to update user");
                }
            }
        } catch (SQLException e) {
            throw new ServletException(e);
        }
    }
}
