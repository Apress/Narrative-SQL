-- Drop the table first if it already exists
DROP TABLE IF EXISTS Customers;

CREATE TABLE Customers (
    CustomerID INTEGER,                -- Assuming CustomerID is a unique identifier
    FirstName  VARCHAR(255),                --  First and Last names are typically text
    LastName   VARCHAR(255),
    Email      VARCHAR(255),
    DateOfBirth DATE,                    --  Date stored appropriately here.
    Address    VARCHAR(255),
    ZipCode    INTEGER,                 -- Zip codes are numerical
    phoneNumber VARCHAR(20)              --Phone number as a string
);

INSERT INTO Customers (CustomerID, FirstName, LastName, Email, DateOfBirth, Address, ZipCode, phoneNumber)
VALUES
    (1, 'John', 'Doe', 'john.doe@example.com', '1980-05-15', '123 Elm St.', 90210, '(555) 321-9876'),  -- Corrected email and ZIP to match data in the original
    (2, 'Jane', 'Smith', 'jane.smith@example.com', '1975-07-20', '456 Oak Ave.', 90212, '(555) 654-1234'),
    (3, 'Alice', 'Johnson', 'alice.j@example.com', '1990-11-12', '789 Pine Rd.', 90213, '(555) 789-2342');


SELECT FirstName, LastName, Email 
FROM Customers; 


SELECT FirstName AS First, LastName AS Last, Email AS ContactEmail 
FROM Customers; 


SELECT CONCAT(FirstName, ' ', LastName) AS FullName, Email 
FROM Customers; 


