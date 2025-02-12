/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.admin.servlet;

import com.Db.DbConnect;
import com.dao.DoctorDao;
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
@WebServlet("/deleteDoctor")
public class DeleteDoctor extends HttpServlet{

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
       
       // Retrieve the doctor ID from the form
            String idStr = req.getParameter("id");
            int id = Integer.parseInt(idStr);  // Ensure the ID is parsed correctly
            System.out.println("Delete ID: " + id);  
            
            DoctorDao dao = new DoctorDao(DbConnect.getConn());
            HttpSession session = req.getSession();

            if (dao.deleteDoctor(id)) {
                session.setAttribute("succMsg", "Doctor delete Sucessfully..");
                resp.sendRedirect("admin/view_doctor.jsp");
            } else {
                session.setAttribute("errorMsg", "something wrong on server");
                resp.sendRedirect("admin/doctor.jsp");
            
            
    }
    
    
    }

}