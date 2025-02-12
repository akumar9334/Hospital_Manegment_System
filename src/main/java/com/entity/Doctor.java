package com.entity;

/**
 * The Doctor class represents a doctor entity with additional fields such as 
 * country, state, city, and hospital.
 */
public class Doctor {
    private int id;
    private String fullName;
    private String dob;
    private String qualification;
    private String specialist;
    private String email;
    private String mobNo;
    private String password;
    private String country;   // New attribute for country
    private String state;    // New attribute for State
    private String city;     // New attribute for City
    private String hospital; // New attribute for Hospital
    private String conform;

    public String getConform() {
        return conform;
    }

    public void setConform(String conform) {
        this.conform = conform;
    }
    // Default constructor
    public Doctor() {}

    // Constructor with essential fields
    public Doctor(String fullName, String dob, String qualification, String specialist, String email, String mobNo, String password) {
        this.fullName = fullName;
        this.dob = dob;
        this.qualification = qualification;
        this.specialist = specialist;
        this.email = email;
        this.mobNo = mobNo;
        this.password = password;
    }

    // Constructor with all fields, excluding 'id' (for new doctor registration)
public Doctor(String fullName, String dob, String qualification, String specialist, String email, String mobNo, String password, 
              String country, String state, String city, String hospital) {
    this.fullName = fullName;
    this.dob = dob;
    this.qualification = qualification;
    this.specialist = specialist;
    this.email = email;
    this.mobNo = mobNo;
    this.password = password;
    this.country = country;
    this.state = state;
    this.city = city;
    this.hospital = hospital;
}


    // Getters and Setters for all fields

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getDob() {
        return dob;
    }

    public void setDob(String dob) {
        this.dob = dob;
    }

    public String getQualification() {
        return qualification;
    }

    public void setQualification(String qualification) {
        this.qualification = qualification;
    }

    public String getSpecialist() {
        return specialist;
    }

    public void setSpecialist(String specialist) {
        this.specialist = specialist;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getMobNo() {
        return mobNo;
    }

    public void setMobNo(String mobNo) {
        this.mobNo = mobNo;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    // Getters and setters for country, state, city, and hospital

    public String getcountry() {
        return country;
    }

    public void setcountry(String country) {
        this.country = country;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getHospital() {
        return hospital;
    }

    public void setHospital(String hospital) {
        this.hospital = hospital;
    }
}


