
CREATE TABLE HashtagUsage (
    Hashtag	 VARCHAR(255),
    Likes	 INT,
    Comments	 INT
);

INSERT INTO HashtagUsage (Hashtag, Likes, Comments)
VALUES
  ('#adventure', 150, 30),
  ('#adventure', 200, 45),
  ('#foodie', 300, 60),
  ('#travel', 250, 50),
  ('#foodie', 180, 20),
  ('#staycation', 190, 40);

SELECT * FROM HashtagUsage;  

      
SELECT COUNT(*) AS TotalHashtags 
FROM HashtagUsage;


SELECT COUNT(DISTINCT Hashtag) AS DistinctHashtags 
FROM HashtagUsage;


SELECT AVG(Likes) AS AverageLikes, AVG(Comments) AS AverageComments 
FROM HashtagUsage ;


SELECT MAX(Likes) AS MaxLikes, MAX(Comments) AS MaxComments 
FROM HashtagUsage ;


SELECT MIN(Likes) AS MinLikes, MIN(Comments) AS MinComments 
FROM HashtagUsage; 