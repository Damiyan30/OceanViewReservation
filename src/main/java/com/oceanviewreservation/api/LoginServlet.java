package com.oceanviewreservation.api;

import com.oceanviewreservation.db.Db;
import com.oceanviewreservation.util.JsonUtil;
import java.io.IOException;
import java.sql.Connection;
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

    static class LoginRequest {
        String username;
        String password;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            LoginRequest body = JsonUtil.readJson(req, LoginRequest.class);

            if (body == null || body.username == null || body.password == null
                    || body.username.isBlank() || body.password.isBlank()) {
                JsonUtil.writeError(resp, 400, "Missing username or password");
                return;
            }

            String username = body.username.trim();

            try (Connection con = Db.getConnection();
                 PreparedStatement ps = con.prepareStatement(
                         "SELECT user_id, password_hash, role FROM users WHERE username = ?")) {

                ps.setString(1, username);

                try (ResultSet rs = ps.executeQuery()) {
                    if (!rs.next()) {
                        JsonUtil.writeError(resp, 401, "Invalid credentials");
                        return;
                    }

                    int userId = rs.getInt("user_id");
                    String hash = rs.getString("password_hash");
                    String role = rs.getString("role");

                    if (!BCrypt.checkpw(body.password, hash)) {
                        JsonUtil.writeError(resp, 401, "Invalid credentials");
                        return;
                    }

                    HttpSession session = req.getSession(true);
                    session.setAttribute("userId", userId);
                    session.setAttribute("username", username);
                    session.setAttribute("role", role);

                    JsonUtil.writeRawJson(resp, "{\"login\":\"ok\",\"role\":\"" + role + "\"}");
                }
            }

        } catch (Exception e) {
            JsonUtil.writeError(resp, 500, e.getClass().getSimpleName() + ": " + e.getMessage());
        }
    }
}