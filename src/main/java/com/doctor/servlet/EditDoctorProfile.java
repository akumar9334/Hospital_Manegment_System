/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.doctor.servlet;

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
@WebServlet("/doctorUpdateProfile")
public class EditDoctorProfile extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

     
            
            try {
        // Retrieve the doctor ID from the form
        String idStr = req.getParameter("id");
        int id = Integer.parseInt(idStr);  // Ensure the ID is parsed correctly

        String fullName = req.getParameter("fullname");
        String dob = req.getParameter("dob");
        String qualification = req.getParameter("qualification");
        String spec = req.getParameter("spec");  // Ensure this value is coming correctly from the form
        String email = req.getParameter("email");
        String mobno = req.getParameter("mobno");

        // Check if the specialist is null or empty
        if (spec == null || spec.trim().isEmpty()) {
            throw new IllegalArgumentException("Specialist cannot be empty");
        }

        // Create the Doctor object
        Doctor d = new Doctor(fullName, dob, qualification, spec, email, mobno, "");
        d.setId(id);

        // Call the Dao method to update the profile
        DoctorDao dao = new DoctorDao(DbConnect.getConn());
        HttpSession session = req.getSession();

        if (dao.editDoctorProfile(d)) {
            Doctor updatDoctor = dao.getDoctorbyId(id);
            session.setAttribute("succMsgd", "Doctor Updated Successfully");
            session.setAttribute("doctObj", updatDoctor);
            resp.sendRedirect("doctor/edit_profile.jsp");
        } else {
            session.setAttribute("errorMsgd", "Something went wrong on the server");
            resp.sendRedirect("doctor/edit_profile.jsp");
        }
    } catch (Exception e) {
        e.printStackTrace();
        HttpSession session = req.getSession();
        session.setAttribute("errorMsgd", "An error occurred: " + e.getMessage());
        resp.sendRedirect("doctor/edit_profile.jsp");
    }

    }

}
