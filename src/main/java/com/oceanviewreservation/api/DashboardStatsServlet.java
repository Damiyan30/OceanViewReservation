package com.oceanviewreservation.api;

import com.oceanviewreservation.dao.ReservationDAO;
import com.oceanviewreservation.model.Reservation;
import com.oceanviewreservation.service.ReservationService;
import com.oceanviewreservation.util.JsonUtil;
import java.io.IOException;
import java.time.LocalDate;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/api/dashboard/stats")
public class DashboardStatsServlet extends HttpServlet {

    private final ReservationService service = new ReservationService();

    static class DashboardResponse {
        String today;
        int totalReservations;
        int todayCheckIns;
        int todayCheckOuts;
        int activeStays;
        List<Reservation> recentReservations;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            ReservationDAO.DashboardStats stats = service.getDashboardStats();

            DashboardResponse response = new DashboardResponse();
            response.today = LocalDate.now().toString();
            response.totalReservations = stats.totalReservations;
            response.todayCheckIns = stats.todayCheckIns;
            response.todayCheckOuts = stats.todayCheckOuts;
            response.activeStays = stats.activeStays;
            response.recentReservations = service.getRecentReservations(5);

            JsonUtil.writeJson(resp, response);
        } catch (Exception e) {
            JsonUtil.writeError(resp, 500, e.getMessage());
        }
    }
}