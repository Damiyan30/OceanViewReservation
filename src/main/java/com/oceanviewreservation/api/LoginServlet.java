package com.oceanviewreservation.api;

import com.google.gson.Gson;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import org.mindrot.jbcrypt.BCrypt;

@WebServlet("/api/login")
public class LoginServlet extends HttpServlet {

    private static final String URL =
        "jdbc:mysql://localhost:3306/oceanviewreservation_db?allowPublicKeyRetrieval=true&useSSL=false&serverTimezone=UTC";
    private static final String USER = "oceanview_user";
    private static final String PASS = "OceanView@123";

    private static final Gson gson = new Gson();

    static class LoginRequest {
        String username;
        String password;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        LoginRequest body;
        try (BufferedReader reader = req.getReader()) {
            body = gson.fromJson(reader, LoginRequest.class);
        }

        if (body == null || body.username == null || body.password == null
                || body.username.isBlank() || body.password.isBlank()) {
            resp.setStatus(400);
            resp.getWriter().write("{\"login\":\"fail\",\"error\":\"Missing username or password\"}");
            return;
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");

            String sql = "SELECT user_id, password_hash, role FROM users WHERE username = ?";
            try (Connection con = DriverManager.getConnection(URL, USER, PASS);
                 PreparedStatement ps = con.prepareStatement(sql)) {

                ps.setString(1, body.username.trim());
                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        resp.setStatus(401);
                        resp.getWriter().write("{\"login\":\"fail\",\"error\":\"Invalid credentials\"}");
                        return;
                    }

                    int userId = rs.getInt("user_id");
                    String hash = rs.getString("password_hash");
                    String role = rs.getString("role");

                    if (!BCrypt.checkpw(body.password, hash)) {
                        resp.setStatus(401);
                        resp.getWriter().write("{\"login\":\"fail\",\"error\":\"Invalid credentials\"}");
                        return;
                    }

                    HttpSession session = req.getSession(true);
                    session.setAttribute("userId", userId);
                    session.setAttribute("username", body.username.trim());
                    session.setAttribute("role", role);

                    resp.getWriter().write("{\"login\":\"ok\",\"role\":\"" + role + "\"}");
                }
            }

        } catch (Exception e) {
            resp.setStatus(500);
            String msg = (e.getClass().getSimpleName() + ": " + e.getMessage()).replace("\"", "'");
            resp.getWriter().write("{\"login\":\"fail\",\"error\":\"" + msg + "\"}");
        }
    }
}