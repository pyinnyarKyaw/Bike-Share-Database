/*Author:  Pyinnyar Kyaw*/                     

DROP TABLE IF EXISTS addd839Journeys;
DROP TABLE IF EXISTS addd839Members;
DROP TABLE IF EXISTS addd839Cycles;
DROP TABLE IF EXISTS addd839Stations;

/* SECTION 1 - CREATE TABLE STATEMENTS */

CREATE TABLE addd839Stations
(
    station_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    post_code  VARCHAR(8) NOT NULL,
    capacity INTEGER NOT NULL
);

CREATE TABLE addd839Cycles
(
    cycle_id INTEGER PRIMARY KEY AUTO_INCREMENT, 
    type ENUM('electric', 'hybrid') NOT NULL, 
    station_id INTEGER, 
    FOREIGN KEY (station_id) REFERENCES addd839Stations(station_id)
);

CREATE TABLE addd839Members
(
    member_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(60) NOT NULL,
    email VARCHAR(100) NOT NULL,
    date_joined DATE NOT NULL,
    membership ENUM('Standard', 'Premium') NOT NULL
);

CREATE TABLE addd839Journeys
(
    journey_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    member_id INTEGER NOT NULL,
    cycle_id INTEGER NOT NULL,
    start_station INTEGER NOT NULL,
    end_station INTEGER NOT NULL,
    date DATE NOT NULL,
    FOREIGN KEY (member_id) REFERENCES addd839Members(member_id),
    FOREIGN KEY (cycle_id) REFERENCES addd839Cycles(cycle_id),
    FOREIGN KEY (start_station) REFERENCES addd839Stations(station_id),
    FOREIGN KEY (end_station) REFERENCES addd839Stations(station_id)
);

/* SECTION 2 - INSERT STATEMENTS */

INSERT INTO addd839Stations (post_code, capacity) VALUES
                            ('SE2 32F', 6),
                            ('SE7 7AE', 5),
                            ('SE5 0LR', 5),
                            ('SW6 1NG', 7),
                            ('SW19 8RT', 7);

INSERT INTO addd839Cycles (type, station_id) VALUES
                            ('hybrid', 1),
                            ('hybrid', 3),
                            ('electric', 5),
                            ('hybrid', 4),
                            ('electric', 3),
                            ('hybrid', 4),
                            ('electric', 2),
                            ('hybrid', 4),
                            ('hybrid', 4),
                            ('electric', 3),
                            ('electric', 5),
                            ('hybrid', 1),
                            ('electric', 3),
                            ('hybrid', 1),
                            ('hybrid', 2),
                            ('hybrid', 4),
                            ('electric', 5),
                            ('electric', 5),
                            ('hybrid', 1),
                            ('hybrid', 5),
                            ('electric', 5),
                            ('electric', 4),
                            ('hybrid', 2),
                            ('electric', 4),
                            ('hybrid', 1),
                            ('hybrid', 1),
                            ('hybrid', 2),
                            ('electric', 2),
                            ('hybrid', 3),
                            ('hybrid', 5),
                            ('hybrid', NULL);
                            
INSERT INTO addd839Members (name, email, date_joined, membership) VALUES
                            ('Roger Jaouad', 'rgjaouad@yahoo.com', 20210404, 'Standard'),
                            ('Elden Krause', 'eldenk@gmail.com', 20210923, 'Premium'),
                            ('John Smith', 'jsmith@hotmail.com', 20211203, 'Standard'),
                            ('Arthur Fly', 'artfly@gmail.com', 20211004, 'Standard'),
                            ('Daniel Watford', 'danwatford@hotmail.com', 20211203, 'Standard'),
                            ('Finn Melik', 'finnmelik@yahoo.com', 20220121, 'Standard'),
                            ('Meriem Duran', 'mduran@gmail.com', 20220715, 'Premium'),
                            ('Jack Williams', 'jackwill@hotmail.com', 20210507, 'Standard'),
                            ('Drew Anthony', 'drewant@yahoo.com', 20211121, 'Premium'),
                            ('Killian Johnson', 'kjohnson@gmail.com', 20210503, 'Standard'),
                            ('Hewitt Lawton', 'hewittl@gmail.com', 20221217, 'Standard'),
                            ('Mike Lee', 'mikelee@gmail.com', 20221008, 'Premium'),
                            ('Jeff Davis', 'jd@hotmail.com', 20211113, 'Premium'),
                            ('Jon Lewis', 'jlewisl@gmail.com', 20220322, 'Standard'),
                            ('Laurel Fowler', 'laurfowler@gmail.com', 20210606, 'Standard'),
                            ('Patrick West', 'pwest@yahoo.com', 20211209, 'Standard'),
                            ('Bob Hanks', 'bobhanks@gmail.com', 20220123, 'Standard');
                            
