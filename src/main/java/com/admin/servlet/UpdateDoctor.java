/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
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
@WebServlet("/updateDoctor")
public class UpdateDoctor extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            // Retrieve the doctor ID from the form
            String idStr = req.getParameter("id");
            int id = Integer.parseInt(idStr);  // Ensure the ID is parsed correctly
            System.out.println("Received ID: " + id);  // Debugging line

            // Continue with other form data retrieval
            String fullName = req.getParameter("fullname");
            String dob = req.getParameter("dob");
            String qualification = req.getParameter("qualification");
            String spec = req.getParameter("specialist");
            String email = req.getParameter("email");
            String mobno = req.getParameter("mobno");
            String password = req.getParameter("password");

            // Create the Doctor object
            Doctor d = new Doctor(fullName, dob, qualification, spec, email, mobno, password);
            d.setId(id);  // Set the ID

            System.out.println("Doctor details: " + d);  // Optionally, print out all details for debugging

            DoctorDao dao = new DoctorDao(DbConnect.getConn());
            HttpSession session = req.getSession();

            if (dao.updateDoctor(d)) {
                session.setAttribute("succMsg", "Doctor Updated Successfully");
                resp.sendRedirect("admin/view_doctor.jsp");
            } else {
                session.setAttribute("errorMsg", "Something went wrong on the server");
                resp.sendRedirect("admin/doctor.jsp");
            }
        } catch (Exception e) {
            e.printStackTrace();
            HttpSession session = req.getSession();
            session.setAttribute("errorMsg", "An error occurred: " + e.getMessage());
            resp.sendRedirect("admin/doctor.jsp");
        }
    }
}





