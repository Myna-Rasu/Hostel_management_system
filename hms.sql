-- Create database
CREATE DATABASE hostel_management;
USE hostel_management;

-- Table: Users
CREATE TABLE Users (
    UserID INT AUTO_INCREMENT PRIMARY KEY,
    Username VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARCHAR(255) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    Role ENUM('Admin', 'Staff', 'Guest') DEFAULT 'Guest',
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE Admin (
    AdminID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT UNIQUE,
    DateHired DATE,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Table: Hostels
CREATE TABLE Hostels (
    HostelID INT AUTO_INCREMENT PRIMARY KEY,
	AdminID INT,
    Name VARCHAR(50) NOT NULL,
    Location VARCHAR(50) NOT NULL,
    Description TEXT,
    Capacity INT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
	FOREIGN KEY (UserID) REFERENCES Users(UserID),
	FOREIGN KEY (AdminID) REFERENCES (AdminID)
);

-- Table: Rooms
CREATE TABLE Rooms (
    RoomID INT AUTO_INCREMENT PRIMARY KEY,
    HostelID INT,
    RoomNumber VARCHAR(20) NOT NULL,
    RoomType ENUM('Single', 'Double', 'Triple', 'Suite') NOT NULL,
    Capacity INT,
    Price DECIMAL(10, 2),
    Status ENUM('Available', 'Occupied', 'Under Maintenance') DEFAULT 'Available',
    FOREIGN KEY (HostelID) REFERENCES Hostels(HostelID),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: Bookings
CREATE TABLE Bookings (
    BookingID INT AUTO_INCREMENT PRIMARY KEY,
    RoomID INT,
    UserID INT,
    CheckInDate DATE,
    CheckOutDate DATE,
    Status ENUM('Confirmed', 'Checked In', 'Checked Out', 'Cancelled') DEFAULT 'Confirmed',
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID),
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Table: Payments
CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    BookingID INT,
    Amount DECIMAL(10, 2),
    PaymentDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PaymentMethod ENUM('Cash', 'Credit Card', 'Debit Card', 'Online') DEFAULT 'Online',
    FOREIGN KEY (BookingID) REFERENCES Bookings(BookingID)
);

-- Table: Reviews
CREATE TABLE Reviews (
    ReviewID INT AUTO_INCREMENT PRIMARY KEY,
    HostelID INT,
    UserID INT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (HostelID) REFERENCES Hostels(HostelID),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Table: Staff
CREATE TABLE Staff (
    StaffID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    Position VARCHAR(100),
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);

-- Table: Maintenance
CREATE TABLE Maintenance (
    MaintenanceID INT AUTO_INCREMENT PRIMARY KEY,
    RoomID INT,
    Description TEXT,
    RequestDate TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    Status ENUM('Pending', 'In Progress', 'Completed') DEFAULT 'Pending',
    FOREIGN KEY (RoomID) REFERENCES Rooms(RoomID)
);

-- Table: Hostel_Events
CREATE TABLE Hostel_Events (
    EventID INT AUTO_INCREMENT PRIMARY KEY,
    HostelID INT,
    EventTitle VARCHAR(100),
    EventDescription TEXT,
    EventDate DATE,
    FOREIGN KEY (HostelID) REFERENCES Hostels(HostelID)
);

-- Table: Feedback
CREATE TABLE Feedback (
    FeedbackID INT AUTO_INCREMENT PRIMARY KEY,
    UserID INT,
    Message TEXT,
    CreatedAt TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (UserID) REFERENCES Users(UserID)
);
