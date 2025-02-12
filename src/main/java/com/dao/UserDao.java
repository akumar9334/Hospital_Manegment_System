package com.dao;

import com.entity.User;
import com.mysql.cj.protocol.Resultset;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class UserDao {
    private Connection conn;

    // Constructor to initialize the connection
    public UserDao(Connection conn) {
        super();
        this.conn = conn;
    }
    
    // Method to register a new user
    public boolean register(User u) {
        boolean f = false;
        PreparedStatement ps = null;

        try {
            // SQL query to insert the user into the database
            String sql = "INSERT INTO user_detail (fullname, Email, password) VALUES (?, ?, ?)";
            ps = conn.prepareStatement(sql);
            
            // Set the values for the placeholders in the query
            ps.setString(1, u.getFullName());
            ps.setString(2, u.getEmail());
            ps.setString(3, u.getPassword());
            
            // Execute the update query
            int i = ps.executeUpdate();
            
            // If the query was successful, 'i' should be 1
            if (i == 1) {
                f = true;
            }

        } catch (SQLException e) {
            // Print the SQLException details
            System.err.println("SQL Exception: " + e.getMessage());
            e.printStackTrace();
        } catch (Exception e) {
            // Catch any other exceptions
            System.err.println("Error: " + e.getMessage());
            e.printStackTrace();
        } finally {
            // Ensure the PreparedStatement is closed
            try {
                if (ps != null) {
                    ps.close();
                }
            } catch (SQLException e) {
                System.err.println("Error closing PreparedStatement: " + e.getMessage());
            }
        }

        return f;
    }
    /**
     *
     * @param em
     * @param ps
     * @return
     */
    public User login(String em,String psw)
        {
        User u = null;
        try{
        String sql ="select * from user_detail where email=? and password=?";
        PreparedStatement ps= conn.prepareStatement(sql);
        
         // Log the email and password for debugging
            System.out.println("Email: " + em);
            System.out.println("Password: " + psw);
        ps.setString(1, em);
        ps.setString(2, psw);
        
            ResultSet rs = ps.executeQuery();
            while(rs.next())
            {
            u=new User();
            u.setId(rs.getInt(1));
            u.setFullName(rs.getString(2));
            u.setEmail(rs.getString(3));
            u.setPassword(rs.getString(4));
            
            
            }
                
                
        }catch(Exception e)
        {
        
        e.printStackTrace();
        
        }
        return u ;
        }
        
        public boolean checkOldPassword(int userid, String oldPassword) {
		boolean f = false;

		try {
			String sql = "select * from user_detail where id=? and password=?";
			PreparedStatement ps = conn.prepareStatement(sql);
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
			String sql = "update user_detail set password=? where id=?";
			PreparedStatement ps = conn.prepareStatement(sql);
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
        
    }

