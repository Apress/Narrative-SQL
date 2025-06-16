CREATE TABLE drivers (
    driver_id INTEGER PRIMARY KEY,
    name VARCHAR(15),
    team VARCHAR(12)
);

INSERT INTO drivers (driver_id, name, team) VALUES (1, 'Lewis Hamilton', 'Mercedes');
INSERT INTO drivers (driver_id, name, team) VALUES (2, 'Max Verstappen', 'Red Bull');
INSERT INTO drivers (driver_id, name, team) VALUES (3, 'Charles Leclerc', 'Ferrari');
INSERT INTO drivers (driver_id, name, team) VALUES (4, 'Sergio Perez', 'Red Bull');
INSERT INTO drivers (driver_id, name, team) VALUES (5, 'Carlos Sainz', 'Ferrari');
INSERT INTO drivers (driver_id, name, team) VALUES (6, 'George Russell', 'Mercedes');
INSERT INTO drivers (driver_id, name, team) VALUES (7, 'Lando Norris', 'McLaren');
INSERT INTO drivers (driver_id, name, team) VALUES (8, 'Fernando Alonso', 'Aston Martin');
INSERT INTO drivers (driver_id, name, team) VALUES (9, 'Pierre Gasly', 'Alpine');
INSERT INTO drivers (driver_id, name, team) VALUES (10, 'Esteban Ocon', 'Alpine');

SELECT * FROM  drivers;

CREATE TABLE races (
    race_id INTEGER PRIMARY KEY,
    location VARCHAR(14),
    date VARCHAR(10)
);
-- Data for races table
-- 10 records
INSERT INTO races (race_id, location, date) VALUES (101, 'Silverstone', '2023-07-09');
INSERT INTO races (race_id, location, date) VALUES (102, 'Monza', '2023-09-03');
INSERT INTO races (race_id, location, date) VALUES (103, 'Spa-Francorch.', '2023-07-30');
INSERT INTO races (race_id, location, date) VALUES (104, 'Suzuka', '2023-09-24');
INSERT INTO races (race_id, location, date) VALUES (105, 'Monaco', '2023-05-28');
INSERT INTO races (race_id, location, date) VALUES (106, 'Austin', '2023-10-22');
INSERT INTO races (race_id, location, date) VALUES (107, 'Singapore', '2023-09-17');
INSERT INTO races (race_id, location, date) VALUES (108, 'Interlagos', '2023-11-05');
INSERT INTO races (race_id, location, date) VALUES (109, 'Budapest', '2023-07-23');
INSERT INTO races (race_id, location, date) VALUES (110, 'Melbourne', '2023-04-02');

SELECT * FROM  races;

CREATE TABLE results (
    result_id INTEGER PRIMARY KEY,
    driver_id INTEGER,
    race_id INTEGER,
    position INTEGER,
    lap_time_sec REAL
);
-- Data for results table
-- 10 records
INSERT INTO results (result_id, driver_id, race_id, position, lap_time_sec) VALUES (1, 1, 101, 1, 90.23);
INSERT INTO results (result_id, driver_id, race_id, position, lap_time_sec) VALUES (2, 2, 101, 2, 90.45);
INSERT INTO results (result_id, driver_id, race_id, position, lap_time_sec) VALUES (3, 3, 101, 3, 91.12);
INSERT INTO results (result_id, driver_id, race_id, position, lap_time_sec) VALUES (4, 4, 102, 1, 87.32);
INSERT INTO results (result_id, driver_id, race_id, position, lap_time_sec) VALUES (5, 5, 102, 2, 87.78);
INSERT INTO results (result_id, driver_id, race_id, position, lap_time_sec) VALUES (6, 6, 103, 1, 89.01);
INSERT INTO results (result_id, driver_id, race_id, position, lap_time_sec) VALUES (7, 7, 103, 2, 89.23);
INSERT INTO results (result_id, driver_id, race_id, position, lap_time_sec) VALUES (8, 8, 104, 1, 88.45);
INSERT INTO results (result_id, driver_id, race_id, position, lap_time_sec) VALUES (9, 9, 104, 3, 89.67);
INSERT INTO results (result_id, driver_id, race_id, position, lap_time_sec) VALUES (10, 10, 105, 1, 92.89);

SELECT * FROM  results;




CREATE VIEW top_performers AS
SELECT d.name, r.location, res.position
FROM results res
JOIN drivers d ON res.driver_id = d.driver_id
JOIN races r ON res.race_id = r.race_id
WHERE res.position = 1;


CREATE VIEW avg_lap_time AS
SELECT d.name, AVG(res.lap_time_sec) AS avg_time
FROM results res
JOIN drivers d ON res.driver_id = d.driver_id
GROUP BY d.name;

CREATE VIEW team_wins AS
SELECT d.team, COUNT(*) AS wins
FROM results res
JOIN drivers d ON res.driver_id = d.driver_id
WHERE res.position = 1
GROUP BY d.team;

CREATE VIEW race_winners AS
SELECT d.name, r.location, r.date
FROM results res
JOIN drivers d ON res.driver_id = d.driver_id
JOIN races r ON res.race_id = r.race_id
WHERE res.position = 1;

CREATE VIEW fastest_laps AS
SELECT d.name, r.location, MIN(res.lap_time_sec) AS fastest_time
FROM results res
JOIN drivers d ON res.driver_id = d.driver_id
JOIN races r ON res.race_id = r.race_id
GROUP BY r.location, d.name;

