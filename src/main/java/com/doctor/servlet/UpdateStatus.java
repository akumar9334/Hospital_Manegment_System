package com.doctor.servlet;

import com.Db.DbConnect;
import javax.servlet.annotation.WebServlet;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import com.dao.AppointmentDao;
import javax.servlet.http.HttpSession;

/**
 *
 * @author kumar
 */
@WebServlet("/updateStatus")
public class UpdateStatus extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        try {
            int id = Integer.parseInt(req.getParameter("id"));
            int did = Integer.parseInt(req.getParameter("did"));
            String comm = req.getParameter("Comm");
            
            AppointmentDao dao = new AppointmentDao(DbConnect.getConn());
            HttpSession session = req.getSession();
            
            // Removed the unnecessary semicolon here
            if(dao.UpdateCommentStatus(id, did, comm)) {
                session.setAttribute("succMsg", "Comment updated successfully.");
                resp.sendRedirect("doctor/patient.jsp");
            } else {
                session.setAttribute("errorMsg", "Something went wrong on the server.");
                resp.sendRedirect("doctor/patient.jsp");
            }
            
        } catch (Exception e) {
            e.printStackTrace();
            // Handle the error properly, e.g., by redirecting to an error page
            HttpSession session = req.getSession();
            session.setAttribute("errorMsg", "An error occurred: " + e.getMessage());
            resp.sendRedirect("error.jsp");
        }
    }
}
