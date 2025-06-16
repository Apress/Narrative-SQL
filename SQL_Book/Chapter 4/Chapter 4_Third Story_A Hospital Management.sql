

CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    department_id INT
);


INSERT INTO Doctors (doctor_id, name, department_id) VALUES
(1, 'Dr. Alice Smith', 1),
(2, 'Dr. Bob Johnson', 2),
(3, 'Dr. Charlie Lee', 1),
(4, 'Dr. Dana White', 3),
(5, 'Dr. Eve Black', 2);



CREATE TABLE Patients (
    patient_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    primary_doctor_id INT
);


INSERT INTO Patients (patient_id, name, primary_doctor_id) VALUES
(101, 'John Doe', 1),
(102, 'Jane Roe', 2),
(103, 'Jim Beam', NULL),
(104, 'Jack Daniels', 4),
(105, 'Jill Hill', 1);

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY,
    patient_id INT NOT NULL,
    doctor_id INT NOT NULL,
    appointment_date DATE NOT NULL,
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

INSERT INTO Appointments (appointment_id, patient_id, doctor_id, appointment_date) VALUES
(1001, 101, 1, '2024-07-01'),
(1002, 102, 2, '2024-07-02'),
(1003, 103, 3, '2024-07-03'),
(1004, 105, 5, '2024-07-04'),
(1005, 101, 4, '2024-07-05');


CREATE TABLE Departments (
    department_id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

INSERT INTO Departments (department_id, name) VALUES
(1, 'Cardiology'),
(2, 'Neurology'),
(3, 'Orthopedics'),
(4, 'Pediatrics'),
(5, 'Dermatology');


SELECT * FROM  Doctors;

SELECT * FROM  Patients;

SELECT * FROM  Appointments;

SELECT * FROM  Departments;


SELECT a.appointment_id, p.name AS patient_name, d.name AS doctor_name, a.appointment_date 
FROM Appointments a 
INNER JOIN Patients p ON a.patient_id = p.patient_id 
INNER JOIN Doctors d ON a.doctor_id = d.doctor_id; 

SELECT p.name AS patient_name, COALESCE(d.name, 'No Primary Doctor Assigned') AS doctor_name 
FROM Patients p 
LEFT JOIN Doctors d ON p.primary_doctor_id = d.doctor_id; 

SELECT COALESCE(p.name, 'No Patients Assigned') AS patient_name, d.name AS doctor_name 
FROM Patients p 
RIGHT JOIN Doctors d ON p.primary_doctor_id = d.doctor_id; 
