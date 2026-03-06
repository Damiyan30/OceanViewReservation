package com.oceanviewreservation.util;

import java.time.LocalDate;
import java.time.temporal.ChronoUnit;

public final class BillingUtil {
    private BillingUtil() {}

    public static long nights(LocalDate checkIn, LocalDate checkOut) {
        long n = ChronoUnit.DAYS.between(checkIn, checkOut);
        return Math.max(n, 1);
    }

    public static double total(LocalDate checkIn, LocalDate checkOut, double nightlyRate) {
        return nights(checkIn, checkOut) * nightlyRate;
    }
}