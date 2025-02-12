<%-- 
    Document   : user_login
    Created on : Dec 6, 2024, 3:17:52 PM
    Author     : kumar
--%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
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
                            <p class="fs-4 text-center">user Login</p>

                            <c:if test="${not empty sessionScope.errorMsg}">
                                <p style="color: red;">${sessionScope.errorMsg}</p>
                                <c:remove var="errorMsg" />
                            </c:if>
                                
                                

                            <form action="userlogin" method="post">
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
                            <br> Don't have an account? <a href="signup.jsp"
                                                           class="text-decoration-none"> create one</a>

                        </div>
                    </div>
                </div>
            </div>
        </div>


        <script type="text/javascript">
            <%

                if (session != null) {
                    // Check if the login was successful
                    if (session.getAttribute("userlogoutSuccess") != null) {
            %>
             alert("userLogout Successful!");
            <%
                    session.removeAttribute("userlogoutSuccess"); // Remove the success message after showing
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
    </body>
</html>
