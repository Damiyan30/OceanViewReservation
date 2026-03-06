package com.oceanviewreservation.service;

import com.oceanviewreservation.dao.ReservationDAO;
import com.oceanviewreservation.model.Reservation;
import java.time.LocalDate;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class ReservationServiceTest {

    // Fake DAO so tests don't hit the database
    static class FakeReservationDAO extends ReservationDAO {
        @Override
        public int create(Reservation r) throws Exception {
            return 123; // pretend DB generated this id
        }
    }

    private Reservation validReservation() {
        Reservation r = new Reservation();
        r.guestName = "Test Guest";
        r.contactNo = "0771234567";
        r.email = "test@example.com";
        r.address = "Colombo";
        r.typeId = 1;
        r.checkIn = LocalDate.of(2026, 3, 10);
        r.checkOut = LocalDate.of(2026, 3, 12);
        return r;
    }

    @Test
    void missingGuestName_shouldThrow() {
        ReservationService service = new ReservationService(new FakeReservationDAO());
        Reservation r = validReservation();
        r.guestName = "   ";

        assertThrows(IllegalArgumentException.class, () -> service.addReservation(r));
    }

    @Test
    void missingContactNo_shouldThrow() {
        ReservationService service = new ReservationService(new FakeReservationDAO());
        Reservation r = validReservation();
        r.contactNo = "";

        assertThrows(IllegalArgumentException.class, () -> service.addReservation(r));
    }

    @Test
    void checkoutEqualToCheckin_shouldThrow() {
        ReservationService service = new ReservationService(new FakeReservationDAO());
        Reservation r = validReservation();
        r.checkOut = r.checkIn; // same day

        assertThrows(IllegalArgumentException.class, () -> service.addReservation(r));
    }

    @Test
    void checkoutBeforeCheckin_shouldThrow() {
        ReservationService service = new ReservationService(new FakeReservationDAO());
        Reservation r = validReservation();
        r.checkOut = r.checkIn.minusDays(1);

        assertThrows(IllegalArgumentException.class, () -> service.addReservation(r));
    }

    @Test
    void validReservation_shouldReturnId() throws Exception {
        ReservationService service = new ReservationService(new FakeReservationDAO());
        Reservation r = validReservation();

        int id = service.addReservation(r);
        assertEquals(123, id);
    }
}