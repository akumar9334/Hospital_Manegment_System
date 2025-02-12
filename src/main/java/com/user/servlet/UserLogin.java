/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.user.servlet;

import com.Db.DbConnect;
import com.dao.UserDao;
import com.entity.User;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author kumar
 */
@WebServlet("/userlogin")
public class UserLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        
                        try {
            // Get form parameters
            String email = req.getParameter("email");
            String password = req.getParameter("password");

            // Start session
            HttpSession session = req.getSession();
            UserDao dao = new UserDao(DbConnect.getConn());
            User user = dao.login(email, password);

            // Check if credentials are correct
            if (user != null) {
                // Successful login
                session.setAttribute("userObj", user);
                session.setAttribute("userloginSuccess", "true"); // Set success message in session
                resp.sendRedirect("index.jsp"); // Redirect to homepage/dashboard
            } else {
                // Invalid credentials
                session.setAttribute("errorMsg", "Invalid email & password");
                resp.sendRedirect("user_login.jsp"); // Redirect back to login page
            }
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect("error.jsp"); // Optional: Redirect to a generic error page if something goes wrong
        }
    }
    
    
    
}
