<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.entity.Doctor"%>
<%@page import="java.util.List"%>
<%@page import="com.entity.Appointment"%>
<%@page import="com.dao.DoctorDao"%>
<%@page import="com.dao.AppointmentDao"%>
<%@page import="com.Db.DbConnect"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Patient Details</title>
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
        <%@ include file="../css.jsp" %>
        <style type="text/css">
            .paint-card {
                box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
            }


        </style>
    </head>
    <body>
        <%@ include file="navbar.jsp" %> 

        <!-- Success message -->
        <c:if test="${not empty succMsg}">
            <div class="fs-3 text-center text-success" role="alert">${succMsg}</div>
            <c:remove var="succMsg" scope="session" />
        </c:if>

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
                        <%= currentDate%> <span>&nbsp;&nbsp;&nbsp;</span> <%= currentTime%>
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
                    <a href="/mavenproject2/admin/exportToExcelpatient" class="btn btn-success mb-3">Export to Excel</a>
                </div>
            </div>
        </div>


        <div class="col-md-12">
            <div class="card paint-card">
                <div class="card-body">
                    <p class="fs-3 text-center">Patient Details</p>
                    <table class="table">
                        <thead>
                            <tr>
                                <th scope="col">Full Name</th>
                                <th scope="col">Gender</th>
                                <th scope="col">Age</th>
                                <th scope="col">Appointment</th>
                                <th scope="col">Email</th>
                                <th scope="col">Mob No</th>
                                <th scope="col">Diseases</th>
                                <th scope="col">Doctor Name</th>
                                <th scope="col">Address</th>
                                <th scope="col">ConformStatus</th>
                                <th scope="col">CheckStatus</th>
                                <th scope="col">hospital</th>
                            </tr>
                        </thead>
                        <tbody id="appointmentTableBody">
                            <%
                                AppointmentDao dao = new AppointmentDao(DbConnect.getConn());
                                DoctorDao dao2 = new DoctorDao(DbConnect.getConn());
                                List<Appointment> list = dao.getAllAppointment();
                                for (Appointment ap : list) {
                                    Doctor d = dao2.getDoctorbyId(ap.getDoctorId());
                            %>
                            <tr class="appointmentRow">
                                <td><%= ap.getFullName()%></td>
                                <td><%= ap.getGender()%></td>
                                <td><%= ap.getAge()%></td>
                                <td><%= ap.getAppoinDate()%></td>
                                <td><%= ap.getEmail()%></td>
                                <td><%= ap.getPhNo()%></td>
                                <td><%= ap.getDiseases()%></td>
                                <td><%= d.getFullName()%></td>
                                <td><%= ap.getAddress()%></td>
                                <td style="color: <%= ap.getConform().equals("Pending") ? "black" : ap.getConform().equals("Confirmed") ? "green" : "green"%>;">
                                    <%= ap.getConform()%>
                                </td>
                                <td><%= ap.getStatus()%></td>
                                <td><%= ap.getHospital()%></td>
                            </tr>
                            <% }%>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>

        <!-- jQuery Script for Filtering Rows Based on Patient Name -->
        <script>
            $(document).ready(function () {
                // Function to filter rows
                function filterRows(searchValue) {
                    $(".appointmentRow").each(function () {
                        var patientName = $(this).find("td:first").text().toLowerCase(); // Get the patient's full name
                        if (patientName.indexOf(searchValue) > -1) {
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
