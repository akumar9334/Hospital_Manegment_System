<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@page isELIgnored="false"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Country, State, City Selection</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-EVSTQN3/azprG1Anm3QDgpJLIm9Nao0Yz1ztcQTwFspd3yD65VohhpuuCOmLASjC" crossorigin="anonymous">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <%@include file="../css.jsp"%>
  <style type="text/css">
        .paint-card {
            box-shadow: 0 0 10px 0 rgba(0, 0, 0, 0.3);
        }
    </style>
</head>
<body>
    <%@ include file="navbar.jsp"%>
    <div class="container-fluid p-3">
        <div class="row">
            <!-- Left Column (Form) -->
            <div class="col-md-6 offset-md-3">
                <div class="card paint-card">
                    <div class="card-body">
                        <p class="fs-3 text-center">Add Hospital by Area</p>

                        <!-- Country Dropdown -->
                        <div class="form-group mt-4">
                            <label for="countrySelect" class="form-label">Country</label>
                            <select class="form-select" id="countrySelect" onchange="loadStates()">
                                <option selected>Select Country</option>
                            </select>
                        </div>

                        <!-- State Dropdown -->
                        <div class="form-group mt-4">
                            <label for="stateSelect" class="form-label">State</label>
                            <select class="form-select" id="stateSelect" onchange="loadCities()" disabled>
                                <option selected>Select State</option>
                            </select>
                        </div>

                        <!-- City Dropdown -->
                        <div class="form-group mt-4">
                            <label for="citySelect" class="form-label">City</label>
                            <select class="form-select" id="citySelect" disabled>
                                <option selected>Select City</option>
                            </select>
                        </div>

                        <!-- Hospital Name -->
                            <div class="form-group mt-4">
                            <label for="hospitalSelect" class="form-label">Select Hospital</label>
                            <select id="hospitalSelect" name="hospital_id" class="form-control" required>
                                <option value="">Select Hospital</option>
                                <!-- The options will be populated dynamically based on district -->
                            </select>
                        </div>

                        <!-- Doctor Name -->
                        <div class="form-group mt-4">
                            <label for="doctorName" class="form-label">Doctor Name</label>
                            <input type="text" id="doctorName" class="form-control" placeholder="Enter Doctor Name">
                        </div>

                        <!-- Submit Button -->
                        <button type="submit" class="btn btn-primary mt-4">Submit</button>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <script>
        // Load countries on page load
        $(document).ready(function() {
            loadCountries();
        });

        // Function to load countries from servlet
        function loadCountries() {
            $.get("/mavenproject2/CountryStateCityServlet", { type: "countries" }, function(data) {
                if (data && !data.error) {
                    var countrySelect = $("#countrySelect");
                    countrySelect.empty();
                    countrySelect.append('<option selected>Select Country</option>');
                    $.each(data, function(index, country) {
                        countrySelect.append('<option value="' + country.iso2 + '">' + country.name + '</option>');
                    });
                }
            }).fail(function() {
                alert('Error loading countries');
            });
        }

        // Function to load states based on selected country
        function loadStates() {
            var countryCode = $("#countrySelect").val();
            if (countryCode) {
                $.get("/mavenproject2/CountryStateCityServlet", { type: "states", code: countryCode }, function(data) {
                    var stateSelect = $("#stateSelect");
                    stateSelect.empty();
                    stateSelect.append('<option selected>Select State</option>');
                    $.each(data, function(index, state) {
                        stateSelect.append('<option value="' + state.iso2 + '">' + state.name + '</option>');
                    });
                    stateSelect.prop('disabled', false);
                }).fail(function() {
                    alert('Error loading states');
                });
            }
        }

        // Function to load cities based on selected state
        function loadCities() {
            var countryCode = $("#countrySelect").val();
            var stateCode = $("#stateSelect").val();
            if (stateCode) {
                $.get("/mavenproject2/CountryStateCityServlet", { type: "cities", countryCode: countryCode, code: stateCode }, function(data) {
                    var citySelect = $("#citySelect");
                    citySelect.empty();
                    citySelect.append('<option selected>Select City</option>');
                    $.each(data, function(index, city) {
                        citySelect.append('<option value="' + city.iso2 + '">' + city.name + '</option>');
                    });
                    citySelect.prop('disabled', false);
                }).fail(function() {
                    alert('Error loading cities');
                });
            }
        }
    </script>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.2/dist/js/bootstrap.bundle.min.js" integrity="sha384-MrcW6ZMFYlzcLA8Nl+NtUVF0sA7MsXsP1UyJoMp4YLEuNSfAP+JcXn/tWtIaxVXM" crossorigin="anonymous"></script>
</body>

</html>
