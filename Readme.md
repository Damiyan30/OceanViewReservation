
OceanViewReservation
Project README

Overview
OceanViewReservation is a web-based hotel reservation system built using native web technologies on the front end and Java Servlets on the back end. It supports session-based authentication, reservation management, and bill printing.
Tech Stack
•	Frontend: HTML, CSS, Vanilla JavaScript
•	Backend: Java Servlets (Tomcat 9), JDBC, DAO + Service patterns (MVC-style structure)
•	Database: MySQL
•	Build Tool: Maven
•	IDE (recommended): NetBeans
•	Version Control: Git + GitHub
Features
•	Login / Logout (session-based)
•	Add Reservation
•	View Reservation by ID
•	Calculate Bill + Print
•	Help page
Requirements
•	Java 21 (LTS)
•	Apache Tomcat 9.x
•	MySQL Server (8.x recommended)
•	Maven (NetBeans includes Maven support)
Database Setup
1) Run the database schema script in MySQL:
src/main/resources/schema.sql
2) Create an admin user (bcrypt password hash):
   • Run the helper class: com.oceanviewreservation.tools.GenerateHash
   • Copy the printed bcrypt hash and insert it using SQL:
USE oceanviewreservation_db;

INSERT INTO users (username, password_hash, role)
VALUES ('admin', '<PASTE_BCRYPT_HASH_HERE>', 'ADMIN');
Running the Application (NetBeans)
•	Add Tomcat 9: Services → Servers → Add Server → Apache Tomcat
•	Right-click project → Clean and Build
•	Right-click project → Run
Default base URL:
http://localhost:8080/OceanViewReservation/
Main Pages
•	Login: http://localhost:8080/OceanViewReservation/login.html
•	Dashboard: http://localhost:8080/OceanViewReservation/dashboard.html
•	Add Reservation: http://localhost:8080/OceanViewReservation/add-reservation.html
•	View Reservation: http://localhost:8080/OceanViewReservation/view-reservation.html
•	Bill + Print: http://localhost:8080/OceanViewReservation/bill.html
•	Help: http://localhost:8080/OceanViewReservation/help.html
API Endpoints (JSON)
Most endpoints require login (session cookie).
Public endpoints
•	GET /api/status
•	GET /api/dbtest
•	POST /api/login
•	POST /api/logout
Protected endpoints
•	GET /api/me
•	GET /api/room-types
•	POST /api/reservations
•	GET /api/reservations?id=<id>
•	GET /api/bill?id=<id>
•	GET /api/secure-ping
Notes
•	Bill calculation: Total = Nights × Nightly Rate
•	Session security: AuthFilter protects /api/* (except public endpoints)
•	LocalDate JSON handling: centralized via JsonUtil for Java 21 compatibility
Troubleshooting
Unauthorized / redirected to login
• Login again using login.html. Your session may have expired or you logged out.

/api/room-types returns 404
• Ensure RoomTypesServlet exists and the app is rebuilt + redeployed.

Database connection errors
• Ensure MySQL is running and schema.sql was executed.
• Verify DB credentials in com.oceanviewreservation.db.Db
Repository / Version Control
This project is tracked using Git and pushed to GitHub. Commit after each milestone (auth, reservations, billing, docs, tests).
