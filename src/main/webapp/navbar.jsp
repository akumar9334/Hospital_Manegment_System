<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <style>
        * Custom style to narrow down the navbar *
        /*.navbar {
            max-width: 100%;  Set a specific maximum width 
            margin-left: auto;   Center the navbar 
            margin-right: auto;  Center the navbar 
        }
        
         Alternatively, reduce the padding inside navbar 
        .navbar-nav {
            padding-left: 20px;
            padding-right: 20px;
        }*/

    </style>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <!-- Bootstrap CSS -->
        <!-- Bootstrap 5 CSS (in the head section) -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

        <!-- FontAwesome for icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-success">
            <div class="container-fluid">
                <a class="navbar-brand" href="index.jsp"><i
                        class="fas fa-clinic-medical"></i> MEDI HOME</a>
                <button class="navbar-toggler" type="button" data-bs-toggle="collapse" 
                        data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="navbar-toggler-icon"></span>
                </button>
                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav ms-auto mb-2 mb-lg-0">
                        <li class="nav-item">
                            <c:if test="${ empty userObj}">

                            <li class="nav-item"><a class="nav-link active"
                                                    aria-current="page" href="Admin_login.jsp"><i
                                        class="fas fa-sign-in-alt"></i> ADMIN</a></li>



                            <li class="nav-item"><a class="nav-link active"
                                                    aria-current="page" href="Doctor_login.jsp">DOCTOR</a></li>


                            <li class="nav-item"><a class="nav-link active"
                                                    aria-current="page" href="user_login.jsp">APPOINTMENT</a></li>



                            <li class="nav-item"><a class="nav-link active"
                                                    aria-current="page" href="user_login.jsp">USER</a></li> 


                        </c:if>


                        <c:if test="${not empty userObj}">
                            <li class="nav-item"><a class="nav-link active"
                                                    aria-current="page" href="UserAppointment.jsp">APPOINTMENT</a></li>

                            <li class="nav-item"><a class="nav-link active"
                                                    aria-current="page" href="view_appointment.jsp">VIEW APPOINTMENT</a></li>

                            <div class="dropdown">
                                <button class="btn btn-success dropdown-toggle" type="button" id="dropdownMenuButton1" data-bs-toggle="dropdown" aria-expanded="false">
                                    <i class="fa-solid fa-circle-user"></i> ${userObj.fullName}
                                </button>
                                <ul class="dropdown-menu" aria-labelledby="dropdownMenuButton1">
                                    <li><a class="dropdown-item" href="changepassword.jsp">change password</a></li>
                                    <li><a class="dropdown-item" href="userlogout">Logout</a></li>

                                </ul>
                            </div>

                        </c:if>

                       



                    </ul>

                </div>
            </div>
        </nav>
        <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    </body>

</html>
