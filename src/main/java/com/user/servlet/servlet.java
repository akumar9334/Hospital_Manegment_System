package com.user.servlet;

import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.dao.UserDao;
import com.Db.DbConnect;
import com.entity.User;

@WebServlet("/register")
public class servlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            String fullName = req.getParameter("fullname");
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            // Ensure input validation
            if (fullName == null || email == null || password == null) {
                throw new IllegalArgumentException("Missing required fields.");
            }

            User u = new User(fullName, email, password);
            UserDao dao = new UserDao(DbConnect.getConn());

            HttpSession session = req.getSession();

            boolean f = dao.register(u);

            if (f) {
                session.setAttribute("sucMsg", "Register Successfully");
                resp.sendRedirect("signup.jsp");
            } else {
                session.setAttribute("errorMsg", "Something went wrong on the server.");
                resp.sendRedirect("signup.jsp");
            }

        } catch (IllegalArgumentException e) {
            // Handle missing fields or invalid input
            e.printStackTrace();
            req.getSession().setAttribute("errorMsg", "Invalid input: " + e.getMessage());
            resp.sendRedirect("signup.jsp");
        } catch (Exception e) {
            // General exception handler
            e.printStackTrace();
            req.getSession().setAttribute("errorMsg", "Error: " + e.getMessage());
            resp.sendRedirect("signup.jsp");
        }
    }
}
