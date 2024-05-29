INSERT INTO Venue (VenueName, Capacity, Address)
VALUES 
    ('Venue A', 80, 'Lutherinkatu 3, 00100 Helsinki'),
    ('Venue B', 100, 'Mannerheimintie 13 A, 00100 Helsinki'),
    ('Venue C', 120, 'Ensi linja 2, 00530 Helsinki');

INSERT INTO Event (EventName, EventDate, VenueName, EventType, EventStatus, Price)
VALUES 
    ('The Monster Tour', '2024-12-06', 'Venue B', 'concert', 'upcoming', 50),
    ('Weekends with Adele', '2024-11-11', 'Venue A', 'concert', 'upcoming', 70),
    ('The Dance Revolution Tour', '2024-09-09', 'Venue B', 'dance', 'upcoming', 70),
    ('Dark Passion Play World Tour', '2025-01-09', 'Venue C', 'concert', 'upcoming', 120),
    ('Bluegrass Evening', '2024-07-08', 'Venue A', 'dance', 'upcoming', 100),
    ('Dark Side Era', '2024-07-20', 'Venue B', 'concert', 'upcoming', 130),
    ('The Loud Tour', '2024-09-02', 'Venue B', 'concert', 'upcoming', 200),
    ('Romeo and Juliet', '2025-07-20', 'Venue B', 'theater', 'cancelled', 30), 
    ('High School Musical on Stage!', '2025-10-17', 'Venue B', 'theater', 'upcoming', 40);

INSERT INTO Artist (ArtistName, Email, SpecialRequest)
VALUES
   ('Eminem', 'eminem@example.com', 'vegan'),
   ('Adele', 'adele@beauty.com', 'lactose intolerance'),
   ('Jabbawockeez', 'dacoolcrew@jab.ca', NULL),
   ('Quest crew', 'quest@yo.org', 'hot food only'),
   ('Nightwish', 'nightwishband@tour.fi', 'only vegetarian food'),
   ('Rihanna', 'rihanna@rudeboy.com', NULL),
   ('Blind Channel', 'blindchannel@bandi.fi', 'request for peanut snack'),
   ('Leonardo DiCaprio', 'leo@titanic.com', NULL),
   ('Claire Danes', 'claire@hotmail.com', 'allergic to shellfish'),
   ('Zac Efron', 'zac@hotmail.com', 'no cheese'),
   ('Ashley Tisdale', 'tisdale@ash.com', NULL);

INSERT INTO Event_Artist (EventName, EventDate, ArtistName)
VALUES
    ('The Monster Tour', '2024-12-06', 'Eminem'),
    ('Weekends with Adele', '2024-11-11', 'Adele'),
    ('The Dance Revolution Tour', '2024-09-09', 'Jabbawockeez'),
    ('Dark Passion Play World Tour', '2025-01-09', 'Nightwish'),
    ('Bluegrass Evening', '2024-07-08', 'Quest crew'),
    ('Dark Side Era', '2024-07-20', 'Rihanna'),
    ('The Loud Tour', '2024-09-02', 'Blind Channel'),
    ('Romeo and Juliet', '2025-07-20', 'Leonardo DiCaprio'),
    ('High School Musical on Stage!', '2025-10-17', 'Zac Efron');

INSERT INTO Booking (PhoneNumber, EventName, EventDate, BookingDate, Status, NumberOfTickets)
VALUES
    ('222-333-4444', 'The Dance Revolution Tour', '2024-09-09', '2024-08-15', 'complete', 3),
    ('555-666-7777', 'High School Musical on Stage!', '2025-10-17', '2025-09-01', 'pending', 2),
    ('888-999-0000', 'Dark Passion Play World Tour', '2025-01-09', '2024-12-01', 'complete', 1),
    ('123-456-7890', 'Romeo and Juliet', '2025-07-20', '2025-06-01', 'cancelled', 2),
    ('987-654-3210', 'The Monster Tour', '2024-12-06', '2024-11-15', 'complete', 4),
    ('111-222-3333', 'Bluegrass Evening', '2024-07-08', '2024-06-01', 'complete', 3);
