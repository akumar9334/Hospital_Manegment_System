<%@ page import="com.Db.DbConnect" %>
<%@ page import="com.dao.DoctorDao" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Admin Page</title>
    <%@ include file="../css.jsp" %>
    <!-- SweetAlert2 CDN -->
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/sweetalert2@11"></script> <!-- SweetAlert2 -->

    <style type="text/css">
        .paint-card {
            box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
        }
        .icon-shadow {
            box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp" %>

    <div class="container p-5">
        <p class="text-center fs-3">Admin Dashboard</p>

        <!-- Check if the admin session is empty and redirect if true -->
        <c:if test="${empty adminObj}">
            <c:redirect url="../admin_login.jsp" />
        </c:if>

        <!-- Error and Success messages -->
        <c:if test="${not empty errorMsg}">
            <p class="fs-3 text-center text-danger">${errorMsg}</p>
            <c:remove var="errorMsg" scope="session" />
        </c:if>

        <c:if test="${not empty succMsg}">
            <div class="fs-3 text-center text-success" role="alert">${succMsg}</div>
            <c:remove var="succMsg" scope="session" />
        </c:if>

        <c:if test="${not empty succMsg1}">
            <div class="fs-3 text-center text-success" role="alert">${succMsg1}</div>
            <c:remove var="succMsg1" scope="session" />
        </c:if>

        <% DoctorDao dao = new DoctorDao(DbConnect.getConn()); %>

        <div class="row">
            <div class="col-md-4">
                <div class="card paint-card">
                    <div class="card-body text-center text-success">
                        <i class="fas fa-user-md fa-3x"></i><br>
                        <p class="fs-4 text-center">Doctor <br><%= dao.countDoctor() %></p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card paint-card">
                    <div class="card-body text-center text-success">
                        <i class="fas fa-user-circle fa-3x"></i><br>
                        <p class="fs-4 text-center">User <br><%= dao.countuser() %></p>
                    </div>
                </div>
            </div>

            <div class="col-md-4">
                <div class="card paint-card">
                    <div class="card-body text-center text-success">
                        <i class="far fa-calendar-check fa-3x"></i><br>
                        <p class="fs-4 text-center">Total Appointment <br><%= dao.countAppointment() %></p>
                    </div>
                </div>
            </div>

            <div class="col-md-4 mt-2">
                <div class="card paint-card" data-bs-toggle="modal" data-bs-target="#exampleModal">
                    <div class="card-body text-center text-success">
                        <i class="far fa-calendar-check fa-3x"></i><br>
                        <p class="fs-4 text-center">Specialist <br><%= dao.countspecialist() %></p>
                    </div>
                </div>
            </div>

            <div class="col-md-4" style="margin-top: 20px;">
                <div class="card paint-card">
                    <div class="card-body text-center text-success">
                        <!-- Hyperlink to open the JSP form -->
                        <a href="addhospitalbyArea.jsp" style="text-decoration: none">
                            <i class="fas fa-plus-circle fa-3x"></i><br> <!-- Plus circle for adding -->
                            <p class="fs-4 text-center">Add Hospital by Area <br></p>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </div>

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

    <script type="text/javascript">
        $(document).ready(function () {
            // Show SweetAlert2 based on session attributes
            <% 
                if (session != null) {
                    if (session.getAttribute("loginSuccess") != null) { 
            %>
            Swal.fire({
                title: 'Success!',
                text: 'Login Successful!',
                icon: 'success',
                confirmButtonText: 'OK',
                confirmButtonColor: '#28a745'
            });
            <%
                session.removeAttribute("loginSuccess");
                }

                if (session.getAttribute("errorMsg") != null) {
            %>
            Swal.fire({
                title: 'Error!',
                text: '<%= session.getAttribute("errorMsg") %>',
                icon: 'error',
                confirmButtonText: 'OK',
                confirmButtonColor: '#dc3545'
                allowOutsideClick: false, // Prevent closing by clicking outside
                allowEscapeKey: false  
            });
            <%
                session.removeAttribute("errorMsg");
                }
            }
            %>

            // Form validation for Specialist Name
            $("#specialistForm").on("submit", function (event) {
                var specName = $("#specName").val().trim();

                if (specName === "") {
                    event.preventDefault();

                    Swal.fire({
                        title: 'Warning!',
                        text: 'Please enter a Specialist Name.',
                        icon: 'warning',
                        confirmButtonText: 'OK',
                        confirmButtonColor: '#ffc107'
                         allowOutsideClick: false, // Prevent closing by clicking outside
                             allowEscapeKey: false  
                    });

                    $("#specName").css("border-color", "red");
                } else {
                    $("#specName").css("border-color", "");
                }
            });
        });
    </script>

    <div class="container-fluid p-2 bg-success text-center text-white" style="margin-top: 100%">
        <p>&copy; hospital.com</p>
    </div>
</body>
</html>
