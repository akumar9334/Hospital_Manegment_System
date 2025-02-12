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
@WebServlet("/doctorLogin")
public class DoctorLogin extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
     
        String email = req.getParameter("email");
		String password = req.getParameter("password");

		HttpSession session = req.getSession();

		DoctorDao dao=new DoctorDao(DbConnect.getConn());
               Doctor doctor=dao.login(email, password);

		if (doctor != null) {
			session.setAttribute("doctObj", doctor);
                        session.setAttribute("succMsg", "doctor login sucessfull");
			resp.sendRedirect("doctor/index.jsp");
		} else {
			session.setAttribute("errorMsg", "invalid email & password");
			resp.sendRedirect("Doctor_login.jsp");
		}
    }
    
    
}
