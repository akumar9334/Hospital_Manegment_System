/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

import com.entity.Doctor;
import com.mysql.cj.protocol.Resultset;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;
import com.entity.Appointment;

/**
 *
 * @author kumar
 */
public class DoctorDao {

    private final Connection Conn;

    public DoctorDao(Connection Conn) {

        super();
        this.Conn = Conn;
    }
// for the register the doctor datails in the database

  public boolean registerDoctor(Doctor d) {
    boolean f = false;

    try {
        // Update SQL query to include the new fields: county, state, city, hospital
        String sql = "INSERT INTO doctor(full_name, dob, qualification, specialist, email, mobno, password, country, state, city, hospital) " +
                     "VALUES(?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        // Prepare the statement
        PreparedStatement ps = Conn.prepareStatement(sql);
        
        // Set values for the parameters
        ps.setString(1, d.getFullName());
        ps.setString(2, d.getDob());
        ps.setString(3, d.getQualification());
        ps.setString(4, d.getSpecialist());
        ps.setString(5, d.getEmail());
        ps.setString(6, d.getMobNo());
        ps.setString(7, d.getPassword());
        ps.setString(8, d.getcountry());  // Set the county value
        ps.setString(9, d.getState());   // Set the state value
        ps.setString(10, d.getCity());   // Set the city value
        ps.setString(11, d.getHospital()); // Set the hospital value

        // Execute the update and check if the insertion was successful
        int i = ps.executeUpdate();
        if (i == 1) {
            f = true;
        }
    } catch (Exception e) {
        e.printStackTrace();
    }

    return f;
}

// this method call the all  doctor list from the db and show on the doctoc details form.

    public List<Doctor> getAllListDoctor() {

        List<Doctor> list = new ArrayList<Doctor>();
        Doctor d = null;
        try {

            String sql = "SELECT * FROM doctor ORDER BY id DESC";
            PreparedStatement ps = Conn.prepareStatement(sql);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                d = new Doctor();
                d.setId(rs.getInt(1));
                d.setFullName(rs.getString(2));
                d.setDob(rs.getString(3));
                d.setQualification(rs.getNString(4));
                d.setSpecialist(rs.getString(5));
                d.setEmail(rs.getString(6));
                d.setMobNo(rs.getString(7));
                d.setPassword(rs.getString(8));
                d.setHospital(rs.getString(12));

                list.add(d);
            }
        } catch (Exception e) {
            e.printStackTrace();

        }

