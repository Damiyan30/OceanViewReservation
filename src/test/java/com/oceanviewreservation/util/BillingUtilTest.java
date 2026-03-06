package com.oceanviewreservation.util;

import java.time.LocalDate;
import org.junit.jupiter.api.Test;

import static org.junit.jupiter.api.Assertions.*;

public class BillingUtilTest {

    @Test
    void nights_shouldBe2() {
        LocalDate in = LocalDate.of(2026, 3, 10);
        LocalDate out = LocalDate.of(2026, 3, 12);
        assertEquals(2, BillingUtil.nights(in, out));
    }

    @Test
    void total_shouldBeNightlyRateTimesNights() {
        LocalDate in = LocalDate.of(2026, 3, 10);
        LocalDate out = LocalDate.of(2026, 3, 12);
        assertEquals(24000.0, BillingUtil.total(in, out, 12000.0), 0.0001);
    }

    @Test
    void nights_shouldBeAtLeast1() {
        LocalDate in = LocalDate.of(2026, 3, 10);
        LocalDate out = LocalDate.of(2026, 3, 10);
        assertEquals(1, BillingUtil.nights(in, out));
    }
}