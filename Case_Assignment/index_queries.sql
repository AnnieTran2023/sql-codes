-- Indexes for Event table
CREATE INDEX idx_Event_EventDate ON Event(EventDate);
CREATE INDEX idx_Event_EventType ON Event(EventType);
CREATE INDEX idx_Event_EventStatus ON Event(EventStatus);

-- Indexes for Venue table
CREATE INDEX idx_Venue_Capacity ON Venue(Capacity);

-- Indexes for Artist table
CREATE INDEX idx_Artist_Email ON Artist(Email);

-- Indexes for Booking table
CREATE INDEX idx_Booking_EventName ON Booking(EventName);
CREATE INDEX idx_Booking_EventDate ON Booking(EventDate);
CREATE INDEX idx_Booking_Status ON Booking(Status);
