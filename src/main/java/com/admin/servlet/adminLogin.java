package com.admin.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import com.entity.User;

@WebServlet("/adminlogin")
public class adminLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // Get form parameters
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            // Start session
            HttpSession session = req.getSession();

            // Check if credentials are correct
             if ("admin@gmail.com".equals(email) && "admin".equals(password)) {
                // Successful login
                User admin = new User(email, password);  // Create a new User object for admin
                session.setAttribute("adminObj", admin); // Store it in session
                session.setAttribute("loginSuccess", "true"); // Set success message in session
                resp.sendRedirect("admin/indexdoc.jsp"); // Redirect to the admin dashboard
            }  else {
    // Invalid credentials
    session.setAttribute("errorMsg", "Invalid email & password");
    resp.sendRedirect("Admin_login.jsp"); // Redirect back to login page
}
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp"); // Optional: Redirect to a generic error page if something goes wrong
        }
    }
}
