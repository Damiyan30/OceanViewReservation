-- OceanViewReservation - Database Schema
-- Run this in MySQL (NetBeans SQL window or MySQL CLI)

CREATE DATABASE IF NOT EXISTS oceanviewreservation_db;
USE oceanviewreservation_db;

-- USERS
CREATE TABLE IF NOT EXISTS users (
  user_id INT AUTO_INCREMENT PRIMARY KEY,
  username VARCHAR(50) NOT NULL UNIQUE,
  password_hash VARCHAR(100) NOT NULL,
  role VARCHAR(20) NOT NULL DEFAULT 'STAFF',
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ROOM TYPES
CREATE TABLE IF NOT EXISTS room_types (
  type_id INT AUTO_INCREMENT PRIMARY KEY,
  type_name VARCHAR(30) NOT NULL UNIQUE,
  nightly_rate DECIMAL(10,2) NOT NULL
);

INSERT IGNORE INTO room_types (type_name, nightly_rate) VALUES
('Single', 8000.00),
('Double', 12000.00),
('Suite', 20000.00);

-- RESERVATIONS
CREATE TABLE IF NOT EXISTS reservations (
  reservation_id INT AUTO_INCREMENT PRIMARY KEY,
  guest_name VARCHAR(100) NOT NULL,
  contact_no VARCHAR(30) NOT NULL,
  email VARCHAR(120),
  address VARCHAR(200),
  type_id INT NOT NULL,
  check_in DATE NOT NULL,
  check_out DATE NOT NULL,
  created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
  FOREIGN KEY (type_id) REFERENCES room_types(type_id)
);

-- NOTE: Admin user insertion depends on a bcrypt hash.
-- Use your GenerateHash tool (password: Admin@123) and insert like this:
-- INSERT INTO users (username, password_hash, role) VALUES ('admin', '<BCRYPT_HASH>', 'ADMIN');