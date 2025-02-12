<%-- 
    Document   : view_appointment
    Created on : Dec 16, 2024, 9:52:35 PM
    Author     : kumar
--%>
<%@page import="com.entity.Appointment"%>
<%@page import="com.dao.AppointmentDao"%>
<%@page import="com.entity.User"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false"%>
<%@page import="java.util.List"%>
<%@page import="com.entity.Doctor"%>
<%@page import="com.Db.DbConnect"%>
<%@page import="com.dao.DoctorDao"%>
<%
    response.setHeader("Cache-Control", "no-cache");
    response.setHeader("Cache-Control", "no-store");
    response.setHeader("Pragma", "no-cache");
    response.setDateHeader("Expires", 0);
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <%@ include file="css.jsp" %>
          
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
        <style type="text/css">
            .paint-card {
                box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
            }

            .backImg {
                background: linear-gradient(rgba(0, 0, 0, .4), rgba(0, 0, 0, .4)),
                    url("img/hospit1.jpg");
                height: 20vh;
                width: 100%;
                background-size: cover;
                background-repeat: no-repeat;
            }
            .col-md-3 img {
                width: 100%;
                height: auto;
                object-fit: contain;
            }
            .image-container img {
                margin-bottom: 25%; /* Adjust the margin between images */
            }


            .text-center p {
                font-size: 18px;
                color: #333;
                margin: 10px 0;
            }

            .text-center p:first-child {
                font-weight: bold;
                font-size: 20px;
            }

        </style>

    </head>
    <body>
        <%@include file="navbar.jsp"%>

        <div class="container-fulid backImg p-5">
            <p class="text-center fs-2 text-white"></p>
        </div>
        <div class="container p-3">
            <div class="row">
                <div class="col-md-9">
                    <div class="card paint-card">
                        <div class="card-body">
                            <p class="fs-4 fw-bold text-center text-success">Appointment
                                List</p>
                            <table class="table">
                                <thead>
                                    <tr>
                                        <th scope="col">Full Name</th>
                                        <th scope="col">Gender</th>
                                        <th scope="col">Age</th>
                                        <th scope="col">Appoint Date</th>
                                        <th scope="col">Diseases</th>
                                        <th scope="col">Doctor Name</th>
                                        <th scope="col">Conform Status</th>
                                        <th scope="col">Check Status</th>
                                       
                                    </tr>
                                </thead>
                                <tbody>
                                    <%
                                        User user = (User) session.getAttribute("userObj");
                                        AppointmentDao dao = new AppointmentDao(DbConnect.getConn());
                                        DoctorDao dao2 = new DoctorDao(DbConnect.getConn());
                                        List<Appointment> list = dao.getAllAppointmentByLoginUser(user.getId());
                                        for (Appointment ap : list) {
                                            Doctor d = dao2.getDoctorbyId(ap.getDoctorId());
                                    %>
                                    <tr>
                                        <th><%=ap.getFullName()%></th>
                                        <td><%=ap.getGender()%></td>
                                        <td><%=ap.getAge()%></td>
                                        <td><%=ap.getAppoinDate()%></td>
                                        <td><%=ap.getDiseases()%></td>
                                        <td><%=d.getFullName()%></td>
                                         <td>
                                            <%
                                                if ("Pending".equals(ap.getConform())) {
                                            %> <a href="#" class="btn btn-sm btn-warning">Pending</a> <%
                                            } else {
                                            %> <%=ap.getConform()%> <%
                                                }
                                            %>
                                        </td>
                                         
                                        <td>
                                            <%
                                                if ("Pending".equals(ap.getStatus())) {
                                            %> <a href="#" class="btn btn-sm btn-warning">Pending</a> <%
                                            } else {
                                            %> <%=ap.getStatus()%> <%
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
                <div class="col-md-3 p-3">
                    <div class="row">
                        <div class="col-12 image-container">
                            <img alt="doctor image 1" src="img/doct7.png" class="img-fluid">
                        </div>
                        <div class="col-12 mb-3 text-center">
                            <p style="font-size: 18px; font-weight: bold; color: orange;">Welcome to my hospital</p>
                            <p style="font-size: 16px; color: yellowgreen;">See Appointment Status</p>
                        </div>
                        <div class="col-12 image-container">
                            <img alt="doctor image 2" src="img/bghostpit.png" class="img-fluid">
                        </div>
                    </div>
                </div>


            </div>
        </div>
    </body>
</html>
