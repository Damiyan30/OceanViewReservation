package com.oceanviewreservation.service;

import com.oceanviewreservation.dao.ReservationDAO;
import com.oceanviewreservation.model.Reservation;
import java.util.List;

public class ReservationService {

    private final ReservationDAO dao;

    public ReservationService() {
        this(new ReservationDAO());
    }

    public ReservationService(ReservationDAO dao) {
        if (dao == null) throw new IllegalArgumentException("DAO required");
        this.dao = dao;
    }

    public int addReservation(Reservation r) throws Exception {
        validateReservation(r, false);
        return dao.create(r);
    }

    public Reservation getReservation(int id) throws Exception {
        validateReservationId(id);
        return dao.findById(id);
    }

    public List<Reservation> getAllReservations() throws Exception {
        return dao.findAll();
    }

    public boolean updateReservation(Reservation r) throws Exception {
        validateReservation(r, true);
        return dao.update(r);
    }

    public boolean deleteReservation(int id) throws Exception {
        validateReservationId(id);
        return dao.deleteById(id);
    }

    private void validateReservationId(int id) {
        if (id <= 0) {
            throw new IllegalArgumentException("Invalid reservation id");
        }
    }

    private void validateReservation(Reservation r, boolean requireId) {
        if (r == null) {
            throw new IllegalArgumentException("Reservation data required");
        }

        if (requireId && r.reservationId <= 0) {
            throw new IllegalArgumentException("Reservation id required");
        }

        r.guestName = (r.guestName == null) ? "" : r.guestName.trim();
        r.contactNo = (r.contactNo == null) ? "" : r.contactNo.trim();
        r.email = (r.email == null || r.email.trim().isEmpty()) ? null : r.email.trim();
        r.address = (r.address == null || r.address.trim().isEmpty()) ? null : r.address.trim();

        if (r.guestName.isBlank()) throw new IllegalArgumentException("Guest name required");
        if (r.contactNo.isBlank()) throw new IllegalArgumentException("Contact number required");
        if (r.checkIn == null || r.checkOut == null) throw new IllegalArgumentException("Dates required");
        if (r.typeId <= 0) throw new IllegalArgumentException("Room type required");

        if (r.guestName.length() > 100) throw new IllegalArgumentException("Guest name too long (max 100)");
        if (r.contactNo.length() > 30) throw new IllegalArgumentException("Contact number too long (max 30)");
        if (r.email != null && r.email.length() > 120) throw new IllegalArgumentException("Email too long (max 120)");
        if (r.address != null && r.address.length() > 200) throw new IllegalArgumentException("Address too long (max 200)");

        if (!r.checkOut.isAfter(r.checkIn)) {
            throw new IllegalArgumentException("Check-out must be after check-in");
        }
    }
}