INSERT INTO addd839Journeys (member_id, cycle_id, start_station, end_station, date) VALUES
                            (13, 3, 3, 5, 20221127),
                            (13, 3, 3, 5, 20221129),
                            (4, 11, 1, 5, 20220319),
                            (9, 12, 3, 1, 20211223),
                            (13, 16, 3, 4, 20221202),
                            (17, 5, 2, 3, 20220711),
                            (17, 23, 3, 2, 20220711),
                            (1, 4, 5, 4, 20220217),
                            (10, 7, 5, 2, 20210910),
                            (14, 18, 4, 5, 20220602),
                            (11, 14, 3, 1, 20220324),
                            (16, 22, 1, 4, 20220519);

/* SECTION 3 - UPDATE STATEMENTS */

/*1*/
UPDATE addd839Members SET membership = 'Premium' WHERE member_id = 3;

/*2*/
UPDATE addd839Stations SET capacity = 7 WHERE station_id = 1;

/* SECTION 4 - SINGLE TABLE SELECT STATEMENTS */

/*1) List the names and date joined of members who have a Premium membership. */

SELECT name, date_joined 
FROM addd839Members 
WHERE membership = 'Premium';

/*2) List the ID of all members who has ended a journey at the station ID 5. List each member only once. */

SELECT DISTINCT(member_id)
FROM addd839Journeys
WHERE end_station = 5;

/*3) List the names of all members who use a Gmail email. */

SELECT name
FROM addd839Members
WHERE email LIKE '%gmail%';

/*4) List the IDs of any cycles that are currently not in a station. Change the name of the output column to 'on journey or missing'. */

SELECT cycle_id AS 'on journey or missing'
FROM addd839Cycles
WHERE station_id IS NULL;

/*5) List all the details of members who joined in December 2021*/

SELECT *
FROM addd839Members
WHERE date_joined >= 20211201 AND date_joined <= 20211231;

/*6) How many electric cycles are there in total? */

SELECT COUNT(type)
FROM addd839Cycles WHERE type = 'electric';


/* SECTION 5 - MULTIPLE TABLE SELECT STATEMENTS */


/*1) List the IDs of members who have ridden an electric cycle. List each member only once. */

SELECT DISTINCT(member_id)
FROM addd839Journeys
WHERE cycle_id
IN (SELECT cycle_id
   FROM addd839Cycles
   WHERE type = 'electric');

/*2) On which dates did the member 'Jeff Davis' journey to the station at postcode SW19 8RT? Dates can be output in their stored format. */

SELECT date
FROM addd839Journeys j, addd839Members m, addd839Stations s
WHERE j.end_station = s.station_id
AND s.post_code = 'SW19 8RT'
AND j.member_id = m.member_id
AND m.name = 'Jeff Davis';


/*3) List the names and number of journeys made for each member. */

SELECT m.name, COUNT(j.journey_id) 
FROM addd839Members m LEFT JOIN addd839Journeys j 
ON m.member_id = j.member_id 
GROUP BY m.member_id;


/*4) List the names, date, start station and end station for all journeys made by each member - except for the ones who haven't made any journeys. */

SELECT m.name, j.date, j.start_station, j.end_station
FROM addd839Members m INNER JOIN addd839Journeys j 
ON m.member_id = j.member_id;

/*5) List the names, date, start station and end station for all journeys taken by Standard members, sorted in descending order by date. */

SELECT m.name, j.date, j.start_station, j.end_station
FROM addd839Members m INNER JOIN addd839Journeys j 
ON m.member_id = j.member_id
WHERE m.member_id
IN (SELECT member_id FROM addd839Members WHERE membership = 'Standard')
ORDER BY j.date DESC;

/*6) List the post code and number of electric cycles in each station sorted in descending order by number of electric cycles. Exclude stations without any electric cycles. */

SELECT s.post_code, COUNT(c.cycle_id) AS num_ebikes
FROM addd839Stations s INNER JOIN addd839Cycles c 
ON s.station_id = c.station_id
WHERE c.type = 'electric'
GROUP BY s.station_id
ORDER BY num_ebikes DESC;

/* SECTION 6 - DELETE ROWS (make sure the SQL is commented out in this section)

DELETE FROM addd839Members WHERE member_id = 5;

DELETE FROM addd839Journeys WHERE journey_id = 5;

*/

/* SECTION 7 - DROP TABLES (make sure the SQL is commented out in this section)

DROP TABLE addd839Journeys;
DROP TABLE addd839Members;
DROP TABLE addd839Cycles;
DROP TABLE addd839Stations;

*/