
CREATE TABLE hospital_admissions (
    patient_id INT PRIMARY KEY,
    age INT,
    diagnosis_code INT,
    admission_date DATE,
    discharge_date DATE
);


INSERT INTO hospital_admissions (patient_id, age, diagnosis_code, admission_date, discharge_date) VALUES
(1, 12, 150, '2024-03-01', '2024-03-03'),
(2, 45, 120, '2024-03-02', '2024-03-05'),
(3, 67, 180, '2024-03-03', '2024-03-10'),
(4, 8, 90, '2024-03-04', '2024-03-06'),
(5, 32, 110, '2024-03-05', '2024-03-08'),
(6, 55, 130, '2024-03-06', '2024-03-12'),
(7, 70, 140, '2024-03-07', NULL),
(8, 25, 160, '2024-03-08', '2024-03-11'),
(9, 40, 170, '2024-03-09', '2024-03-16'),
(10, 60, 190, '2024-03-10', '2024-03-20'),
(11, 15, NULL, '2024-03-11', '2024-03-13'),
(12, 50, 200, '2024-03-12', NULL),
(13, 28, 105, '2024-03-13', '2024-03-15'),
(14, 72, NULL, '2024-03-14', '2024-03-21'),
(15, 10, 115, '2024-03-15', NULL),
(16, 35, 125, '2024-03-16', '2024-03-18'),
(17, 65, 135, '2024-03-17', '2024-03-24'),
(18, 22, 145, '2024-03-18', '2024-03-20'),
(19, 48, 155, '2024-03-19', NULL),
(20, 58, 165, '2024-03-20', '2024-03-27');


SELECT  
    patient_id,  
    age, 
    CASE  
        WHEN age < 18 THEN 'Child' 
        WHEN age BETWEEN 18 AND 64 THEN 'Adult' 
        WHEN age >= 65 THEN 'Senior' 
        ELSE 'Unknown' 
    END AS age_group 
FROM hospital_admissions 
ORDER BY age_group; 



SELECT  
    patient_id,  
    diagnosis_code,  
    admission_date,  
    discharge_date 
FROM hospital_admissions 
WHERE diagnosis_code BETWEEN 100 AND 199 
  AND admission_date >= '2024-01-01'  
  AND admission_date <= '2024-12-31'; 


SELECT  
    CASE  
        WHEN diagnosis_code BETWEEN 100 AND 125 THEN '100-125' 
        WHEN diagnosis_code BETWEEN 126 AND 150 THEN '126-150' 
        WHEN diagnosis_code BETWEEN 151 AND 175 THEN '151-175' 
        WHEN diagnosis_code BETWEEN 176 AND 199 THEN '176-199' 
        ELSE 'Unknown' 
    END AS diagnosis_code_range, 
    COUNT(patient_id) AS patient_count, 
    AVG(COALESCE(discharge_date, admission_date + INTERVAL '2 days') - admission_date) AS avg_length_of_stay 
FROM hospital_admissions 
WHERE diagnosis_code BETWEEN 100 AND 199 
  AND admission_date >= '2024-01-01'  
  AND admission_date <= '2024-12-31' 
GROUP BY diagnosis_code_range 
ORDER BY diagnosis_code_range; 

SELECT  
    patient_id,  
    age,  
    (discharge_date - admission_date) AS length_of_stay, 
    CASE  
        WHEN (discharge_date - admission_date) < 3 THEN 'Short Stay' 
        WHEN (discharge_date - admission_date) BETWEEN 3 AND 7 THEN 'Moderate Stay' 
        WHEN (discharge_date - admission_date) > 7 THEN 'Long Stay' 
        ELSE 'Unknown' 
    END AS stay_category 
FROM hospital_admissions; 


SELECT  
    CASE  
        WHEN age < 18 THEN 'Child' 
        WHEN age BETWEEN 18 AND 64 THEN 'Adult' 
        WHEN age >= 65 THEN 'Senior' 
        ELSE 'Unknown' 
    END AS age_group, 
    COUNT(patient_id) AS total_patients, 
    AVG(discharge_date - admission_date) AS avg_length_of_stay 
FROM hospital_admissions 
GROUP BY age_group 
ORDER BY age_group; 


SELECT  
    patient_id,  
    age,  
    admission_date,  
    COALESCE(discharge_date, admission_date + INTERVAL '2 days') AS clean_discharge_date, 
    GREATEST(0, EXTRACT(DAY FROM COALESCE(discharge_date, admission_date + INTERVAL '2 days') - admission_date)) AS clean_length_of_stay 
FROM hospital_admissions 
WHERE EXTRACT(DAY FROM COALESCE(discharge_date, admission_date + INTERVAL '2 days') - admission_date) <= 365; 

