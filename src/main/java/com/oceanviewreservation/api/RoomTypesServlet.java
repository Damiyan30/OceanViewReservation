package com.oceanviewreservation.api;

import com.oceanviewreservation.dao.RoomTypeDAO;
import com.oceanviewreservation.util.JsonUtil;
import java.io.IOException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/api/room-types")
public class RoomTypesServlet extends HttpServlet {

    private final RoomTypeDAO dao = new RoomTypeDAO();

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            JsonUtil.writeJson(resp, dao.findAll());
        } catch (Exception e) {
            JsonUtil.writeError(resp, 500, e.getMessage());
        }
    }
}