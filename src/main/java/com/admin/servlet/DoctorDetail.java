package com.admin.servlet;

import com.Db.DbConnect;
import com.dao.DoctorDao;
import com.entity.Doctor;
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
@WebServlet("/DoctorDetails")
public class DoctorDetail extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {

            // Retrieve the parameters for the doctor from the form
            String fullName = req.getParameter("fullname");
            String dob = req.getParameter("dob");
            String qualification = req.getParameter("qualification");
            String spec = req.getParameter("spec");
            String email = req.getParameter("email");
            String mobno = req.getParameter("mobno");
            String password = req.getParameter("password");

            // Retrieve the new parameters (country, state, city, hospital)
            String country = req.getParameter("country");
            String state = req.getParameter("state");
            String city = req.getParameter("city");
            String hospital = req.getParameter("hospital");
            

                

            // Create a new Doctor object with all the fields
            Doctor d = new Doctor(fullName, dob, qualification, spec, email, mobno, password, country, state, city, hospital);

            // Create a DoctorDao instance and pass the database connection
            DoctorDao dao = new DoctorDao(DbConnect.getConn());
            HttpSession session = req.getSession();

            // Attempt to register the doctor and handle success or failure
            if (dao.registerDoctor(d)) {
                session.setAttribute("succMsg", "Doctor registration Successfully.");
                resp.sendRedirect("doctor/createdoctoraccout.jsp");
            } else {
                session.setAttribute("errorMsg", "Something went wrong on the server.");
                resp.sendRedirect("doctor/createdoctoraccout.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            // In case of an exception, redirect to the same page with an error message
            HttpSession session = req.getSession();
            session.setAttribute("errorMsg", "An error occurred while register the doctor.");
            resp.sendRedirect("doctor/createdoctoraccout.jsp");
        }
    }
}
