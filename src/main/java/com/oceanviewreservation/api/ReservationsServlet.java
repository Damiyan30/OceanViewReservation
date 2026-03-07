package com.oceanviewreservation.api;

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

@WebServlet("/api/reservations")
public class ReservationsServlet extends HttpServlet {

    private final ReservationService service = new ReservationService();

    static class ReservationRequest {
        Integer reservationId;
        String guestName;
        String contactNo;
        String email;
        String address;
        Integer typeId;
        String checkIn;
        String checkOut;
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            ReservationRequest body = JsonUtil.readJson(req, ReservationRequest.class);
            Reservation reservation = toReservation(body, false);
            int id = service.addReservation(reservation);
            JsonUtil.writeRawJson(resp, "{\"create\":\"ok\",\"reservationId\":" + id + "}");
        } catch (IllegalArgumentException ex) {
            resp.setStatus(400);
            JsonUtil.writeRawJson(resp, "{\"create\":\"fail\",\"error\":\"" + safe(ex.getMessage()) + "\"}");
        } catch (Exception e) {
            resp.setStatus(500);
            JsonUtil.writeRawJson(resp, "{\"create\":\"fail\",\"error\":\"" + safe(e.getMessage()) + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");

        try {
            if (idStr == null || idStr.isBlank()) {
                List<Reservation> reservations = service.getAllReservations();
                JsonUtil.writeJson(resp, reservations);
                return;
            }

            int id = Integer.parseInt(idStr);
            Reservation reservation = service.getReservation(id);

            if (reservation == null) {
                JsonUtil.writeError(resp, 404, "Reservation not found");
                return;
            }

            JsonUtil.writeJson(resp, reservation);
        } catch (NumberFormatException ex) {
            JsonUtil.writeError(resp, 400, "Invalid id");
        } catch (IllegalArgumentException ex) {
            JsonUtil.writeError(resp, 400, ex.getMessage());
        } catch (Exception e) {
            JsonUtil.writeError(resp, 500, e.getMessage());
        }
    }

    @Override
    protected void doPut(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            ReservationRequest body = JsonUtil.readJson(req, ReservationRequest.class);
            Reservation reservation = toReservation(body, true);
            boolean updated = service.updateReservation(reservation);

            if (!updated) {
                JsonUtil.writeError(resp, 404, "Reservation not found");
                return;
            }

            JsonUtil.writeRawJson(resp, "{\"update\":\"ok\"}");
        } catch (IllegalArgumentException ex) {
            resp.setStatus(400);
            JsonUtil.writeRawJson(resp, "{\"update\":\"fail\",\"error\":\"" + safe(ex.getMessage()) + "\"}");
        } catch (Exception e) {
            resp.setStatus(500);
            JsonUtil.writeRawJson(resp, "{\"update\":\"fail\",\"error\":\"" + safe(e.getMessage()) + "\"}");
        }
    }

    @Override
    protected void doDelete(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            JsonUtil.writeError(resp, 400, "Missing id parameter");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            boolean deleted = service.deleteReservation(id);

            if (!deleted) {
                JsonUtil.writeError(resp, 404, "Reservation not found");
                return;
            }

            JsonUtil.writeRawJson(resp, "{\"delete\":\"ok\"}");
        } catch (NumberFormatException ex) {
            JsonUtil.writeError(resp, 400, "Invalid id");
        } catch (IllegalArgumentException ex) {
            JsonUtil.writeError(resp, 400, ex.getMessage());
        } catch (Exception e) {
            JsonUtil.writeError(resp, 500, e.getMessage());
        }
    }

    private Reservation toReservation(ReservationRequest body, boolean requireId) {
        if (body == null) {
            throw new IllegalArgumentException("Missing request body");
        }

        Reservation reservation = new Reservation();
        reservation.reservationId = body.reservationId == null ? 0 : body.reservationId;
        reservation.guestName = body.guestName;
        reservation.contactNo = body.contactNo;
        reservation.email = body.email;
        reservation.address = body.address;
        reservation.typeId = body.typeId == null ? 0 : body.typeId;

        try {
            reservation.checkIn = body.checkIn == null || body.checkIn.isBlank() ? null : LocalDate.parse(body.checkIn);
            reservation.checkOut = body.checkOut == null || body.checkOut.isBlank() ? null : LocalDate.parse(body.checkOut);
        } catch (Exception ex) {
            throw new IllegalArgumentException("Invalid date format. Use yyyy-mm-dd");
        }

        if (requireId && reservation.reservationId <= 0) {
            throw new IllegalArgumentException("Reservation id required");
        }

        return reservation;
    }

    private String safe(String value) {
        return (value == null ? "error" : value).replace("\"", "'");
    }
}