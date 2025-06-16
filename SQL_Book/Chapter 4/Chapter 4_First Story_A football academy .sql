
CREATE TABLE Players ( 
    PlayerID INT PRIMARY KEY, 
    Name VARCHAR(100), 
    Age INT, 
    Position VARCHAR(50) 
) ;


INSERT INTO Players (PlayerID, Name, Age, Position)
VALUES 
    (1, 'Alex Jones', 17, 'Midfielder'),
    (2, 'Mia Garcia', 16, 'Defender'),
    (3, 'David Lee', 18, 'Forward'),
    (4, 'Sarah Miller', 15, 'Midfielder'),
    (5, 'Chris Brown', 17, 'Defender'),
    (6, 'Emily Sanchez', 16, 'Goalkeeper'),
    (7, 'Ben Johnson', 18, '(Winger)');

CREATE TABLE Matches ( 
    MatchID INT PRIMARY KEY, 
    AgeGroup VARCHAR(10), 
    MinutesPlayed INT 
)   ;
    
INSERT INTO Matches (MatchID, AgeGroup, MinutesPlayed)
VALUES 
    (101, 'U18', 90),
    (102, 'U16', 45),
    (103, 'U18', 90),
    (104, 'U16', 90),
    (105, 'U18', 90),
    (106, 'U16', 90),
    (107, 'U18', 70);  
    
CREATE TABLE MatchDetails ( 
    MatchDetailID INT PRIMARY KEY, 
    MatchID INT, 
    PlayerID INT, 
    GoalsScored INT, 
    FOREIGN KEY (MatchID) REFERENCES Matches(MatchID), 
    FOREIGN KEY (PlayerID) REFERENCES Players(PlayerID) 
) ;

INSERT INTO MatchDetails (MatchDetailID, MatchID, PlayerID, GoalsScored) VALUES
(1, 101, 1, 2),
(2, 101, 2, 2),
(3, 102, 2, 0),
(4, 103, 3, 1),
(5, 103, 4, 2),
(6, 104, 4, 1),
(7, 105, 1, 1),
(8, 105, 5, 0),
(9, 106, 6, 1),
(10, 107, 3, 2),
(11, 107, 7, 1);
   


SELECT * FROM  Players;

SELECT * FROM  Matches;

SELECT * FROM  MatchDetails;

SELECT m.MatchID, p.Name, p.Position 
FROM Matches m 
INNER JOIN MatchDetails md ON m.MatchID = md.MatchID 
INNER JOIN Players p ON p.PlayerID = md.PlayerID ;

SELECT p.Name, SUM(md.GoalsScored) AS TotalGoals 
FROM Players p 
INNER JOIN MatchDetails md ON p.PlayerID = md.PlayerID 
GROUP BY p.Name 
