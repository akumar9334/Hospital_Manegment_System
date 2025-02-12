/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

import com.entity.Appointment;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author kumar
 */
public class AppointmentDao {

    private Connection Conn;

    public AppointmentDao(Connection Conn) {
        super();
        this.Conn = Conn;

    }

    public boolean addAppointment(Appointment ap) {

//        System.out.println("Attempting to add appointment: " + ap);
        boolean f = false;

        try {
            String sql = "INSERT INTO appointment (user_id, fullName, gender, age, appoint_date, email, phNo, diseases, doctor_id, address, status) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
            PreparedStatement ps = Conn.prepareStatement(sql);

            // Set the parameters for the prepared statement
            ps.setInt(1, ap.getUserId());
            ps.setString(2, ap.getFullName());
            ps.setString(3, ap.getGender());
            ps.setString(4, ap.getAge());  // Use setInt() if age is an integer
            ps.setString(5, ap.getAppoinDate());  // Assuming appointDate is a String, otherwise, use setDate()
            ps.setString(6, ap.getEmail());
            ps.setString(7, ap.getPhNo());
            ps.setString(8, ap.getDiseases());
            ps.setInt(9, ap.getDoctorId());
            ps.setString(10, ap.getAddress());
            ps.setString(11, ap.getStatus());

            // Execute the query
            int i = ps.executeUpdate();

            // If 1 row is affected, the insert was successful
            if (i == 1) {
                f = true;
            }
        } catch (SQLException e) {
            e.printStackTrace();  // Log the exception for debugging
        }

        // Return the result of the insert operation
        return f;
    }

