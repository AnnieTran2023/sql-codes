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
