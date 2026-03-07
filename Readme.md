OceanViewReservation
Overview
OceanViewReservation is a web-based hotel reservation management system developed as a Java web application using HTML, CSS, JavaScript, Java Servlets, JDBC, MySQL, and Maven.
The system allows hotel staff to securely log in, manage reservations, view live dashboard statistics, calculate guest bills, and print invoices. It follows a simple MVC-style architecture using Servlets, DAO, Service, and Model layers.
Features
Authentication
•	Secure staff login
•	Session-based authentication
•	Logout functionality
•	Protected routes using AuthFilter
Reservation Management
•	Add new reservations
•	View reservation by ID
•	View all reservations
•	Update reservation details
•	Delete reservations
•	Room type selection
•	Date validation (check-out must be after check-in)
Billing
•	Automatic bill calculation
•	Bill generation based on room type, nightly rate, and check-in and check-out dates
•	Printable invoice page
Dashboard
•	Live dashboard statistics from the database
•	Total reservations
•	Today's check-ins
•	Today's check-outs
•	Current active stays
•	Recent reservations list
Testing
•	JUnit 5 test cases for service-layer logic
•	Validation-related unit tests
Tech Stack
Category	Technologies
Frontend	HTML, CSS, JavaScript
Backend	Java Servlets, JDBC, DAO Pattern, Service Layer, MVC-style structure
Database	MySQL
Build / Server / Tools	Maven, Apache Tomcat 9, NetBeans, Git, GitHub
Security / Utilities	jBCrypt, JavaMail
Project Structure
OceanViewReservation/
├── src/
│   ├── main/
│   │   ├── java/com/oceanviewreservation/
│   │   │   ├── api/
│   │   │   ├── dao/
│   │   │   ├── db/
│   │   │   ├── filter/
│   │   │   ├── model/
│   │   │   ├── service/
│   │   │   ├── tools/
│   │   │   └── util/
│   │   ├── resources/
│   │   │   ├── schema.sql
│   │   │   └── README_DB_SETUP.txt
│   │   └── webapp/
│   │       ├── assets/
│   │       ├── WEB-INF/
│   │       ├── login.html
│   │       ├── dashboard.html
│   │       ├── add-reservation.html
│   │       ├── view-reservation.html
│   │       ├── bill.html
│   │       ├── help.html
│   │       └── index.html
│   └── test/
│       └── java/com/oceanviewreservation/
├── pom.xml
├── .gitignore
└── README.md
Prerequisites
•	Java 21
•	Apache Tomcat 9
•	MySQL Server 8.x
•	Maven
•	Git
NetBeans is recommended for easier deployment, but IntelliJ IDEA or Eclipse may also be used.
Database Setup
1. Create the database and tables
Run the SQL script located at:
src/main/resources/schema.sql
You can run it using MySQL Workbench, phpMyAdmin, or the command line MySQL client.
2. Create an admin login user
If your schema.sql does not already insert a login user, create one manually. Run the helper class:
com.oceanviewreservation.tools.GenerateHash
This will generate a bcrypt password hash. Then run this SQL:
USE oceanviewreservation_db;

INSERT INTO users (username, password_hash, role)
VALUES ('admin', '<PASTE_BCRYPT_HASH_HERE>', 'ADMIN');
3. Insert sample room types
If they are not already included in schema.sql, insert sample room types such as:
INSERT INTO room_types (type_name, nightly_rate) VALUES
('Standard', 8000.00),
('Deluxe', 12000.00),
('Suite', 18000.00);
Database Configuration
Update your database connection settings in:
src/main/java/com/oceanviewreservation/db/Db.java
Check and update the database URL, MySQL username, and MySQL password. Example:
String url = "jdbc:mysql://localhost:3306/oceanviewreservation_db";
String username = "root";
String password = "your_password";
If your project uses Tomcat datasource configuration, also check:
src/main/webapp/META-INF/context.xml
How to Run the Application
Option 1: Run using NetBeans
•	Open the project in NetBeans.
•	Add Tomcat 9: Services -> Servers -> Add Server -> Apache Tomcat.
•	Clean and build the project: Right-click project -> Clean and Build.
•	Run the project: Right-click project -> Run.
Option 2: Build using Maven
Run the following command in the project root:
mvn clean install
Then deploy the generated .war file to Tomcat.
Default Base URL
http://localhost:8080/OceanViewReservation/
Main Pages
•	Login: http://localhost:8080/OceanViewReservation/login.html
•	Dashboard: http://localhost:8080/OceanViewReservation/dashboard.html
•	Add Reservation: http://localhost:8080/OceanViewReservation/add-reservation.html
•	View / Update / Delete Reservations: http://localhost:8080/OceanViewReservation/view-reservation.html
•	Billing / Invoice: http://localhost:8080/OceanViewReservation/bill.html
•	Help Page: http://localhost:8080/OceanViewReservation/help.html
API Endpoints
Most endpoints require authentication via session cookie.
Public Endpoints
•	GET /api/status
•	GET /api/dbtest
•	POST /api/login
•	POST /api/logout
Protected Endpoints
•	GET /api/me
•	GET /api/room-types
•	POST /api/reservations
•	GET /api/reservations?id=<id>
•	GET /api/reservations
•	PUT /api/reservations
•	DELETE /api/reservations?id=<id>
•	GET /api/bill?id=<id>
•	GET /api/dashboard/stats
•	GET /api/secure-ping
Default Login Credentials
If you inserted the admin user manually, use the username and password you created.
Username: admin
Password: your chosen password
Business Rules / Notes
•	Check-out date must be later than check-in date.
•	Dashboard statistics are loaded from the reservation database.
•	Session access to protected endpoints is managed using AuthFilter.
•	JSON handling is centralized using JsonUtil.
Bill calculation formula:
Total = Number of Nights x Nightly Rate
Running Tests
To run unit tests:
mvn test
Tests are located under:
src/test/java/com/oceanviewreservation/
Troubleshooting
Login not working
•	Make sure the users table contains a valid admin user.
•	Make sure the password hash was generated correctly.
•	Rebuild and redeploy the project after database changes.
Database connection error
•	Make sure MySQL is running.
•	Make sure schema.sql has been executed.
•	Verify credentials in Db.java.
•	Verify database name is correct.
/api/room-types returns 404
•	Make sure RoomTypesServlet.java exists.
•	Rebuild and redeploy the application.
Dashboard not showing data
•	Make sure the reservations table contains records.
•	Make sure DashboardStatsServlet.java is included in the build.
•	Clean and build the project again.
Styles or JavaScript changes not showing
•	Clear browser cache.
•	Hard refresh the page with Ctrl + F5.
•	Clean and build the project again.
GitHub / Version Control
This project is managed using Git and hosted on GitHub.
Suggested commit flow:
•	authentication
•	reservation create/read
•	reservation update/delete
•	billing
•	dashboard
•	testing
•	documentation
Author
•	Project Name: OceanViewReservation
•	Module: CIS6003 Advanced Programming
•	Type: Java Web Application
Submission Note
To run this project successfully on another system, the following are required:
•	Clone the repository.
•	Import schema.sql into MySQL.
•	Update database credentials in Db.java.
•	Build using Maven.
•	Deploy to Tomcat 9.
•	Access the application through the provided base URL.
