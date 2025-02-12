

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.dao.DoctorDao"%>
<%@page import="com.entity.Doctor"%>
<%@page import="java.util.List"%>
<%@page import="com.entity.Specialist"%>
<%@page import="com.Db.DbConnect"%>
<%@page import="com.dao.SpecialistDao"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Add Doctor</title>
       <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

        <%@include file="../css.jsp"%>
        <style type="text/css">
            .paint-card {
                box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
            }
        </style>
    </head>
    <body>
        <%@include file="navbar.jsp"%>
        <div class="container-fluid p-3">
            <div class="row">
                <!-- Left Column (Form) -->
                
                <div class="container mt-3" style="margin-bottom: 7px;">
            <div class="row align-items-center">
                <!-- Left side: Display current date and time -->
                <div class="col-md-6">
                    <p id="currentDateTime" class="fs-5">
                        Current Date & Time: 
                        <%
                            // Set date format
                            SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");
                            String currentDate = sdf.format(new Date());

                            // Set time format with 3 spaces between date and time
                            SimpleDateFormat timeSdf = new SimpleDateFormat("HH:mm:ss");
                            String currentTime = timeSdf.format(new Date());
                        %>
                        <%= currentDate%> <span>&nbsp;&nbsp;&nbsp;</span> <%= currentTime%><span>&nbsp;&nbsp;</span>
                    <h7 style="color: blue;">Welcome to show the doctor details</h7>
                        
                </p>
                </div>
                    
                <!-- Right side: Search bar and export button -->
                <div class="col-md-6 d-flex justify-content-end">
                    <!-- Search Bar and Button -->
                    <div class="d-flex me-4">
                        <input type="text" id="searchName" class="form-control" placeholder="Search by Patient Name">
                        <button id="searchButton" class="btn btn-primary ms-2">Search</button>
                    </div>

                    <!-- Export to Excel Button -->
                    <a href="<%= request.getContextPath()%>/admin/exportToExcel" class="btn btn-success mb-3">Export to Excel</a>
                </div>
            </div>
        </div>
                <!-- Right Column (Doctor Details) -->
                <div class="col-md-12">
                    <div class="card paint-card">
                        <div class="card-body">
                            <p class="fs-3 text-center">Doctor Details</p>
                            <c:if test="${not empty succMsg }">
                                <p class="text-center text-success fs-3">${succMsg}</p>
                                <c:remove var="succMsg" scope="session" />
                            </c:if>

                            <c:if test="${not empty errorMsg }">
                                <p class="text-center text-danger fs-5">${errorMsg}</p>
                                <c:remove var="errorMsg" scope="session" />
                            </c:if>
                                
                                
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Full Name</th>
                                        <th scope="col">DOB</th>
                                        <th scope="col">Qualification</th>
                                        <th scope="col">Specialist</th>
                                        <th scope="col">Email</th>
                                        <th scope="col">Mob No</th>
                                        <th scope="col">HospitalName</th>
                                        <th scope="col">Action</th>
                                         
                                    </tr>
                                </thead>
                                <tbody>
                                    <!-- Example data for displaying doctors (you need to fill this with actual data from your DB) -->
                                    <% 
                                      // Sample data to show in the table
                                      // You can replace this with actual database results
                                      DoctorDao dao2=new DoctorDao(DbConnect.getConn());
                                      List<Doctor>list2 = dao2.getAllListDoctor();
                                      for (Doctor d : list2) 
                                      {
                                    %> 
                                         <tr class="DoctordetailsRow">
                                            <td><%= d.getFullName() %></td>
                                            <td><%= d.getDob() %></td>
                                           <td><div class="center-content"><%= d.getQualification() %></div></td>
                                            <td><%= d.getSpecialist() %></td>
                                            <td><%= d.getEmail() %></td>
                                            <td><%= d.getMobNo() %></td>
                                            <td><%= d.getHospital()%></td>
                                            <td>
                                               <a href="edit_doctor.jsp?id=<%=d.getId()%>" class="btn btn-info btn-sm">Edit</a>

                                                <a href="../deleteDoctor?id=<%= d.getId() %>" class="btn btn-danger btn-sm">Delete</a>
                                            </td>
                                        </tr>
                                    <% } %> 
                                </tbody>
                            </table>
                        </div>
                    </div>
                </div>

            </div>
        </div>

        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script>
            $(document).ready(function () {
                // Function to filter rows
                function filterRows(searchValue) {
                    $(".DoctordetailsRow").each(function () {
                        var docotorName = $(this).find("td:first").text().toLowerCase(); // Get the patient's full name
                        if (docotorName.indexOf(searchValue) > -1) {
                            $(this).show(); // Show row if it matches
                        } else {
                            $(this).hide(); // Hide row if it doesn't match
                        }
                    });
                }

                // Listen for keyup event in the search input field (real-time search)
                $("#searchName").on("keyup", function () {
                    var value = $(this).val().toLowerCase(); // Get the search value
                    filterRows(value); // Filter rows as the user types
                });

                // Listen for click event on the search button
                $("#searchButton").on("click", function () {
                    var value = $("#searchName").val().toLowerCase(); // Get the search value
                    filterRows(value); // Filter rows when search button is clicked
                });
            });
            // Real-time Date/Time Update using JavaScript (updating currentDateTime every second)
            setInterval(function () {
                var currentDate = new Date();

                // Convert the hour to 12-hour format (without leading zero)
                var hours = currentDate.getHours();
                var period = 'AM';

                if (hours >= 12) {
                    period = 'PM'; // PM period for hours >= 12
                }
                if (hours > 12) {
                    hours = hours - 12; // Convert to 12-hour format
                }
                if (hours === 0) {
                    hours = 12; // If the hour is 0 (midnight), set it to 12
                }

                // Format the date as dd-MM-yyyy
                var formattedDate = ('0' + currentDate.getDate()).slice(-2) + '-' +
                        ('0' + (currentDate.getMonth() + 1)).slice(-2) + '-' +
                        currentDate.getFullYear() +
                        '&nbsp;&nbsp;&nbsp;' + // 3 spaces between date and time (you can use &nbsp; if needed)
                        hours + ':' + // Hour without leading zero
                        ('0' + currentDate.getMinutes()).slice(-2) + ':' + // Minutes with leading zero
                        ('0' + currentDate.getSeconds()).slice(-2) + ' ' + // Seconds with leading zero
                        period;  // Add AM/PM

                // Update the content of the #currentDateTime element with formatted date and time
                $("#currentDateTime").html("Date & Time: " + formattedDate);
            }, 1000); // Update every second
            // Update every second
// Update every second
        </script>
    </body>
</html>
