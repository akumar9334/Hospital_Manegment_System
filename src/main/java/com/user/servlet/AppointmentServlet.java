/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.user.servlet;

import com.Db.DbConnect;
import com.dao.AppointmentDao;
import com.entity.Appointment;
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
@WebServlet("/appAppointment")
public class AppointmentServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        int userId = Integer.parseInt(req.getParameter("userid"));
        String fullname = req.getParameter("fullname");
        String gender = req.getParameter("gender");
        String age = req.getParameter("age");
        String appoint_date = req.getParameter("appoint_date");
        String email = req.getParameter("email");
        String phno = req.getParameter("phno");
        String diseases = req.getParameter("diseases");
        int doctor_id = Integer.parseInt(req.getParameter("doct"));
        String address = req.getParameter("address");
     
       	Appointment ap = new Appointment(userId, fullname, gender, age, appoint_date, email, phno, diseases, doctor_id, address, "Pending","Pending");

        AppointmentDao dao = new AppointmentDao(DbConnect.getConn());
        HttpSession session = req.getSession();

        if (dao.addAppointment(ap)) {
            session.setAttribute("succMsg", "Appointment Successfully Added");
            System.out.println("Success message set: " + session.getAttribute("succMsg"));
            resp.sendRedirect("UserAppointment.jsp");
        } else {
            session.setAttribute("errorMsg", "Something went wrong");
            System.out.println("Error message set: " + session.getAttribute("errorMsg"));
            resp.sendRedirect("UserAppointment.jsp");
        }

    }

}
