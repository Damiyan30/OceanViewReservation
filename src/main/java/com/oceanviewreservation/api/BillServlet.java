package com.oceanviewreservation.api;

import com.oceanviewreservation.model.Reservation;
import com.oceanviewreservation.service.ReservationService;
import com.oceanviewreservation.util.JsonUtil;
import java.io.IOException;
import java.time.temporal.ChronoUnit;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/api/bill")
public class BillServlet extends HttpServlet {

    private final ReservationService service = new ReservationService();

    // Simple response object to convert to JSON
    static class BillResponse {
        int reservationId;
        String guestName;
        String contactNo;
        String email;
        String address;

        String roomType;
        double nightlyRate;

        String checkIn;   // yyyy-mm-dd
        String checkOut;  // yyyy-mm-dd
        long nights;

        double total;
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String idStr = req.getParameter("id");
        if (idStr == null || idStr.isBlank()) {
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

            long nights = ChronoUnit.DAYS.between(r.checkIn, r.checkOut);
            if (nights < 1) nights = 1; // safety

            double total = nights * r.nightlyRate;

            BillResponse bill = new BillResponse();
            bill.reservationId = r.reservationId;
            bill.guestName = r.guestName;
            bill.contactNo = r.contactNo;
            bill.email = r.email;
            bill.address = r.address;

            bill.roomType = r.typeName;
            bill.nightlyRate = r.nightlyRate;

            bill.checkIn = r.checkIn.toString();
            bill.checkOut = r.checkOut.toString();
            bill.nights = nights;

            bill.total = total;

            JsonUtil.writeJson(resp, bill);

        } catch (NumberFormatException ex) {
            JsonUtil.writeError(resp, 400, "Invalid id");
        } catch (Exception e) {
            JsonUtil.writeError(resp, 500, e.getClass().getSimpleName() + ": " + e.getMessage());
        }
    }
}