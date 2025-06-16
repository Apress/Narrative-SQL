CREATE TABLE players (
  player_id INT,
  name varchar(255),
  age INT,
  position varchar(255),
  goals_scored FLOAT,
  assists INT,
  games_played FLOAT
);

INSERT INTO players (player_id, name, age, position, goals_scored, assists, games_played)
VALUES
    (1, 'Alex Jones', 16, 'Midfielder', 8, 3, 12),
    (2, 'Ben Miller', 18, 'Defender', 1, 2, 10),
    (3, 'Charlie Brown', 17, 'Forward', 12, 1, 15),
    (4, 'David Lee', 15, 'Midfielder', 5, 4, 8),
    (5, 'Emily Garcia', 16, 'Defender', 0, 1, 7),
    (6, 'Faye Williams', 17, 'Forward', 7, 2, 11),
    (7, 'George Smith', 18, 'Midfielder', 4, 5, 9),
    (8, 'Hannah Davis', 15, 'Defender', 2, 0, 5),
    (9, 'Isabella Moore', 16, 'Forward', 9, 3, 14),
    (10, 'Jack Robinson', 18, 'Defender', 3, 1, 12),
    (11, 'Kevin Thomas', 17, 'Midfielder', 6, 4, 10),
    (12, 'Lily Johnson', 15, 'Forward', 4, 2, 8);
    
SELECT * FROM  Players;    

SELECT COUNT(*) 
FROM Players 
WHERE age < 17 AND goals_scored > 5; 

SELECT name, goals_scored, games_played, (goals_scored / games_played) AS goal_scoring_average 
FROM Players 
WHERE games_played >= 10 AND (goals_scored / games_played) > 0.5 ;

SELECT name, goals_scored 
FROM Players 
WHERE goals_scored > (SELECT AVG(goals_scored) FROM Players); 

SELECT name, age, assists 
FROM Players 
WHERE age < 17 AND assists > (SELECT AVG(assists) FROM Players WHERE age = 18); 


