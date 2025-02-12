package com.dao;

import com.entity.HealthcareData;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class HealthcareDataDao {

    private Connection conn;

    public HealthcareDataDao(Connection conn) {
        this.conn = conn;
    }

    public boolean insertHealthcareData(HealthcareData data) {
        try {
            // 1. Insert Country if it doesn't exist, and get countryId
            int countryId = insertCountry(data.getCountryName());

            // 2. Insert State if it doesn't exist, and get stateId
            int stateId = insertState(data.getStateName(), countryId);

            // 3. Insert District if it doesn't exist, and get districtId
            int districtId = insertDistrict(data.getDistrictName(), stateId);

            // 4. Insert Block if it doesn't exist, and get blockId
            int blockId = insertBlock(data.getBlockName(), districtId);

            // 5. Insert Hospital, linking it with blockId
            return insertHospital(data.getHospitalName(), blockId);

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    private int insertCountry(String countryName) throws SQLException {
        String sql = "INSERT INTO country (country_name) VALUES (?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, countryName);
            stmt.executeUpdate();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the generated country id
                }
            }
        }
        return -1; // Error if insertion failed
    }

    private int insertState(String stateName, int countryId) throws SQLException {
        String sql = "INSERT INTO state (state_name, country_id) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, stateName);
            stmt.setInt(2, countryId);
            stmt.executeUpdate();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the generated state id
                }
            }
        }
        return -1;
    }

    private int insertDistrict(String districtName, int stateId) throws SQLException {
        String sql = "INSERT INTO district (district_name, state_id) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, districtName);
            stmt.setInt(2, stateId);
            stmt.executeUpdate();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the generated district id
                }
            }
        }
        return -1;
    }

    private int insertBlock(String blockName, int districtId) throws SQLException {
        String sql = "INSERT INTO block (block_name, district_id) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql, PreparedStatement.RETURN_GENERATED_KEYS)) {
            stmt.setString(1, blockName);
            stmt.setInt(2, districtId);
            stmt.executeUpdate();
            try (ResultSet rs = stmt.getGeneratedKeys()) {
                if (rs.next()) {
                    return rs.getInt(1); // Return the generated block id
                }
            }
        }
        return -1;
    }

    private boolean insertHospital(String hospitalName, int blockId) throws SQLException {
        String sql = "INSERT INTO hospital (hospital_name, block_id) VALUES (?, ?)";
        try (PreparedStatement stmt = conn.prepareStatement(sql)) {
            stmt.setString(1, hospitalName);
            stmt.setInt(2, blockId);
            int rowsInserted = stmt.executeUpdate();
            return rowsInserted > 0; // If rows are inserted, return true
        }
    }
}
