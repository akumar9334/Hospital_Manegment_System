<%@page contentType="text/html" pageEncoding="UTF-8"%>
 
<%--<%@page isELIgnored="false"%>--%>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Signup Page</title>
        <%@include file="css.jsp" %>
    </head>
    <body>
        <%@include file="navbar.jsp" %>
        
        
         <% 
        String errorMsg = (String) session.getAttribute("errorMsg");
        if (errorMsg != null) { 
    %>
        <div class="error"><%= errorMsg %></div>
    <% 
        }
        session.removeAttribute("errorMsg"); // Clear the message after it's displayed
    %>

        <div class="container p-5">
            <div class="row">
                <div class="col-md-4 offset-md-4">
                    <div class="card paint-card">
                        <div class="card-body">
                            <p class="fs-4 text-center">User Register</p>

                            <!-- Success Message -->
                            <c:if test="${not empty sucMsg}">
                                <div class="success-message text-center text-success fs-3">${sucMsg}</div>
                                <c:remove var="sucMsg" scope="session" />
                            </c:if>

                            <!-- Error Message -->
                            <c:if test="${not empty errorMsg}">
                                <div class="error-message text-center text-danger fs-3">${errorMsg}</div>
                                <c:remove var="errorMsg" scope="session" />
                            </c:if>

                            <!-- Registration Form -->
                            <form action="register" method="post">
                                <div class="mb-3">
                                    <label class="form-label">Full Name</label>
                                    <input required name="fullname" type="text" class="form-control">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Email address</label>
                                    <input required name="email" type="email" class="form-control">
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Password</label>
                                    <input required name="password" type="password" class="form-control">
                                </div>
                                <button type="submit" class="btn bg-success text-white col-md-12">Register</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </body>
</html>
