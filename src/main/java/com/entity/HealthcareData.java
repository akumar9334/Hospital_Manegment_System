package com.entity;

public class HealthcareData {
    private String countryName;
    private String stateName;
    private String districtName;
    private String blockName;
    private String hospitalName;

    // Foreign key ids
    private int countryId;
    private int stateId;
    private int districtId;
    private int blockId;

    // Constructors
    public HealthcareData() {}

    public HealthcareData(String countryName, String stateName, String districtName, String blockName, String hospitalName) {
        this.countryName = countryName;
        this.stateName = stateName;
        this.districtName = districtName;
        this.blockName = blockName;
        this.hospitalName = hospitalName;
    }

    // Getters and setters
    public String getCountryName() {
        return countryName;
    }

    public void setCountryName(String countryName) {
        this.countryName = countryName;
    }

    public String getStateName() {
        return stateName;
    }

    public void setStateName(String stateName) {
        this.stateName = stateName;
    }

    public String getDistrictName() {
        return districtName;
    }

    public void setDistrictName(String districtName) {
        this.districtName = districtName;
    }

    public String getBlockName() {
        return blockName;
    }

    public void setBlockName(String blockName) {
        this.blockName = blockName;
    }

    public String getHospitalName() {
        return hospitalName;
    }

    public void setHospitalName(String hospitalName) {
        this.hospitalName = hospitalName;
    }

    // Getters and setters for foreign key ids
    public int getCountryId() {
        return countryId;
    }

    public void setCountryId(int countryId) {
        this.countryId = countryId;
    }

    public int getStateId() {
        return stateId;
    }

    public void setStateId(int stateId) {
        this.stateId = stateId;
    }

    public int getDistrictId() {
        return districtId;
    }

    public void setDistrictId(int districtId) {
        this.districtId = districtId;
    }

    public int getBlockId() {
        return blockId;
    }

    public void setBlockId(int blockId) {
        this.blockId = blockId;
    }
}
