
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    Name VARCHAR(100),
    Age INT CHECK (Age > 0),
    Position VARCHAR(50),
    DepartmentID INT,
    ManagerID INT,
    FOREIGN KEY (ManagerID) REFERENCES Employees(EmployeeID)
    -- DepartmentID can reference a Departments table if defined
);

INSERT INTO Employees (EmployeeID, Name, Age, Position, DepartmentID, ManagerID) VALUES
(1, 'John Smith', 45, 'CEO', NULL, NULL),
(2, 'Jane Dylan', 38, 'CTO', 1, 1),
(3, 'Mary Johnson', 28, 'Developer', 1, 2),
(4, 'Mike Brown', 35, 'Developer', 1, 2),
(5, 'Emily Davis', 30, 'HR Manager', 2, 1),
(6, 'Laura Wilson', 25, 'HR Associate', 2, 5),
(7, 'David White', 50, 'CFO', 3, 1),
(8, 'Steve Black', 40, 'Accountant', 3, 7);


CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100)
);


INSERT INTO Departments (DepartmentID, DepartmentName) VALUES
(1, 'Engineering'),
(2, 'Human Resources'),
(3, 'Finance');


CREATE TABLE Projects  (
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) ,
    DepartmentID INT ,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

INSERT INTO Projects  (ProjectID, ProjectName, DepartmentID) VALUES
(101, 'Project Alpha', 1),
(102, 'Project Beta', 1),
(201, 'Recruitment Drive', 2),
(301, 'Financial Audit', 3);

CREATE TABLE Employees_Projects (
    EmployeeID INT,
    ProjectID INT,
    PRIMARY KEY (EmployeeID, ProjectID),
    FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Projects(ProjectID)
);

INSERT INTO Employees_Projects (EmployeeID, ProjectID) VALUES
(3, 101),
(4, 101),
(3, 102),
(4, 102),
(6, 201),
(8, 301);


SELECT * FROM  Employees;

SELECT * FROM Departments;

SELECT * FROM  Projects ;

SELECT * FROM  Employees_Projects ;

SELECT e1.Name AS EmployeeName, e2.Name AS ManagerName 
FROM Employees e1 
LEFT JOIN Employees e2 ON e1.ManagerID = e2.EmployeeID ;

SELECT d.DepartmentName, e.Name AS EmployeeName 
FROM Departments d 
LEFT JOIN Employees e ON d.DepartmentID = e.DepartmentID ;

SELECT e.Name AS EmployeeName, p.ProjectName 
FROM Employees e 
RIGHT JOIN Employees_Projects ep ON e.EmployeeID = ep.EmployeeID 
RIGHT JOIN Projects p ON ep.ProjectID = p.ProjectID;



SELECT e.Name AS EmployeeName, p.ProjectName 
FROM Employees e 
RIGHT JOIN Employees_Projects ep ON e.EmployeeID = ep.EmployeeID 
RIGHT JOIN Projects p ON ep.ProjectID = p.ProjectID 
WHERE e.EmployeeID IS NOT NULL ;

SELECT p.ProjectName, d.DepartmentName 
FROM Projects p 
RIGHT JOIN Departments d ON p.DepartmentID = d.DepartmentID 
WHERE p.ProjectID IS NOT NULL; 


SELECT e.Name AS EmployeeName, p.ProjectName 
FROM Employees e 
CROSS JOIN Projects p; 

SELECT e.Name AS EmployeeName 
FROM Employees e 
LEFT JOIN Employees_Projects ep ON e.EmployeeID = ep.EmployeeID 
WHERE ep.ProjectID IS NULL; 



