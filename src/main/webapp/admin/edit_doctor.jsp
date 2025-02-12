<%@page import="java.util.List"%>
<%@page import="com.dao.DoctorDao"%>
<%@page import="com.entity.Doctor"%>
<%@page import="com.Db.DbConnect"%>
<%@page import="com.dao.SpecialistDao"%>
<%@page import="com.entity.Specialist"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="ISO-8859-1">
        <title>Edit Doctor</title>
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    </head>
    <body>
        <%@include file="navbar.jsp"%>

        <div class="container p-3">
            <div class="row">
                <div class="col-md-6 offset-md-3">
                    <div class="card">
                        <div class="card-body">
                            <p class="fs-3 text-center">Edit Doctor Details</p>

                            <%
                                // Get the doctor ID from the request parameter
                                String idStr = request.getParameter("id");

                                if (idStr == null || idStr.isEmpty()) {
                                    // ID is missing or invalid
                                    out.println("<p class='text-danger'>ID is missing. Please try again.</p>");
                                } else {
                                    try {
                                        int id = Integer.parseInt(idStr); // Parse the ID as an integer
                                        DoctorDao dao = new DoctorDao(DbConnect.getConn());
                                        Doctor d = dao.getDoctorbyId(id); // Retrieve doctor by ID

                                        if (d != null) {
                                            // Populate form with doctor's current details
                            %>

                            <form action="../updateDoctor" method="post">
                                <div class="mb-3">
                                    <label class="form-label">Full Name</label>
                                    <input type="text" name="fullname" class="form-control" value="<%= d.getFullName()%>" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">DOB</label>
                                    <input type="date" name="dob" class="form-control" value="<%= d.getDob()%>" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Qualification</label>
                                    <input type="text" name="qualification" class="form-control" value="<%= d.getQualification()%>" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Specialist</label>
                                    <select name="specialist" class="form-control" required>
                                        <option value="">-- Select Specialist --</option> <!-- Default option when no specialist is selected -->
                                        <%
                                            // Initialize the SpecialistDao to fetch all specialists
                                            SpecialistDao specDao = new SpecialistDao(DbConnect.getConn());
                                            List<Specialist> specialistList = specDao.getAllSpecialist();

                                            // Check if the list is not empty
                                            if (specialistList != null && !specialistList.isEmpty()) {
                                                // Loop through all the specialists and create options
                                                for (Specialist s : specialistList) {
                                                    // Check if the current specialist matches the doctor's specialist
                                                    boolean isSelected = s.getSpecialistName().equals(d.getSpecialist());
                                        %>
                                        <option value="<%= s.getSpecialistName()%>" 
                                                <%= isSelected ? "selected" : ""%>>  <!-- Set selected if it matches -->
                                            <%= s.getSpecialistName()%>
                                        </option>
                                        <%
                                                }
                                            } else {
                                                // In case there are no specialists in the list
                                                out.println("<p>No specialists available.</p>");
                                            }
                                        %>
                                    </select>
                                </div>


                                <div class="mb-3">
                                    <label class="form-label">Email</label>
                                    <input type="email" name="email" class="form-control" value="<%= d.getEmail()%>" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Mob No</label>
                                    <input type="text" name="mobno" class="form-control" value="<%= d.getMobNo()%>" required>
                                </div>
                                <div class="mb-3">
                                    <label class="form-label">Password</label>
                                    <input type="text" name="password" class="form-control" value="<%= d.getPassword()%>" required>
                                </div>
                                <input type="hidden" name="id" value="<%=d.getId()%>">

                                <button type="submit" class="btn btn-primary">Update</button>
                            </form>

                            <%
                                        } else {
                                            // Doctor not found in the database
                                            out.println("<p class='text-danger'>Doctor not found.</p>");
                                        }
                                    } catch (NumberFormatException e) {
                                        // Handle case where ID is invalid
                                        out.println("<p class='text-danger'>Invalid doctor ID.</p>");
                                    }
                                }
                            %>

                        </div>
                    </div>
                </div>
            </div>
        </div>

    </body>
</html>
