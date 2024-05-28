CREATE TABLE Venue (
    VenueName VARCHAR(100) PRIMARY KEY,
    Capacity INT,
    Address VARCHAR(200)
);

CREATE TABLE Event (
    EventName VARCHAR(100),
    EventDate DATE,
    VenueName VARCHAR(100),
    EventType VARCHAR(50),
    EventStatus VARCHAR(50) CHECK (EventStatus IN ('upcoming', 'cancelled')),
    Price INT,
    PRIMARY KEY (EventName, EventDate),
    FOREIGN KEY (VenueName) REFERENCES Venue(VenueName)
);

CREATE TABLE Artist (
    ArtistName VARCHAR(100) PRIMARY KEY,
    Email VARCHAR(100),
    SpecialRequest TEXT
);

CREATE TABLE Event_Artist (
    EventName VARCHAR(100),
    EventDate DATE,
    ArtistName VARCHAR(100),
    PRIMARY KEY (EventName, EventDate, ArtistName),
    FOREIGN KEY (EventName, EventDate) REFERENCES Event(EventName, EventDate),
    FOREIGN KEY (ArtistName) REFERENCES Artist(ArtistName)
);

CREATE TABLE Booking (
    BookingID INT PRIMARY KEY IDENTITY(1,1),
    PhoneNumber VARCHAR(20),
    EventName VARCHAR(100),
    EventDate DATE,
    BookingDate DATE,
    Status VARCHAR(50) CHECK (Status IN ('pending', 'complete', 'cancelled')),
    NumberOfTickets INT,
    FOREIGN KEY (EventName, EventDate) REFERENCES Event(EventName, EventDate)
);
