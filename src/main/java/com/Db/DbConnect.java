package com.Db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DbConnect {
    private static Connection conn;

    // Method to get the database connection
    public static Connection getConn() {
        try {
            if (conn == null || conn.isClosed()) {
                // Load MySQL driver if not already loaded
                Class.forName("com.mysql.cj.jdbc.Driver");
                // Establish connection and assign to 'conn'
                conn = DriverManager.getConnection("jdbc:mysql://localhost:33061/hospital_management", "root", "root");
            }
        } catch (ClassNotFoundException | SQLException e) {
            e.printStackTrace();
        }
        return conn;
    }

    // Method to close the database connection
    public static void closeConnection() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("Database connection closed.");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
