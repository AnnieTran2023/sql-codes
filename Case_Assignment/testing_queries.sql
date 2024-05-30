--1. What is Eminem's contact email? 

SELECT Email
FROM Artist
WHERE ArtistName = 'Eminem';

--2. What is the venue name and address for Adele's concert on 11.11.2024?

SELECT v.VenueName, v.Address
FROM Venue AS v
JOIN Event AS e ON e.VenueName = v.VenueName
JOIN Event_Artist AS ea ON ea.EventName = e.EventName
WHERE ea.ArtistName = 'Adele'
AND ea.EventDate = '2024-11-11';

--3. When is Nightwish's performance in Louisville, and what are their special requests for catering?

SELECT ea.EventDate, a.SpecialRequest
FROM Event_Artist as ea
JOIN Artist as a ON a.ArtistName = ea.ArtistName
WHERE a.ArtistName = 'Nightwish';

--4. Which artists are scheduled to perform in the Bluegrass Evening event on 8.7.2024?

SELECT a.ArtistName
FROM Event_Artist as ea
JOIN Artist as a ON a.ArtistName = ea.ArtistName
WHERE ea.eventName =  'Bluegrass Evening' AND ea.eventDate = '2024-07-08';

--5. What events are coming up this year?

SELECT EventName
FROM Event
WHERE YEAR(EventDate) = 2024;

--6. What dance performances are coming up this year?

SELECT EventName
FROM Event
WHERE EventType = 'dance';

--7. How many tickets have been sold so far for Quest crew's dance performance scheduled for 08.07.2024?

SELECT SUM(NumberOfTickets) AS 'Number of tickets for Quest crew dance performance on 08.07.2024'
FROM Booking as b
JOIN Event AS e ON e.EventName = b.EventName
JOIN Event_Artist AS ea ON ea.EventName = e.EventName
WHERE ea.ArtistName =  'Quest crew' AND e.EventDate = '2024-07-08';

--8. How many tickets remain for Blind Channel's concert on 2.9.2024?

SELECT (v.Capacity - COALESCE(SUM(b.NumberOfTickets), 0)) AS RemainingTickets
FROM Event AS e
JOIN Event_Artist AS ea ON e.EventName = ea.EventName AND e.EventDate = ea.EventDate
JOIN Venue AS v ON e.VenueName = v.VenueName
LEFT JOIN Booking AS b ON e.EventName = b.EventName AND e.EventDate = b.EventDate
WHERE ea.ArtistName = 'Blind Channel' AND e.EventDate = '2024-09-02'
GROUP BY v.Capacity; 

--9. How much revenue has the Louisville Culture Association generated from ticket sales this year?

SELECT SUM(e.Price * b.NumberOfTickets) AS 'Ticket Revenue'
FROM Event e
JOIN Booking b ON e.EventName = b.EventName AND e.EventDate = b.EventDate
WHERE YEAR(e.EventDate) = 2024;
