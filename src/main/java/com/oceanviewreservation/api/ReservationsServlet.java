package com.oceanviewreservation.api;

import com.oceanviewreservation.model.Reservation;
import com.oceanviewreservation.service.ReservationService;
import com.oceanviewreservation.util.JsonUtil;
import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/api/reservations")
public class ReservationsServlet extends HttpServlet {

    private final ReservationService service = new ReservationService();

    static class CreateReservationRequest {
        String guestName;
        String contactNo;
        String email;
        String address;
        int typeId;
        String checkIn;   // yyyy-mm-dd
        String checkOut;  // yyyy-mm-dd
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        try {
            CreateReservationRequest body = JsonUtil.readJson(req, CreateReservationRequest.class);

            if (body == null
                    || body.guestName == null || body.guestName.isBlank()
                    || body.contactNo == null || body.contactNo.isBlank()
                    || body.checkIn == null || body.checkIn.isBlank()
                    || body.checkOut == null || body.checkOut.isBlank()
                    || body.typeId <= 0) {
                JsonUtil.writeRawJson(resp, "{\"create\":\"fail\",\"error\":\"Missing required fields\"}");
                resp.setStatus(400);
                return;
            }

            Reservation r = new Reservation();
            r.guestName = body.guestName.trim();
            r.contactNo = body.contactNo.trim();
            r.email = (body.email == null) ? null : body.email.trim();
            r.address = (body.address == null) ? null : body.address.trim();
            r.typeId = body.typeId;
            r.checkIn = LocalDate.parse(body.checkIn);
            r.checkOut = LocalDate.parse(body.checkOut);

            int id = service.addReservation(r);
            JsonUtil.writeRawJson(resp, "{\"create\":\"ok\",\"reservationId\":" + id + "}");

        } catch (IllegalArgumentException ex) {
            resp.setStatus(400);
            JsonUtil.writeRawJson(resp, "{\"create\":\"fail\",\"error\":\"" + ex.getMessage().replace("\"", "'") + "\"}");
        } catch (Exception e) {
            resp.setStatus(500);
            JsonUtil.writeRawJson(resp, "{\"create\":\"fail\",\"error\":\"" + (e.getMessage() + "").replace("\"", "'") + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            resp.setStatus(400);
            JsonUtil.writeError(resp, 400, "Missing id parameter");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Reservation r = service.getReservation(id);

            if (r == null) {
                JsonUtil.writeError(resp, 404, "Reservation not found");
                return;
            }

            // LocalDate serializes safely here because JsonUtil's Gson is configured
            JsonUtil.writeJson(resp, r);

        } catch (NumberFormatException ex) {
            JsonUtil.writeError(resp, 400, "Invalid id");
        } catch (Exception e) {
            JsonUtil.writeError(resp, 500, e.getMessage());
        }
    }
}