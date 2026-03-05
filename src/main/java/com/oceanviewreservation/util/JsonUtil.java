package com.oceanviewreservation.util;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.JsonDeserializer;
import com.google.gson.JsonNull;
import com.google.gson.JsonPrimitive;
import com.google.gson.JsonSerializer;
import java.io.BufferedReader;
import java.io.IOException;
import java.time.LocalDate;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public final class JsonUtil {

    private JsonUtil() {}

    // One shared Gson instance (LocalDate safe on Java 21)
    private static final Gson GSON = new GsonBuilder()
            .registerTypeAdapter(LocalDate.class, (JsonSerializer<LocalDate>) (src, type, ctx) ->
                    src == null ? JsonNull.INSTANCE : new JsonPrimitive(src.toString()))
            .registerTypeAdapter(LocalDate.class, (JsonDeserializer<LocalDate>) (json, type, ctx) ->
                    (json == null || json.isJsonNull()) ? null : LocalDate.parse(json.getAsString()))
            .create();

    public static Gson gson() {
        return GSON;
    }

    public static <T> T readJson(HttpServletRequest req, Class<T> clazz) throws IOException {
        try (BufferedReader r = req.getReader()) {
            return GSON.fromJson(r, clazz);
        }
    }

    public static void writeJson(HttpServletResponse resp, Object obj) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(GSON.toJson(obj));
    }

    public static void writeRawJson(HttpServletResponse resp, String json) throws IOException {
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(json);
    }

    public static void writeError(HttpServletResponse resp, int status, String message) throws IOException {
        resp.setStatus(status);
        resp.setContentType("application/json");
        resp.setCharacterEncoding("UTF-8");
        String safe = (message == null ? "error" : message).replace("\"", "'");
        resp.getWriter().write("{\"error\":\"" + safe + "\"}");
    }
}