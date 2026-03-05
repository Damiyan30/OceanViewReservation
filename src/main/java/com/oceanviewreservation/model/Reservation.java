package com.oceanviewreservation.model;

import java.time.LocalDate;

public class Reservation {
    public int reservationId;
    public String guestName;
    public String contactNo;
    public String email;
    public String address;
    public int typeId;
    public String typeName;      // for join results
    public double nightlyRate;   // for join results
    public LocalDate checkIn;
    public LocalDate checkOut;
}