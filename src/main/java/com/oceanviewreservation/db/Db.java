package com.oceanviewreservation.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class Db {

    private static final String URL =
        "jdbc:mysql://localhost:3306/oceanviewreservation_db"
        + "?allowPublicKeyRetrieval=true"
        + "&useSSL=false"
        + "&serverTimezone=UTC";

    private static final String USER = "oceanview_user";
    private static final String PASS = "OceanView@123";

    public static Connection getConnection() throws SQLException, ClassNotFoundException {
        Class.forName("com.mysql.cj.jdbc.Driver"); // important for Tomcat runtime
        return DriverManager.getConnection(URL, USER, PASS);
    }
}