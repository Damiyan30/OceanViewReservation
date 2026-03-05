package com.oceanviewreservation.api;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/api/dbtest")
public class DbTestServlet extends HttpServlet {

    private static final String URL =
        "jdbc:mysql://localhost:3306/oceanviewreservation_db"
        + "?allowPublicKeyRetrieval=true"
        + "&useSSL=false"
        + "&serverTimezone=UTC";

    private static final String USER = "oceanview_user";
    private static final String PASS = "OceanView@123";

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            // Force-load MySQL JDBC driver (helps avoid "No suitable driver found")
            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection con = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = con.prepareStatement("SELECT 1");
                 ResultSet rs = ps.executeQuery()) {

                rs.next();
                int val = rs.getInt(1);
                resp.getWriter().write("{\"db\":\"ok\",\"select1\":" + val + "}");
            }

        } catch (Exception e) {
            resp.setStatus(500);

            String msg = e.getClass().getSimpleName() + ": " + e.getMessage();
            msg = msg == null ? "unknown error" : msg.replace("\"", "'");

            // This message is VERY useful: if it says ClassNotFoundException,
            // then mysql-connector-j is NOT reaching Tomcat runtime.
            resp.getWriter().write("{\"db\":\"fail\",\"error\":\"" + msg + "\"}");
        }
    }
}