<%-- 
    Document   : index
    Created on : Dec 6, 2024, 2:58:13 PM
    Author     : kumar
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false"%>
<%@page import="java.sql.Connection"%>
<%@page import="com.Db.DbConnect"%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
                <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">


        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>

        <!-- FontAwesome for icons -->
        <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
        <%@include file="css.jsp" %>
        <style type="text/css">
            .paint-card {
                box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
            }
        </style>

    </head>
    <body>
        <%@include file="navbar.jsp" %>


        <%
            Connection conn = DbConnect.getConn();
            if (conn != null) {
               
            } else {
                out.print("Connection failed.");
            }
        %>


            
        
        <div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="1" aria-label="Slide 2"></button>
                <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="2" aria-label="Slide 3"></button>
            </div>



            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="img/host1.jpg" class="d-block w-100" alt="..."height="500px">
                </div>
                <div class="carousel-item">
                    <img src="img/host2.jpg" class="d-block w-100" alt="..."height="500px">
                </div>
                <div class="carousel-item">
                    <img src="img/host3.jpg" class="d-block w-100" alt="..."height="500px">
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon" aria-hidden="true"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>
        <div class="container p-3">
            <p class="text-center fs-2 ">Key Features of our Hospital</p>

            <div class="row">
                <div class="col-md-8 p-5">
                    <div class="row">
                        <div class="col-md-6">
                            <div class="card paint-card">
                                <div class="card-body">
                                    <p class="fs-5">100% Safety</p>
                                    <p>We ensure complete protection and security for you. Our team works hard to keep everything safe and secure.
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6">
                            <div class="card paint-card">
                                <div class="card-body">
                                    <p class="fs-5">Clean Environment</p>
                                    <p>We make sure the environment is clean and safe for everyone. 
                                        Our team works to keep everything tidy and well-maintained</p>
                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mt-2">
                            <div class="card paint-card">
                                <div class="card-body">
                                    <p class="fs-5">Friendly Doctors</p>
                                    <p>Loluptatem, inventoreorem ipsum dolor sit amet, consectetur adipisicing elit.</p>

                                </div>
                            </div>
                        </div>
                        <div class="col-md-6 mt-2">
                            <div class="card paint-card">
                                <div class="card-body">
                                    <p class="fs-5">Medical Research</p>
                                    <p>Lorem ipsum dolor sit amet, consectetur adipisicing elit.
                                        Voluptatem, inventore</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="col-md-4">
                    <img alt="Doctor Image" src="img/doct6.png" style="width: 100%; height: 75%;margin-top:25px";">
                </div>


            </div>
        </div>

        <hr>

        <div class="container p-2">
            <p class="text-center fs-2 ">Our Team</p>

            <div class="row">
                <div class="col-md-3">
                    <div class="card paint-card">
                        <div class="card-body text-center">
                            <img src="img/doct1.jpg" width="250px" height="300px">
                            <p class="fw-bold fs-5">Dr.Vikram shing</p>
                            <p class="fs-7">(CEO & Chairman)</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card paint-card">
                        <div class="card-body text-center">
                            <img src="img/doct2.jpg" width="250px" height="300px">
                            <p class="fw-bold fs-5">Dr.Sivani Kumari</p>
                            <p class="fs-7">(Chief Doctor)</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card paint-card">
                        <div class="card-body text-center">
                            <img src="img/doct3.jpg" width="250px" height="300px">
                            <p class="fw-bold fs-5">Dr. Niuise Paule</p>
                            <p class="fs-7">(Chief Doctor)</p>
                        </div>
                    </div>
                </div>

                <div class="col-md-3">
                    <div class="card paint-card">
                        <div class="card-body text-center">
                            <img src="img/doct4.jpg" width="250px" height="300px">
                            <p class="fw-bold fs-5">Dr. Mathue Samuel</p>
                            <p class="fs-7">(Chief Doctor)</p>
                        </div>
                    </div>
                </div>

            </div>

        </div>
        
        <script type="text/javascript">
            <%

                if (session != null) {
                    // Check if the login was successful
                    if (session.getAttribute("userloginSuccess") != null) {
            %>
             alert("user login Successful!");
            <%
                    session.removeAttribute("userloginSuccess"); // Remove the success message after showing
                }

                // Check if there's an error message
                if (session.getAttribute("errorMsg") != null) {
            %>
             alert("<%= session.getAttribute("errorMsg")%>");
            <%
                        session.removeAttribute("errorMsg"); // Remove the error message after showing
                    }
                }
            %>
        </script>      


         <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
        <%@include file="footer.jsp" %>
    </body>
</html>
