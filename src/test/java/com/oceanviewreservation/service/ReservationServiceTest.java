package com.oceanviewreservation.service;

import com.oceanviewreservation.dao.ReservationDAO;
import com.oceanviewreservation.model.Reservation;
import java.time.LocalDate;
import java.util.List;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class ReservationServiceTest {

    static class FakeReservationDAO extends ReservationDAO {
        @Override
        public int create(Reservation r) {
            return 123;
        }

        @Override
        public Reservation findById(int id) {
            if (id == 999) {
                return null;
            }
            Reservation r = new Reservation();
            r.reservationId = id;
            r.guestName = "Saved Guest";
            r.contactNo = "0771234567";
            r.typeId = 1;
            r.checkIn = LocalDate.of(2026, 3, 10);
            r.checkOut = LocalDate.of(2026, 3, 12);
            return r;
        }

        @Override
        public List<Reservation> findAll() {
            Reservation first = new Reservation();
            first.reservationId = 1;
            first.guestName = "A";
            first.contactNo = "111";
            first.typeId = 1;
            first.checkIn = LocalDate.of(2026, 3, 10);
            first.checkOut = LocalDate.of(2026, 3, 11);

            Reservation second = new Reservation();
            second.reservationId = 2;
            second.guestName = "B";
            second.contactNo = "222";
            second.typeId = 2;
            second.checkIn = LocalDate.of(2026, 3, 12);
            second.checkOut = LocalDate.of(2026, 3, 14);

            return List.of(first, second);
        }

        @Override
        public List<Reservation> findRecent(int limit) {
            Reservation first = new Reservation();
            first.reservationId = 7;
            first.guestName = "Recent Guest";
            first.contactNo = "0770000000";
            first.typeId = 1;
            first.checkIn = LocalDate.of(2026, 3, 20);
            first.checkOut = LocalDate.of(2026, 3, 22);

            return List.of(first);
        }

        @Override
        public boolean update(Reservation r) {
            return r.reservationId != 999;
        }

        @Override
        public boolean deleteById(int id) {
            return id != 999;
        }

        @Override
        public DashboardStats getDashboardStats() {
            DashboardStats stats = new DashboardStats();
            stats.totalReservations = 12;
            stats.todayCheckIns = 3;
            stats.todayCheckOuts = 2;
            stats.activeStays = 5;
            return stats;
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
        r.checkOut = r.checkIn;

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

    @Test
    void getAllReservations_shouldReturnList() throws Exception {
        ReservationService service = new ReservationService(new FakeReservationDAO());
        List<Reservation> list = service.getAllReservations();

        assertEquals(2, list.size());
    }

    @Test
    void updateReservation_shouldReturnTrue() throws Exception {
        ReservationService service = new ReservationService(new FakeReservationDAO());
        Reservation r = validReservation();
        r.reservationId = 1;

        assertTrue(service.updateReservation(r));
    }

    @Test
    void deleteReservation_shouldReturnTrue() throws Exception {
        ReservationService service = new ReservationService(new FakeReservationDAO());
        assertTrue(service.deleteReservation(1));
    }

    @Test
    void invalidReservationId_shouldThrow() {
        ReservationService service = new ReservationService(new FakeReservationDAO());
        assertThrows(IllegalArgumentException.class, () -> service.getReservation(0));
    }

    @Test
    void dashboardStats_shouldReturnCounts() throws Exception {
        ReservationService service = new ReservationService(new FakeReservationDAO());
        ReservationDAO.DashboardStats stats = service.getDashboardStats();

        assertEquals(12, stats.totalReservations);
        assertEquals(3, stats.todayCheckIns);
        assertEquals(2, stats.todayCheckOuts);
        assertEquals(5, stats.activeStays);
    }

    @Test
    void recentReservations_shouldReturnList() throws Exception {
        ReservationService service = new ReservationService(new FakeReservationDAO());
        List<Reservation> list = service.getRecentReservations(5);

        assertEquals(1, list.size());
        assertEquals(7, list.get(0).reservationId);
    }
}