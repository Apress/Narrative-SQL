CREATE TABLE players (
    player_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    age INT,
    nationality VARCHAR(30)
);

INSERT INTO players (name, age, nationality) VALUES
('Tiger Woods', 48, 'USA'),
('Rory McIlroy', 34, 'Northern Ireland'),
('Jon Rahm', 29, 'Spain'),
('Brooks Koepka', 33, 'USA'),
('Dustin Johnson', 40, 'USA'),
('Collin Morikawa', 27, 'USA'),
('Justin Thomas', 31, 'USA'),
('Phil Mickelson', 53, 'USA'),
('Jordan Spieth', 31, 'USA'),
('Viktor Hovland', 26, 'Norway');

CREATE TABLE tournaments (
    tournament_id SERIAL PRIMARY KEY,
    name VARCHAR(50),
    location VARCHAR(50),
    year INT
);

INSERT INTO tournaments (name, location, year) VALUES
('Masters Tournament', 'Augusta National Golf Club', 2023),
('US Open', 'Pebble Beach', 2023),
('The Open Championship', 'St Andrews', 2023),
('PGA Championship', 'Oak Hill', 2023),
('Ryder Cup', 'Marco Simone', 2023);


CREATE TABLE scores (
    score_id SERIAL PRIMARY KEY,
    player_id INT REFERENCES players(player_id),
    tournament_id INT REFERENCES tournaments(tournament_id),
    round_number INT,
    strokes INT
);

INSERT INTO scores (player_id, tournament_id, round_number, strokes) VALUES
(1, 1, 1, 70),
(1, 1, 2, 72),
(2, 1, 1, 68),
(2, 1, 2, 70),
(3, 2, 1, 71),
(3, 2, 2, 69),
(4, 2, 1, 70),
(4, 2, 2, 68),
(5, 3, 1, 73),
(5, 3, 2, 72);

SELECT * FROM players;
SELECT * FROM tournaments;
SELECT * FROM scores;

EXPLAIN SELECT p.name, s.strokes 
FROM scores s 
JOIN players p ON s.player_id = p.player_id 
JOIN tournaments t ON s.tournament_id = t.tournament_id 
WHERE t.name = 'Masters Tournament' AND s.strokes < 70;

EXPLAIN ANALYZE SELECT p.name, AVG(s.strokes) AS avg_strokes 
FROM scores s 
JOIN players p ON s.player_id = p.player_id 
JOIN tournaments t ON s.tournament_id = t.tournament_id 
WHERE t.name = 'US Open' 
GROUP BY p.name;

EXPLAIN SELECT p.name, SUM(s.strokes) AS total_strokes 
FROM scores s 
JOIN players p ON s.player_id = p.player_id 
JOIN tournaments t ON s.tournament_id = t.tournament_id 
WHERE t.name = 'The Open Championship' 
GROUP BY p.name 
ORDER BY total_strokes ASC 
LIMIT 3;

EXPLAIN ANALYZE SELECT t.name, s.round_number, s.strokes 
FROM scores s 
JOIN players p ON s.player_id = p.player_id 
JOIN tournaments t ON s.tournament_id = t.tournament_id 
WHERE p.name = 'Tiger Woods';

