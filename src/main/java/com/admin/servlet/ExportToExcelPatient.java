package com.admin.servlet;

import com.dao.AppointmentDao;
import com.dao.DoctorDao;
import com.entity.Appointment;
import com.entity.Doctor;
import com.Db.DbConnect;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.*;
import java.io.IOException;
import java.io.OutputStream;
import java.util.List;

@WebServlet("/admin/exportToExcelpatient")
public class ExportToExcelPatient extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set the content type to Excel
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=PatientDetails.xlsx");

        // Create a workbook and a sheet
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Patient Details");

        // Create the header row
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Full Name");
        headerRow.createCell(1).setCellValue("Gender");
        headerRow.createCell(2).setCellValue("Age");
        headerRow.createCell(3).setCellValue("Appointment Date");
        headerRow.createCell(4).setCellValue("Email");
        headerRow.createCell(5).setCellValue("Mob No");
        headerRow.createCell(6).setCellValue("Diseases");
        headerRow.createCell(7).setCellValue("Doctor Name");
        headerRow.createCell(8).setCellValue("Address");
        headerRow.createCell(9).setCellValue("Conform Status");
        headerRow.createCell(10).setCellValue("Check Status");
        headerRow.createCell(11).setCellValue("Hospital");

        // Fetch the list of appointments from the database
        AppointmentDao appointmentDao = new AppointmentDao(DbConnect.getConn());
        DoctorDao doctorDao = new DoctorDao(DbConnect.getConn());
        List<Appointment> appointments = appointmentDao.getAllAppointment();

        // Fill the data rows
        int rowNum = 1;
        for (Appointment appointment : appointments) {
            Doctor doctor = doctorDao.getDoctorbyId(appointment.getDoctorId());
            
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(appointment.getFullName());
            row.createCell(1).setCellValue(appointment.getGender());
            row.createCell(2).setCellValue(appointment.getAge());
            row.createCell(3).setCellValue(appointment.getAppoinDate());
            row.createCell(4).setCellValue(appointment.getEmail());
            row.createCell(5).setCellValue(appointment.getPhNo());
            row.createCell(6).setCellValue(appointment.getDiseases());
            row.createCell(7).setCellValue(doctor.getFullName());  // Doctor name from doctor table
            row.createCell(8).setCellValue(appointment.getAddress());
            row.createCell(9).setCellValue(appointment.getConform());
            row.createCell(10).setCellValue(appointment.getStatus());
            row.createCell(11).setCellValue(doctor.getHospital());  // Hospital name from doctor table
        }

        // Write the output to the response OutputStream
        OutputStream out = response.getOutputStream();
        workbook.write(out);
        out.close();
        workbook.close();
    }
}