    public List<Appointment> getAllAppointmentByLoginUser(int userId) {
        List<Appointment> list = new ArrayList<Appointment>();
        Appointment ap = null;

        try {
            String sql = "select * from appointment where user_id=?";
            PreparedStatement ps = Conn.prepareStatement(sql);
            ps.setInt(1, userId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ap = new Appointment();
                ap.setId(rs.getInt(1));
                ap.setUserId(rs.getInt(2));
                ap.setFullName(rs.getString(3));
                ap.setGender(rs.getString(4));
                ap.setAge(rs.getString(5));
                ap.setAppoinDate(rs.getString(6));
                ap.setEmail(rs.getString(7));
                ap.setPhNo(rs.getString(8));
                ap.setDiseases(rs.getString(9));
                ap.setDoctorId(rs.getInt(10));
                ap.setAddress(rs.getString(11));
                ap.setStatus(rs.getString(12));
                ap.setConform(rs.getNString(13));
                list.add(ap);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;

    }

    public List<Appointment> getAllAppointmentByDoctorlogin(int doctorId) {
        List<Appointment> list = new ArrayList<Appointment>();
        Appointment ap = null;

        try {
            String sql = "select * from appointment where doctor_id=?";
            PreparedStatement ps = Conn.prepareStatement(sql);
            ps.setInt(1, doctorId);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ap = new Appointment();
                ap.setId(rs.getInt(1));
                ap.setUserId(rs.getInt(2));
                ap.setFullName(rs.getString(3));
                ap.setGender(rs.getString(4));
                ap.setAge(rs.getString(5));
                ap.setAppoinDate(rs.getString(6));
                ap.setEmail(rs.getString(7));
                ap.setPhNo(rs.getString(8));
                ap.setDiseases(rs.getString(9));
                ap.setDoctorId(rs.getInt(10));
                ap.setAddress(rs.getString(11));
                ap.setStatus(rs.getString(12));
                ap.setConform(rs.getString(13));
                list.add(ap);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    public Appointment getAppointmentById(int id) {
        Appointment ap = null;

        String sql = "SELECT * FROM appointment WHERE id = ?";

        try (PreparedStatement ps = Conn.prepareStatement(sql)) {
            ps.setInt(1, id);  // Set the id parameter

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    ap = new Appointment();
                    ap.setId(rs.getInt(1));  // Map the result set to the Appointment object
                    ap.setUserId(rs.getInt(2));
                    ap.setFullName(rs.getString(3));
                    ap.setGender(rs.getString(4));
                    ap.setAge(rs.getString(5));
                    ap.setAppoinDate(rs.getString(6));
                    ap.setEmail(rs.getString(7));
                    ap.setPhNo(rs.getString(8));
                    ap.setDiseases(rs.getString(9));
                    ap.setDoctorId(rs.getInt(10));
                    ap.setAddress(rs.getString(11));
                    ap.setStatus(rs.getString(12));
                    ap.setConform(rs.getString(13));
                }
            } catch (Exception e) {
                e.printStackTrace();  // Log the exception for debugging
            }
        } catch (Exception e) {
            e.printStackTrace();  // Log the exception for debugging
        }

        return ap;  // Return the appointment, or null if not found
    }

    public boolean UpdateCommentStatus(int id, int doctId, String Comm) {
        boolean f = false;
        try {

            // Correct the SQL query
            String sql = "UPDATE appointment SET status=? WHERE id=? AND doctor_id=?";

            // Prepare the statement
            PreparedStatement ps = Conn.prepareStatement(sql);

            // Set the parameters for the prepared statement
            ps.setString(1, Comm);  // Set comment in the status column
            ps.setInt(2, id);       // Set the appointment ID
            ps.setInt(3, doctId);   // Set the doctor ID

            // Execute the update
            int i = ps.executeUpdate();

            // Check if the update was successful
            if (i == 1) {
                f = true;  // If 1 row was updated, set f to true
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;  // Return the result of the update operation
    }

    public boolean UpdateConformStatus(int id, int doctId, String conform) {
        boolean f = false;
        try {
            // Log the Comm value for debugging

            System.out.println("Conform Status before update: " + conform);

            // Check if conform is null or empty and set a default value if necessary
            if (conform == null || conform.trim().isEmpty()) {
                conform = "Not Updated"; // Default value when the conform is empty
            }

            // Correct the SQL query
            String sql = "UPDATE appointment SET conform=? WHERE id=? AND doctor_id=?";

            // Check if Comm is null or empty and set a default value if necessary
            if (conform == null || conform.trim().isEmpty()) {
                conform = "Not Updated"; // Default value when the comment is empty
            }

            // Prepare the statement
            PreparedStatement ps = Conn.prepareStatement(sql);

            // Set the parameters for the prepared statement
            ps.setString(1, conform);  // Set comment in the status column
            ps.setInt(2, id);       // Set the appointment ID
            ps.setInt(3, doctId);   // Set the doctor ID

            // Execute the update
            int i = ps.executeUpdate();

            // Check if the update was successful
            if (i == 1) {
                f = true;  // If 1 row was updated, set f to true
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;  // Return the result of the update operation
    }

    public List<Appointment> getAllAppointment() {
        List<Appointment> list = new ArrayList<Appointment>();
        Appointment ap = null;

        try {
            String sql = "SELECT a.*, d.hospital\n"
                    + "FROM appointment a\n"
                    + "JOIN doctor d ON a.doctor_id = d.id\n"
                    + "ORDER BY a.id DESC;";
            
            PreparedStatement ps = Conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                ap = new Appointment();
                ap.setId(rs.getInt(1));
                ap.setUserId(rs.getInt(2));
                ap.setFullName(rs.getString(3));
                ap.setGender(rs.getString(4));
                ap.setAge(rs.getString(5));
                ap.setAppoinDate(rs.getString(6));
                ap.setEmail(rs.getString(7));
                ap.setPhNo(rs.getString(8));
                ap.setDiseases(rs.getString(9));
                ap.setDoctorId(rs.getInt(10));
                ap.setAddress(rs.getString(11));
                ap.setStatus(rs.getString(12));
                ap.setConform(rs.getString(13));
                ap.setHospital(rs.getString(14));

                list.add(ap);
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

}
