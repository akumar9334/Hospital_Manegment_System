<%-- 
    Document   : Admin
    Created on : Dec 6, 2024, 3:16:19 PM
    Author     : kumar
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>admin page</title>
        <%@include file="css.jsp" %>
        <style type="text/css">
            .paint-card {
                box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
            }
        </style>
        
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        <div class="container p-5">
            <div class="row">
                <div class="col-md-4 offset-md-4">
                    <div class="card paint-card">
                        <div class="card-body">
                            <p class="fs-4 text-center">admin Login</p>
                            

                            <c:if test="${ not empty succMsg }">
                                <p class="text-center text-success fs-3">${succMsg}</p>
                                <c:remove var="succMsg" scope="session" />
                            </c:if>

                            <c:if test="${not empty errorMsg }">
                                <p class="text-center text-danger fs-5">${errorMsg}</p>
                                <c:remove var="errorMsg" scope="session" />
                            </c:if>

                            <form action="adminlogin" method="post">
                                <div class="mb-3">
                                    <label class="form-label">Email address</label> <input required
                                                                                           name="email" type="email" class="form-control">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Password</label> <input required
                                                                                      name="password" type="password" class="form-control">
                                </div>
                                <button type="submit" class="btn bg-success text-white col-md-12">Login</button>
                            </form>

                        </div>
                    </div>
                </div>
            </div>
        </div>
              
                                
                                  <script type="text/javascript">
            <%
          
                if (session != null) {
                    // Check if the login was successful
                    if (session.getAttribute("logoutSuccess") != null) {
            %>
                        alert("LogOut Successful!");
            <%
                        session.removeAttribute("logoutSuccess"); // Remove the success message after showing
                    }

                    // Check if there's an error message
                    if (session.getAttribute("errorMsg") != null) {
            %>
                        alert("<%= session.getAttribute("errorMsg") %>");
            <%
                        session.removeAttribute("errorMsg"); // Remove the error message after showing
                    }
                }
            %>
        </script>      
                                
                                
    </body>
</html>
