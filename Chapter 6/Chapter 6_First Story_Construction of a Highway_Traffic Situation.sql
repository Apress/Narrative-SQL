
CREATE TABLE TrafficData_Before (
    Route_ID INT PRIMARY KEY,
    Route_Name VARCHAR(255),
    Vehicle_Count INT,
    Avg_Travel_Time VARCHAR(50),
    Congestion_Level VARCHAR(50),
    Data_Date DATE
);

INSERT INTO TrafficData_Before (Route_ID, Route_Name, Vehicle_Count, Avg_Travel_Time, Congestion_Level, Data_Date) VALUES
(1, 'Valley Road', 2500, '45 min', 'High', '2022-06-01'),
(2, 'Riverside Ave', 1800, '38 min', 'Moderate', '2022-06-01'),
(3, 'Main Street', 3000, '50 min', 'High', '2022-06-01'),
(4, '5th Avenue', 2200, '40 min', 'High', '2022-06-01'),
(5, 'Oakwood Blvd', 1600, '35 min', 'Moderate', '2022-06-01'),
(6, 'Park Lane', 1300, '30 min', 'Low', '2022-06-01'),
(7, 'Maple Drive', 1700, '32 min', 'Low', '2022-06-01'),
(8, 'Birch Street', 1900, '42 min', 'Moderate', '2022-06-01'),
(9, 'Sunset Blvd', 2800, '48 min', 'High', '2022-06-01'),
(10, 'Cedar Road', 2100, '37 min', 'Moderate', '2022-06-01');


SELECT * FROM TrafficData_Before;



CREATE TABLE TrafficData_After (
    Route_ID INT PRIMARY KEY,
    Route_Name VARCHAR(255),
    Vehicle_Count INT,
    Avg_Travel_Time VARCHAR(50),
    Congestion_Level VARCHAR(50),
    Data_Date DATE
);


INSERT INTO TrafficData_After (Route_ID, Route_Name, Vehicle_Count, Avg_Travel_Time, Congestion_Level, Data_Date) VALUES
(1, 'Valley Road', 2000, '30 min', 'Moderate', '2023-06-01'),
(2, 'Riverside Ave', 1500, '28 min', 'Low', '2023-06-01'),
(3, 'Main Street', 2500, '40 min', 'Moderate', '2023-06-01'),
(4, '5th Avenue', 1800, '35 min', 'Moderate', '2023-06-01'),
(5, 'Oakwood Blvd', 1400, '25 min', 'Low', '2023-06-01'),
(6, 'Park Lane', 1200, '27 min', 'Low', '2023-06-01'),
(7, 'Maple Drive', 1600, '29 min', 'Low', '2023-06-01'),
(8, 'Birch Street', 1700, '31 min', 'Moderate', '2023-06-01'),
(9, 'Sunset Blvd', 2300, '37 min', 'Moderate', '2023-06-01'),
(10, 'Cedar Road', 1900, '32 min', 'Moderate', '2023-06-01');

SELECT * FROM TrafficData_After;


-- Top 5 most congested routes before the highway construction 
SELECT Route_Name, Vehicle_Count, Avg_Travel_Time, Congestion_Level 
FROM TrafficData_Before 
ORDER BY Congestion_Level DESC, Vehicle_Count DESC 
LIMIT 5; 

-- Top 5 most congested routes after the highway construction 
SELECT Route_Name, Vehicle_Count, Avg_Travel_Time, Congestion_Level 
FROM TrafficData_After 
ORDER BY Congestion_Level DESC, Vehicle_Count DESC 
LIMIT 5; 

SELECT Route_Name, Vehicle_Count, Avg_Travel_Time, Congestion_Level 
FROM TrafficData_After 
ORDER BY  
  CASE  
    WHEN Congestion_Level = 'High' THEN 1 
    WHEN Congestion_Level = 'Moderate' THEN 2 
    WHEN Congestion_Level = 'Low' THEN 3 
  END, 
  Vehicle_Count DESC 
LIMIT 5; 

SELECT AVG(CAST(SUBSTRING(Avg_Travel_Time FROM '^[0-9]+') AS INT)) AS Avg_Travel_Time_Before 
FROM TrafficData_Before;


SELECT AVG(CAST(SUBSTRING(Avg_Travel_Time FROM '^[0-9]+') AS INT)) AS Avg_Travel_Time_After 
FROM TrafficData_After;


SELECT Route_Name, Vehicle_Count, Avg_Travel_Time, Congestion_Level 
FROM TrafficData_After 
WHERE Data_Date BETWEEN '2023-05-01' AND '2023-06-01' 
ORDER BY Avg_Travel_Time ASC 
LIMIT 5; 


SELECT Route_Name, Congestion_Level 
FROM TrafficData_Before 
WHERE Congestion_Level = 'High' 
UNION 
SELECT Route_Name, Congestion_Level 
FROM TrafficData_After 
WHERE Congestion_Level = 'High'; 

