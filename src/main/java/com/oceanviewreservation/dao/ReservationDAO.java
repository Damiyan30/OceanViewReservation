package com.oceanviewreservation.dao;

import com.oceanviewreservation.db.Db;
import com.oceanviewreservation.model.Reservation;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;
import java.time.LocalDate;

public class ReservationDAO {

    public int create(Reservation r) throws Exception {
        String sql = "INSERT INTO reservations (guest_name, contact_no, email, address, type_id, check_in, check_out) "
                   + "VALUES (?, ?, ?, ?, ?, ?, ?)";

        try (Connection con = Db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {

            ps.setString(1, r.guestName);
            ps.setString(2, r.contactNo);
            ps.setString(3, r.email);
            ps.setString(4, r.address);
            ps.setInt(5, r.typeId);
            ps.setDate(6, Date.valueOf(r.checkIn));
            ps.setDate(7, Date.valueOf(r.checkOut));

            ps.executeUpdate();

            try (ResultSet keys = ps.getGeneratedKeys()) {
                if (keys.next()) return keys.getInt(1);
            }
        }
        throw new RuntimeException("Failed to create reservation");
    }

    public Reservation findById(int id) throws Exception {
        String sql = "SELECT r.reservation_id, r.guest_name, r.contact_no, r.email, r.address, "
                   + "r.check_in, r.check_out, rt.type_id, rt.type_name, rt.nightly_rate "
                   + "FROM reservations r "
                   + "JOIN room_types rt ON r.type_id = rt.type_id "
                   + "WHERE r.reservation_id = ?";

        try (Connection con = Db.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);

            try (ResultSet rs = ps.executeQuery()) {
                if (!rs.next()) return null;

                Reservation r = new Reservation();
                r.reservationId = rs.getInt("reservation_id");
                r.guestName = rs.getString("guest_name");
                r.contactNo = rs.getString("contact_no");
                r.email = rs.getString("email");
                r.address = rs.getString("address");
                r.checkIn = rs.getDate("check_in").toLocalDate();
                r.checkOut = rs.getDate("check_out").toLocalDate();
                r.typeId = rs.getInt("type_id");
                r.typeName = rs.getString("type_name");
                r.nightlyRate = rs.getDouble("nightly_rate");
                return r;
            }
        }
    }

    public static long nightsBetween(LocalDate in, LocalDate out) {
        return java.time.temporal.ChronoUnit.DAYS.between(in, out);
    }
}