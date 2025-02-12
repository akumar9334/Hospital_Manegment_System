/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.admin.servlet;

/**
 *
 * @author kumar
 */


import com.dao.DoctorDao;
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

@WebServlet("/admin/exportToExcel")
public class ExportToExcelServlet extends HttpServlet {

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Set the content type to Excel
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=DoctorDetails.xlsx");

        // Create a workbook and a sheet
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Doctors");

        // Create the header row
        Row headerRow = sheet.createRow(0);
        headerRow.createCell(0).setCellValue("Full Name");
        headerRow.createCell(1).setCellValue("DOB");
        headerRow.createCell(2).setCellValue("Qualification");
        headerRow.createCell(3).setCellValue("Specialist");
        headerRow.createCell(4).setCellValue("Email");
        headerRow.createCell(5).setCellValue("Mob No");
        headerRow.createCell(6).setCellValue("Hospital Name");

        // Fetch the list of doctors from the database
        DoctorDao dao = new DoctorDao(DbConnect.getConn());
        List<Doctor> doctorList = dao.getAllListDoctor();

        // Fill the data rows
        int rowNum = 1;
        for (Doctor doctor : doctorList) {
            Row row = sheet.createRow(rowNum++);
            row.createCell(0).setCellValue(doctor.getFullName());
            row.createCell(1).setCellValue(doctor.getDob());
            row.createCell(2).setCellValue(doctor.getQualification());
            row.createCell(3).setCellValue(doctor.getSpecialist());
            row.createCell(4).setCellValue(doctor.getEmail());
            row.createCell(5).setCellValue(doctor.getMobNo());
            row.createCell(6).setCellValue(doctor.getHospital());
        }

        // Write the output to the response OutputStream
        OutputStream out = response.getOutputStream();
        workbook.write(out);
        out.close();
        workbook.close();
    }
}

