package com.oceanviewreservation.api;

import com.google.gson.Gson;
import com.oceanviewreservation.dao.RoomTypeDAO;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/api/room-types")
public class RoomTypesServlet extends HttpServlet {

    private static final Gson gson = new Gson();
    private final RoomTypeDAO dao = new RoomTypeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try {
            resp.getWriter().write(gson.toJson(dao.findAll()));
        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write("{\"error\":\"" + (e.getMessage() + "").replace("\"", "'") + "\"}");
        }
    }
}