        return list;

    }     

    // in form context in the edit_doctor.jsp
   public Doctor getDoctorbyId(int id) {
    Doctor d = null;
    try {
        String sql = "SELECT * FROM doctor WHERE id=?";
        PreparedStatement ps = Conn.prepareStatement(sql);
        ps.setInt(1, id);

        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            d = new Doctor();
            d.setId(rs.getInt(1));
            d.setFullName(rs.getString(2));
            d.setDob(rs.getString(3));
            d.setQualification(rs.getString(4));
            d.setSpecialist(rs.getString(5));
            d.setEmail(rs.getString(6));
            d.setMobNo(rs.getString(7));
            d.setPassword(rs.getString(8));
            d.setHospital(rs.getString(12));  // Correct method to set hospital name
            /*  d.setConform(rs.getString(13));*/
        }
    } catch (Exception e) {
        e.printStackTrace();
    }
    return d;
}


    public boolean updateDoctor(Doctor d) {
        boolean f = false;

        try {
            // Print the values to verify they are being set correctly
            System.out.println("Updating doctor with ID: " + d.getId());
            System.out.println("Full Name: " + d.getFullName());
            System.out.println("DOB: " + d.getDob());
            System.out.println("Qualification: " + d.getQualification());
            System.out.println("Specialist: " + d.getSpecialist());
            System.out.println("Email: " + d.getEmail());
            System.out.println("Mobile No: " + d.getMobNo());
            System.out.println("Password: " + d.getPassword());
            

            // Check if the specialist is null or empty and handle it
            if (d.getSpecialist() == null || d.getSpecialist().trim().isEmpty()) {
                throw new IllegalArgumentException("Specialist cannot be empty");
            }

            String sql = "UPDATE doctor set full_name = ?, dob = ?, qualification = ?, specialist = ?, email = ?, mobno = ?, password = ? WHERE id = ?";
            PreparedStatement ps = Conn.prepareStatement(sql);
            ps.setString(1, d.getFullName());
            ps.setString(2, d.getDob());
            ps.setString(3, d.getQualification());
            ps.setString(4, d.getSpecialist());
            ps.setString(5, d.getEmail());
            ps.setString(6, d.getMobNo());
            ps.setString(7, d.getPassword());
            ps.setInt(8, d.getId());  // ID for WHERE clause (last parameter)

            int rowsAffected = ps.executeUpdate();

            if (rowsAffected > 0) {
                System.out.println("Doctor updated successfully.");
                f = true;
            } else {
                System.out.println("No doctor found with the provided ID.");
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;
    }

    public boolean deleteDoctor(int id) {

        boolean f = false;

        try {
            String sql = "delete from doctor where id=?";
            PreparedStatement ps = Conn.prepareStatement(sql);
            ps.setInt(1, id);

            int i = ps.executeUpdate();
            if (i == 1) {
                f = true;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return f;

    }

    public Doctor login(String email, String psw) {
        Doctor d = null;

        try {
            String sql = "select * from doctor where email=? and password=?";
            PreparedStatement ps = Conn.prepareStatement(sql);
            // this is for doctor login check
            ps.setString(1, email);
            ps.setString(2, psw);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                d = new Doctor();
                d.setId(rs.getInt(1));
                d.setFullName(rs.getString(2));
                d.setDob(rs.getString(3));
                d.setQualification(rs.getString(4));
                d.setSpecialist(rs.getString(5));
                d.setEmail(rs.getString(6));
                d.setMobNo(rs.getString(7));
                d.setPassword(rs.getString(8));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return d;

    }

    public int countDoctor() {
        int i = 0;
        try {
            String sql = "select * from doctor";
            PreparedStatement ps = Conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                i++;
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;

    }

    public int countuser() {
        int i = 0;
        try {
            String sql = "select * from user_detail";
            PreparedStatement ps = Conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                i++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }
       public int countspecialist() {
        int i = 0;
        try {
            String sql = "select * from specialist";
            PreparedStatement ps = Conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                i++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }
       public int countAppointment() {
        int i = 0;
        try {
            String sql = "select * from appointment";
            PreparedStatement ps = Conn.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                i++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }
       
        public int countAppointmentByDoctorId(int did) {
        int i = 0;
        try {
            String sql = "select * from appointment where doctor_id=?";
            PreparedStatement ps = Conn.prepareStatement(sql);
            ps.setInt(1, did);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                i++;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }
        
      public boolean checkOldPassword(int userid, String oldPassword) {
		boolean f = false;

		try {
			String sql = "select * from doctor where id=? and password=?";
			PreparedStatement ps = Conn.prepareStatement(sql);
			ps.setInt(1, userid);
			ps.setString(2, oldPassword);

			ResultSet rs = ps.executeQuery();
			while (rs.next()) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}
        
        	public boolean changePassword(int userid, String newPassword) {
		boolean f = false;

		try {
			String sql = "update doctor set password=? where id=?";
			PreparedStatement ps = Conn.prepareStatement(sql);
			ps.setString(1, newPassword);
			ps.setInt(2, userid);

			int i = ps.executeUpdate();
			if (i == 1) {
				f = true;
			}

		} catch (Exception e) {
			e.printStackTrace();
		}

		return f;
	}  
        
         public boolean editDoctorProfile(Doctor d) {
    boolean f = false;
    try {
        // Debugging: print out the parameters
        System.out.println("Updating doctor with ID: " + d.getId());
        System.out.println("Full Name: " + d.getFullName());
        System.out.println("DOB: " + d.getDob());
        System.out.println("Qualification: " + d.getQualification());
        System.out.println("Specialist: " + d.getSpecialist());
        System.out.println("Email: " + d.getEmail());
        System.out.println("Mobile No: " + d.getMobNo());

        // SQL update query
        String sql = "UPDATE doctor SET full_name = ?, dob = ?, qualification = ?, specialist = ?, email = ?, mobno = ? WHERE id = ?";
        PreparedStatement ps = Conn.prepareStatement(sql);

        // Setting the parameters
        ps.setString(1, d.getFullName());
        ps.setString(2, d.getDob());
        ps.setString(3, d.getQualification());
        ps.setString(4, d.getSpecialist());
        ps.setString(5, d.getEmail());
        ps.setString(6, d.getMobNo());
        ps.setInt(7, d.getId());

        // Execute the update
        int rowsAffected = ps.executeUpdate();

        if (rowsAffected > 0) {
            System.out.println("Doctor updated successfully.");
            f = true;
        } else {
            System.out.println("No doctor found with the provided ID.");
        }
    } catch (Exception e) {
        // Print the full stack trace for debugging
        e.printStackTrace();
        System.out.println("Error while updating doctor: " + e.getMessage());
    }
    return f;
}
      
}
