package com.oceanviewreservation.service;

import com.oceanviewreservation.dao.ReservationDAO;
import com.oceanviewreservation.model.Reservation;

public class ReservationService {

    private final ReservationDAO dao = new ReservationDAO();

    public int addReservation(Reservation r) throws Exception {
        if (r.guestName == null || r.guestName.isBlank()) throw new IllegalArgumentException("Guest name required");
        if (r.contactNo == null || r.contactNo.isBlank()) throw new IllegalArgumentException("Contact number required");
        if (r.checkIn == null || r.checkOut == null) throw new IllegalArgumentException("Dates required");
        if (!r.checkOut.isAfter(r.checkIn)) throw new IllegalArgumentException("Check-out must be after check-in");
        if (r.typeId <= 0) throw new IllegalArgumentException("Room type required");

        return dao.create(r);
    }

    public Reservation getReservation(int id) throws Exception {
        return dao.findById(id);
    }
}