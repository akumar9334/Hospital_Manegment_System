<%-- 
    Document   : patient
    Created on : Dec 17, 2024, 12:48:38 PM
    Author     : kumar
--%>
<%@page import="com.entity.Doctor"%>
<%@page import="java.util.List"%>
<%@page import="com.entity.Appointment"%>
<%@page import="com.dao.DoctorDao"%>
<%@page import="com.dao.AppointmentDao"%>
<%@page import="com.Db.DbConnect"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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

        <c:if test="${empty doctObj}">
            <c:redirect url="../Doctor_login.jsp" />
        </c:if>

        <!-- Error message -->
        <c:if test="${not empty errorMsg}">
            <p class="fs-3 text-center text-danger">${errorMsg}</p>
            <c:remove var="errorMsg" scope="session" />
        </c:if>

        <!-- Success message -->
        <c:if test="${not empty succMsg}">
            <div class="fs-3 text-center text-success" role="alert">${succMsg}</div>
            <c:remove var="succMsg" scope="session" />
        </c:if>

        <div class="col-md-12">
            <div class="card paint-card">
                <div class="card-body">
                    <p class="fs-3 text-center">Patient Details</p>
                   <div class="d-flex justify-content-center mb-3">
                <input type="text" id="searchName" class="form-control w-50" placeholder="Search by Patient Name">
                <button id="searchButton" class="btn btn-primary ms-2">Search</button>
            </div>
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
                                <th scope="col">Conform Status</th>
                                <th scope="col">check Status</th>
                                <th scope="col">Action</th>
                            </tr>
                        </thead>
                       <tbody id="appointmentTableBody">
                            <%Doctor d = (Doctor) session.getAttribute("doctObj");
                                AppointmentDao dao = new AppointmentDao(DbConnect.getConn());

                                List<Appointment> list = dao.getAllAppointmentByDoctorlogin(d.getId());
                                for (Appointment ap : list) {

                            %>
                            <tr class="appointmentRow">
                                <th><%=ap.getFullName()%></th>
                                <td><%=ap.getGender()%></td>
                                <td><%=ap.getAge()%></td>
                                <td><%=ap.getAppoinDate()%></td>
                                <td><%=ap.getEmail()%></td>
                                <td><%=ap.getPhNo()%></td>
                                <td><%=ap.getDiseases()%></td>
                                <td><%=ap.getFullName()%></td>
                                <td><%=ap.getAddress()%></td>
                                <td>
                                    <%
                                        if ("Pending".equals(ap.getConform())) {
                                    %>
                                    <a href="../doctor/conformation.jsp?id=<%= ap.getId()%>" class="btn btn-danger btn-sm"><%=ap.getConform()%></a>
                                    <%
                                    } else {
                                    %>
                                    <a href="javascript:void(0)" class="btn btn-warning btn-sm" tabindex="-1" aria-disabled="true"><%=ap.getConform()%></a>
                                    <%
                                        }
                                    %>

                                     </td>
                                <td><%=ap.getStatus()%></td>
                                

                                     <td>
                                    <%
                                        if ("Pending".equals(ap.getStatus())) {
                                    %>
                                    <a href="../doctor/comment.jsp?id=<%= ap.getId()%>" class="btn btn-success btn-sm">Comment</a>
                                    <%
                                    } else {
                                    %>
                                    <a href="javascript:void(0)" class="btn btn-success btn-sm" tabindex="-1" aria-disabled="true">Comment</a>
                                    <%
                                        }
                                    %>

                                     </td>

                               
                            </tr>
                            <%
                                }
                            %>


                        </tbody> 
                    </table>

                </div>
            </div>
        </div>
<script>
    $(document).ready(function () {
        // Function to filter rows
        function filterRows(searchValue) {
            $(".appointmentRow").each(function () {
                var patientName = $(this).find("th:first").text().toLowerCase(); // Get the patient's full name
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
</script>

    </body>
</html>