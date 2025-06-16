
CREATE TABLE Members (
    Member_ID INT PRIMARY KEY,
    First_Name VARCHAR(50) NOT NULL,
    Last_Name VARCHAR(50) NOT NULL,
    Membership_Type VARCHAR(20) NOT NULL,
    Join_Date DATE NOT NULL,
    Date_of_Birth DATE NOT NULL,
    Phone_Number VARCHAR(15)
);


INSERT INTO Members (Member_ID, First_Name, Last_Name, Membership_Type, Join_Date, Date_of_Birth, Phone_Number) VALUES
(1, 'John', 'Doe', 'Premium', '2023-01-10', '1985-02-20', '555-1234'),
(2, 'Jane', 'Smith', 'Standard', '2022-08-15', '1990-05-15', '555-5678'),
(3, 'Emily', 'Johnson', 'Basic', '2023-03-20', '1992-09-05', '555-8765'),
(4, 'Michael', 'Brown', 'Premium', '2021-12-10', '1988-11-23', '555-4321'),
(5, 'Sarah', 'Davis', 'Standard', '2023-06-01', '1987-07-30', '555-6543');


CREATE TABLE Classes (
    Class_ID INT PRIMARY KEY,
    Class_Name VARCHAR(50) NOT NULL,
    Instructor VARCHAR(50) NOT NULL,
    Class_Type VARCHAR(30) NOT NULL,
    Schedule VARCHAR(30) NOT NULL,
    Max_Capacity INT NOT NULL
);


INSERT INTO Classes (Class_ID, Class_Name, Instructor, Class_Type, Schedule, Max_Capacity) VALUES
(1, 'Yoga', 'Alice Green', 'Fitness', 'Mon 9:00 AM', 20),
(2, 'Pilates', 'Bob White', 'Fitness', 'Wed 7:00 PM', 15),
(3, 'Spinning', 'Carol Black', 'Cardio', 'Fri 6:00 PM', 25),
(4, 'Zumba', 'Dave Brown', 'Cardio', 'Sat 10:00 AM', 30),
(5, 'HIIT', 'Eve Silver', 'Strength', 'Tue 8:00 AM', 20);


CREATE TABLE Attendance (
    Attendance_ID INT PRIMARY KEY,
    Member_ID INT NOT NULL,
    Class_ID INT NOT NULL,
    Attendance_Date DATE NOT NULL,
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID),
    FOREIGN KEY (Class_ID) REFERENCES Classes(Class_ID)
);


INSERT INTO Attendance (Attendance_ID, Member_ID, Class_ID, Attendance_Date) VALUES
(1, 1, 3, '2023-08-18'),
(2, 2, 1, '2023-08-19'),
(3, 1, 4, '2023-08-20'),
(4, 3, 2, '2023-08-20'),
(5, 4, 5, '2023-08-21');


CREATE TABLE Personal_Training_Sessions (
    Session_ID INT PRIMARY KEY,
    Trainer_Name VARCHAR(100) NOT NULL,
    Member_ID INT NOT NULL,
    Session_Date DATE NOT NULL,
    Duration_mins INT NOT NULL,
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID)
);


INSERT INTO Personal_Training_Sessions (Session_ID, Trainer_Name, Member_ID, Session_Date, Duration_mins) VALUES
(1, 'Tom Harris', 1, '2023-08-17', 60),
(2, 'Nina Jordan', 2, '2023-08-18', 45),
(3, 'Mike Scott', 3, '2023-08-19', 30),
(4, 'Lisa White', 4, '2023-08-19', 60),
(5, 'Tom Harris', 5, '2023-08-20', 45);


CREATE TABLE Payments (
    Payment_ID INT PRIMARY KEY,
    Member_ID INT NOT NULL,
    Payment_Date DATE NOT NULL,
    Amount DECIMAL(10,2) NOT NULL,
    Payment_Type VARCHAR(100) NOT NULL,
    FOREIGN KEY (Member_ID) REFERENCES Members(Member_ID)
);


INSERT INTO Payments (Payment_ID, Member_ID, Payment_Date, Amount, Payment_Type) VALUES
(1, 1, '2023-08-01', 50.00, 'Membership Fee'),
(2, 2, '2023-08-01', 40.00, 'Membership Fee'),
(3, 1, '2023-08-18', 20.00, 'Class Fee (Spinning)'),
(4, 3, '2023-08-19', 60.00, 'Personal Training Fee'),
(5, 4, '2023-08-20', 50.00, 'Class Fee (HIIT)');

SELECT * FROM  Members;

SELECT * FROM  Classes;

SELECT * FROM  Attendance;

SELECT * FROM  Personal_Training_Sessions;

SELECT * FROM  Payments;


SELECT  Membership_Type, CAST(AVG(DATE_PART('year', AGE(CURRENT_DATE, Date_of_Birth))) AS INTEGER) AS Avg_Age 
FROM Members 
GROUP BY Membership_Type; 

SELECT Trainer_Name,  COUNT(Session_ID) AS Total_Sessions, SUM(Duration_mins) AS Total_Duration 
FROM  Personal_Training_Sessions 
GROUP BY Trainer_Name; 

SELECT Payment_Type, SUM(Amount) AS Total_Revenue 
FROM Payments 
GROUP BY Payment_Type; 

SELECT  C.Class_Name, COUNT(DISTINCT A.Member_ID) AS Number_of_Members, COUNT(A.Attendance_ID) AS Total_Attendances 
FROM  Attendance A 
JOIN Classes C ON A.Class_ID = C.Class_ID 
GROUP BY C.Class_Name; 

SELECT M.Membership_Type, COUNT(DISTINCT M.Member_ID) AS Members_Attended, CAST(AVG(Sub.Class_Attended) AS DECIMAL(10, 2)) AS Avg_Classes_Per_Member 
FROM Members M 
JOIN  
    (SELECT Member_ID, COUNT(Attendance_ID) AS Class_Attended  
     FROM Attendance  
     GROUP BY Member_ID) Sub  
ON M.Member_ID = Sub.Member_ID 
GROUP BY M.Membership_Type; 

SELECT M.Membership_Type, AVG(Sub.Class_Attended) AS Avg_Classes_Per_Member 
FROM Members M 
JOIN (SELECT Member_ID, COUNT(Attendance_ID) AS Class_Attended FROM Attendance GROUP BY Member_ID) AS Sub 
ON M.Member_ID = Sub.Member_ID 
GROUP BY M.Membership_Type; 


