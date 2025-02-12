<%-- 
    Document   : index
    Created on : Dec 15, 2024, 1:34:18 PM
    Author     : kumar
--%>
<%@page import="com.mysql.cj.Session"%>
<%@page import="com.entity.Doctor"%>
<%@page import="com.dao.DoctorDao"%>
<%@page import="com.Db.DbConnect"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="com.doctor.servlet.DoctorLogin"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <style type="text/css">
            .paint-card {
                box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
            }
        </style>
        <%@include file="../css.jsp" %>
    </head>
    <body>

        <%@ include file="navbar.jsp" %>
        
          <c:if test="${empty doctObj}">
                <c:redirect url="../Doctor_login.jsp" />
            </c:if>

        <div class="container p-5">
            <p class="text-center fs-3">Doctor Dashboard</p>
            <!-- Check if the admin session is empty and redirect if true -->


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

            <c:if test="${not empty succMsg1}">
                <div class="fs-3 text-center text-success" role="alert">${succMsg1}</div>
                <c:remove var="succMsg1" scope="session" />
            </c:if>
                <% 
                    Doctor d = (Doctor)session.getAttribute("doctObj");
                     DoctorDao dao = new DoctorDao(DbConnect.getConn());%>
         
               
            <div class="row">
                <div class="col-md-4">
                    <div class="card paint-card">
                        <div class="card-body text-center text-success">
                            <i class="fas fa-user-md fa-3x"></i><br>
                            <p class="fs-4 text-center">Doctor <br><%=dao.countDoctor()%></p>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <div class="card paint-card">
                        <div class="card-body text-center text-success">
                            <i class="far fa-calendar-check fa-3x"></i><br>
                            <p class="fs-4 text-center">Total Appointment <br><%=dao.countAppointmentByDoctorId(d.getId())%></p>
                        </div>
                    </div>
                </div>


                <div class="col-md-4 mt-2">
                    <div class="card paint-card" data-bs-toggle="modal" data-bs-target="#exampleModal"">
                        <div class="card-body text-center text-success">
                            <i class="far fa-calendar-check fa-3x"></i><br>
                            <p class="fs-4 text-center">Specialist <br><%=dao.countspecialist()%></p>
                        </div>
                    </div>
                </div>
            </div>
        </div>         
        <!--// this both are same  below modal bhi boton for spelist  pop--> 
        <!-- Modal -->
        <div class="modal fade" id="exampleModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
            <div class="modal-dialog">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="exampleModalLabel">Modal title</h5>
                        <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
                    </div>
                    <div class="modal-body">
                        <form action="../addSpecialist" method="post" id="specialistForm">
                            <div class="form-group">
                                <label>Enter Specialist Name</label>
                                <input type="text" name="specName" id="specName" class="form-control">
                            </div>
                            <div class="text-center mt-3">
                                <button type="submit" class="btn btn-primary">Add</button>
                            </div>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>

                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
