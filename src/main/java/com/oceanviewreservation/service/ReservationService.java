package com.oceanviewreservation.service;

import com.oceanviewreservation.dao.ReservationDAO;
import com.oceanviewreservation.model.Reservation;

public class ReservationService {

    private final ReservationDAO dao = new ReservationDAO();

    public int addReservation(Reservation r) throws Exception {
        if (r == null) {
            throw new IllegalArgumentException("Reservation data required");
        }

        // Normalize/trim inputs
        r.guestName = (r.guestName == null) ? "" : r.guestName.trim();
        r.contactNo = (r.contactNo == null) ? "" : r.contactNo.trim();
        r.email = (r.email == null || r.email.trim().isEmpty()) ? null : r.email.trim();
        r.address = (r.address == null || r.address.trim().isEmpty()) ? null : r.address.trim();

        // Required checks
        if (r.guestName.isBlank()) throw new IllegalArgumentException("Guest name required");
        if (r.contactNo.isBlank()) throw new IllegalArgumentException("Contact number required");
        if (r.checkIn == null || r.checkOut == null) throw new IllegalArgumentException("Dates required");
        if (r.typeId <= 0) throw new IllegalArgumentException("Room type required");

        // Length limits (match your DB column sizes)
        if (r.guestName.length() > 100) throw new IllegalArgumentException("Guest name too long (max 100)");
        if (r.contactNo.length() > 30) throw new IllegalArgumentException("Contact number too long (max 30)");
        if (r.email != null && r.email.length() > 120) throw new IllegalArgumentException("Email too long (max 120)");
        if (r.address != null && r.address.length() > 200) throw new IllegalArgumentException("Address too long (max 200)");

        // Date logic
        if (!r.checkOut.isAfter(r.checkIn)) {
            throw new IllegalArgumentException("Check-out must be after check-in");
        }

        return dao.create(r);
    }

    public Reservation getReservation(int id) throws Exception {
        if (id <= 0) throw new IllegalArgumentException("Invalid reservation id");
        return dao.findById(id);
    }
}