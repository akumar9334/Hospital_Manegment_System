<%@ page import="com.dao.DoctorDao" %>
<%@ page import="com.entity.Doctor" %>
<%@ page import="java.util.List" %>
<%@ page import="com.entity.Specialist" %>
<%@ page import="com.Db.DbConnect" %>
<%@ page import="com.dao.SpecialistDao" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<%@ page contentType="text/html" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <title>Add Doctor</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/js/bootstrap.min.js"></script>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css" rel="stylesheet">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <%@ include file="../css.jsp" %>
    <style type="text/css">
        body {
            background-image: url('../img/bghostpit.png'); /* Path to your image */
            background-color: #f0f0f0; /* Fallback background color */
            background-size: cover; /* Ensures the image covers the entire body */
            background-position: center center; /* Centers the image */
            background-attachment: fixed; /* Keeps the background fixed during scrolling */
            height: 100vh; /* Ensures the background covers the entire height of the page */
            margin: 0; /* Remove default margin */
            padding: 0; /* Remove default padding */
        }
        .paint-card {
            box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body>
    <%@ include file="navbar2.jsp" %>
    <div class="container-fluid p-3">
        <div class="row">
            <div class="col-md-5 offset-md-4">
                <div class="card paint-card">
                    <div class="card-body">
                        <p class="fs-3 text-center">Doctor Details form</p>
                        <c:if test="${not empty errorMsg}">
                            <p class="fs-3 text-center text-danger">${errorMsg}</p>
                            <c:remove var="errorMsg" scope="session" />
                        </c:if>
                        <c:if test="${not empty succMsg}">
                            <div class="fs-3 text-center text-success" role="alert">${succMsg}</div>
                            <c:remove var="succMsg" scope="session" />
                        </c:if>
                        <form action="../DoctorDetails" method="post">
                            <div class="mb-3">
                                <label class="form-label">Full Name</label>
                                <input type="text" required name="fullname" class="form-control">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">DOB</label>
                                <input type="date" required name="dob" class="form-control">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Qualification</label>
                                <input required name="qualification" type="text" class="form-control">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Specialist</label>
                                <select name="spec" required class="form-control">
                                    <option>--select--</option>
                                    <% SpecialistDao dao = new SpecialistDao(DbConnect.getConn());
                                        List<Specialist> list = dao.getAllSpecialist();
                                        for (Specialist s : list) {
                                    %>
                                    <option><%=s.getSpecialistName()%></option>
                                    <% } %>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Email</label>
                                <input type="email" required name="email" class="form-control">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Mob No</label>
                                <input type="text" required name="mobno" class="form-control">
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Password</label>
                                <input required name="password" type="password" class="form-control">
                            </div>

                            <div class="form-group mt-4">
                                <label for="countrySelect" class="form-label">Country</label>
                                <select name="country" class="form-select" id="countrySelect" onchange="loadStates()">
                                    <option selected>Select Country</option>
                                </select>
                            </div>

                            <div class="form-group mt-4">
                                <label for="stateSelect" class="form-label">State</label>
                                <select name="state" class="form-select" id="stateSelect" onchange="loadCities()" disabled>
                                    <option selected>Select State</option>
                                </select>
                            </div>

                            <div class="form-group mt-4">
                                <label for="citySelect" class="form-label">City</label>
                                <select name="city" class="form-select" id="citySelect" disabled>
                                    <option selected>Select City</option>
                                </select>
                            </div>

                            <div class="mb-3">
                                <label class="form-label">Hospital Name</label>
                                <input type="text" required name="hospital" class="form-control">
                            </div>

                            <button type="submit" class="btn btn-primary">Submit</button>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.6/dist/umd/popper.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js"></script>

    <script>
        $(document).ready(function () {
            loadCountries();
        });

        function loadCountries() {
            $.get("/mavenproject2/CountryStateCityServlet", {type: "countries"}, function (data) {
                if (data && !data.error) {
                    var countrySelect = $("#countrySelect");
                    countrySelect.empty();
                    countrySelect.append('<option selected>Select Country</option>');
                    $.each(data, function (index, country) {
                        countrySelect.append('<option value="' + country.iso2 + '">' + country.name + '</option>');
                    });
                } else {
                    alert('Error loading countries');
                }
            }).fail(function () {
                alert('Error loading countries');
            });
        }

        function loadStates() {
            var countryCode = $("#countrySelect").val();
            if (countryCode) {
                $.get("/mavenproject2/CountryStateCityServlet", {type: "states", code: countryCode}, function (data) {
                    var stateSelect = $("#stateSelect");
                    stateSelect.empty();
                    stateSelect.append('<option selected>Select State</option>');
                    $.each(data, function (index, state) {
                        stateSelect.append('<option value="' + state.iso2 + '">' + state.name + '</option>');
                    });
                    stateSelect.prop('disabled', false);
                }).fail(function () {
                    alert('Error loading states');
                });
            } else {
                alert('Please select a country first.');
            }
        }

        function loadCities() {
            var countryCode = $("#countrySelect").val();
            var stateCode = $("#stateSelect").val();
            
            if (countryCode && stateCode) {
                $.get("/mavenproject2/CountryStateCityServlet", { type: "cities", countryCode: countryCode, code: stateCode }, function (data) {
                    var citySelect = $("#citySelect");
                    citySelect.empty();
                    citySelect.append('<option selected>Select City</option>');
                     console.log("Cities Data: ", data);
                    
                    // Check if we get valid city data
                    if (data && Array.isArray(data) && data.length > 0) {
                        // Iterate over city data and add to select options
                        $.each(data, function (index, city) {
                            // Adding option to the dropdown
                          citySelect.append('<option value="' + city.name + '">' + city.name + '</option>');

                        });
                        citySelect.prop('disabled', false);
                    } else {
                        alert('No cities found for selected state.');
                        citySelect.prop('disabled', true);
                    }
                }).fail(function () {
                    alert('Error loading cities');
                });
            } else {
                alert('Please select both country and state.');
            }
        }
    </script>
</body>
</html>
