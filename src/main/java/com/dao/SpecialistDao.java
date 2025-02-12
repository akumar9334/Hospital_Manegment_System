/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.dao;

import com.entity.Specialist;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author kumar
 */
public class SpecialistDao {
    
    
    private Connection Conn;
    
    
    public SpecialistDao(Connection Conn){
    
    super();
    this.Conn = Conn;
    
    }
    public boolean addSpecialist(String spec)
    {
    boolean f= false;
    try{
    
        String sql = "insert into Specialist(spec_name) values(?) ";
        PreparedStatement ps= Conn.prepareStatement(sql);
        ps.setString(1, spec); // Set the value for the first placeholder
        
        int i = ps.executeUpdate();
        if (i==1){
        
        f= true;
        }
    }
    catch(Exception e)
    {e.printStackTrace();
    
    }
    return f;
    
    }
    
    public List<Specialist> getAllSpecialist()
    
    {
    List<Specialist> list = new ArrayList<Specialist>();
    
    Specialist s= null;
    try
    {
    String sql="select * from Specialist";
    PreparedStatement ps = Conn.prepareStatement(sql);
    // for dropdaun maping in list section
    
        ResultSet rs=ps.executeQuery();
        while(rs.next()){
        s= new Specialist();
        s.setId(rs.getInt(1));
        s.setSpecialistName(rs.getString(2));
        list.add(s);
        }
    
    
    }
    catch(Exception e)
    
    {
    e.printStackTrace();
    }
    
    return list;
    }
}
