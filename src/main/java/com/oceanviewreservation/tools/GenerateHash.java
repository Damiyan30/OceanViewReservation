package com.oceanviewreservation.tools;

import org.mindrot.jbcrypt.BCrypt;

public class GenerateHash {
    public static void main(String[] args) {
        String password = "Admin@123";
        String hash = BCrypt.hashpw(password, BCrypt.gensalt(12));
        System.out.println("PASSWORD: " + password);
        System.out.println("BCRYPT: " + hash);
    }
}