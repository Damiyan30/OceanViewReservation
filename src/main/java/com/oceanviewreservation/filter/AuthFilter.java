package com.oceanviewreservation.filter;

import java.io.IOException;
import java.util.Set;
import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

public class AuthFilter implements Filter {

    // Public endpoints (no login required)
    private static final Set<String> PUBLIC_API_PATHS = Set.of(
            "/api/status",
            "/api/dbtest",
            "/api/login",
            "/api/logout"
    );

    @Override
    public void init(FilterConfig filterConfig) throws ServletException {
        // no-op
    }

    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain)
            throws IOException, ServletException {

        HttpServletRequest req = (HttpServletRequest) request;
        HttpServletResponse resp = (HttpServletResponse) response;

        String contextPath = req.getContextPath();          // e.g. /OceanViewReservation
        String uri = req.getRequestURI();                   // e.g. /OceanViewReservation/api/xyz
        String path = uri.substring(contextPath.length());  // e.g. /api/xyz

        // Allow public endpoints through
        if (PUBLIC_API_PATHS.contains(path)) {
            chain.doFilter(request, response);
            return;
        }

        // For protected API routes, require a session with userId
        HttpSession session = req.getSession(false);
        boolean loggedIn = (session != null && session.getAttribute("userId") != null);

        if (!loggedIn) {
            resp.setStatus(HttpServletResponse.SC_UNAUTHORIZED);
            resp.setContentType("application/json");
            resp.setCharacterEncoding("UTF-8");
            resp.getWriter().write("{\"error\":\"Unauthorized. Please login.\"}");
            return;
        }

        chain.doFilter(request, response);
    }

    @Override
    public void destroy() {
        // no-op
    }
}