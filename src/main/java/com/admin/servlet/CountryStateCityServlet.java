package com.admin.servlet;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.*;
import java.net.*;
import org.json.JSONArray;
import org.json.JSONObject;

@WebServlet("/CountryStateCityServlet") // Servlet is mapped automatically with this annotation
public class CountryStateCityServlet extends HttpServlet {

    private static final String API_KEY = "M04ya2xXcUh5ZEVvM0dpOUcwTFlDWjY3dXlIcDBwWmNCV3Y3NlV6aQ==";
    private static final String BASE_URL = "https://api.countrystatecity.in/v1";

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String type = request.getParameter("type");
        String code = request.getParameter("code");

        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        // Construct the API URL based on the request type (countries, states, cities)
        String apiUrl = "";

        if ("countries".equals(type)) {
            apiUrl = BASE_URL + "/countries";
        } else if ("states".equals(type)) {
            apiUrl = BASE_URL + "/countries/" + code + "/states";
        } else if ("cities".equals(type)) {
            String countryCode = request.getParameter("countryCode");
            apiUrl = BASE_URL + "/countries/" + countryCode + "/states/" + code + "/cities";
        }

        // Call the API and get the response
        try {
            URL url = new URL(apiUrl);
            HttpURLConnection connection = (HttpURLConnection) url.openConnection();
            connection.setRequestProperty("X-CSCAPI-KEY", API_KEY);
            connection.setRequestMethod("GET");

            BufferedReader in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
            String inputLine;
            StringBuilder responseContent = new StringBuilder();
            while ((inputLine = in.readLine()) != null) {
                responseContent.append(inputLine);
            }
            in.close();

            // Output the API response
            out.write(responseContent.toString());
        } catch (Exception e) {
            e.printStackTrace();
            out.write("{\"error\":\"API call failed\"}");
        }
    }
}
