package com.oceanviewreservation.api;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonNull;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializer;
import com.oceanviewreservation.model.Reservation;
import com.oceanviewreservation.service.ReservationService;
import java.io.BufferedReader;
import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/api/reservations")
public class ReservationsServlet extends HttpServlet {

    // ✅ Gson configured for Java 21 + LocalDate
    private static final Gson gson = new GsonBuilder()
            .registerTypeAdapter(LocalDate.class, (JsonSerializer<LocalDate>) (src, typeOfSrc, context) ->
                    src == null ? JsonNull.INSTANCE : new JsonPrimitive(src.toString()))
            .registerTypeAdapter(LocalDate.class, (JsonDeserializer<LocalDate>) (json, typeOfT, context) ->
                    (json == null || json.isJsonNull()) ? null : LocalDate.parse(json.getAsString()))
            .create();

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
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        try (BufferedReader reader = req.getReader()) {
            CreateReservationRequest body = gson.fromJson(reader, CreateReservationRequest.class);

            if (body == null
                    || body.guestName == null || body.guestName.isBlank()
                    || body.contactNo == null || body.contactNo.isBlank()
                    || body.checkIn == null || body.checkIn.isBlank()
                    || body.checkOut == null || body.checkOut.isBlank()
                    || body.typeId <= 0) {
                resp.setStatus(400);
                resp.getWriter().write("{\"create\":\"fail\",\"error\":\"Missing required fields\"}");
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
            resp.getWriter().write("{\"create\":\"ok\",\"reservationId\":" + id + "}");

        } catch (IllegalArgumentException ex) {
            resp.setStatus(400);
            resp.getWriter().write("{\"create\":\"fail\",\"error\":\"" + ex.getMessage().replace("\"", "'") + "\"}");
        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write("{\"create\":\"fail\",\"error\":\"" + (e.getMessage() + "").replace("\"", "'") + "\"}");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");

        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
            resp.setStatus(400);
            resp.getWriter().write("{\"error\":\"Missing id parameter\"}");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Reservation r = service.getReservation(id);

            if (r == null) {
                resp.setStatus(404);
                resp.getWriter().write("{\"error\":\"Reservation not found\"}");
                return;
            }

            // ✅ Now LocalDate fields serialize safely as "YYYY-MM-DD"
            resp.getWriter().write(gson.toJson(r));

        } catch (NumberFormatException ex) {
            resp.setStatus(400);
            resp.getWriter().write("{\"error\":\"Invalid id\"}");
        } catch (Exception e) {
            resp.setStatus(500);
            resp.getWriter().write("{\"error\":\"" + (e.getMessage() + "").replace("\"", "'") + "\"}");
        }
    }
}