CREATE DATABASE healthcare;
USE healthcare;

CREATE TABLE patients (
    patient_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender VARCHAR(10),
    date_of_birth DATE,
    contact_number VARCHAR(20),
    address VARCHAR(200),
    registration_date DATE,
    insurance_provider VARCHAR(100),
    insurance_number VARCHAR(20),
    email VARCHAR(100)
);

CREATE TABLE doctors (
    doctor_id VARCHAR(10) PRIMARY KEY,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    specialization VARCHAR(100),
    phone_number VARCHAR(20),
    years_experience INT,
    hospital_branch VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE appointments (
    appointment_id VARCHAR(10) PRIMARY KEY,
    patient_id VARCHAR(10),
    doctor_id VARCHAR(10),
    appointment_date DATE,
    appointment_time TIME,
    reason_for_visit VARCHAR(200),
    status VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES doctors(doctor_id)
);

-- 3. TREATMENTS (depends on appointments)
CREATE TABLE treatments (
    treatment_id VARCHAR(10) PRIMARY KEY,
    appointment_id VARCHAR(10),
    treatment_type VARCHAR(100),
    description VARCHAR(200),
    cost DECIMAL(10,2),
    treatment_date DATE,
    FOREIGN KEY (appointment_id) REFERENCES appointments(appointment_id)
);

-- 4. BILLING (depends on patients & treatments)
CREATE TABLE billing (
    bill_id VARCHAR(10) PRIMARY KEY,
    patient_id VARCHAR(10),
    treatment_id VARCHAR(10),
    bill_date DATE,
    amount DECIMAL(10,2),
    payment_method VARCHAR(50),
    payment_status VARCHAR(50),
    FOREIGN KEY (patient_id) REFERENCES patients(patient_id),
    FOREIGN KEY (treatment_id) REFERENCES treatments(treatment_id)
);

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/4_patients.csv'
INTO TABLE patients
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/4_doctors.csv'
INTO TABLE doctors
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/4_appointments.csv'
INTO TABLE appointments
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/4_treatments.csv'
INTO TABLE treatments
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/4_billing.csv'
INTO TABLE billing
FIELDS TERMINATED BY ',' ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;


SELECT * FROM patients;
SELECT * FROM doctors;
SELECT * FROM appointments;
SELECT * FROM billing;
SELECT * FROM treatments;



-- AVERAGE AGE OF PATIENT BY GENDER

SELECT 
    gender,
    ROUND(AVG(TIMESTAMPDIFF(YEAR, date_of_birth, CURDATE())), 1) AS avg_age
FROM patients
GROUP BY gender; 

-- DOCTORS WITH HIGHEST YEARS OF EXPERIENCE 

SELECT first_name , years_experience 
FROM doctors
GROUP BY 1,2
ORDER BY 2 DESC;

--  number of appointments that are Scheduled vs Completed vs Cancelled

SELECT COUNT(*) AS TOTAL_NUMBER , `status` 
FROM appointments
WHERE `status` != 'No-show'
GROUP BY 2
ORDER BY 1 DESC;

-- APPOINTMENTS WITH PATIENT AND DOCTOR 
SELECT 
    a.appointment_id,
    CONCAT(p.first_name, ' ', p.last_name) AS patient_name,
    CONCAT(d.first_name, ' ', d.last_name) AS doctor_name,
    a.appointment_date,
    a.status
FROM appointments a
JOIN patients p ON p.patient_id = a.patient_id
JOIN doctors d ON d.doctor_id = a.doctor_id;

-- DOCTORS WHICH HAVE TREATED THE MOST PATIENTS
SELECT 
	CONCAT(d.first_name,' ',d.last_name) as doctor_name,
    COUNT(DISTINCT a.appointment_id) as total_patient
FROM doctors d
JOIN appointments a ON a.doctor_id = d.doctor_id
GROUP BY 1
ORDER BY 2 DESC;

-- NO OF PATIENTS WITHOUT AN APPOINTMENT

SELECT p.first_name , p.patient_id FROM patients p
LEFT JOIN appointments a ON a.patient_id = p.patient_id
WHERE a.appointment_id IS NULL;  -- 2 patient

-- the total treatment cost per doctor
SELECT 
    d.first_name,
    SUM(t.cost) as Cost_per_doc,
    ROUND(AVG(t.COST),2) AS AVG_COST_PER_DOC
FROM doctors d
JOIN appointments a ON a.doctor_id = d.doctor_id
JOIN treatments t ON t.appointment_id = a.appointment_id
GROUP BY 1
ORDER BY 2 DESC;

-- PATIENTS WITH PENDING PAYMENTS
SELECT p.patient_id,
 p.first_name,
 b.amount,
 b.payment_status  FROM patients p
JOIN billing b ON b.patient_id = p.patient_id
WHERE b.payment_status = 'pending'
ORDER BY 3 DESC;


-- PATIENTS WHO VISITED THE DOCTOR MORE THAN ONCE
SELECT 
    p.patient_id,
    CONCAT(p.first_name,' ',p.last_name) as patient_name,
    d.doctor_id,
    CONCAT(d.first_name,' ',d.last_name) as doctor_name,
    COUNT(a.appointment_id) as TOTAL_VISIT
FROM doctors d
JOIN appointments a ON a.doctor_id = d.doctor_id
LEFT JOIN patients p ON p.patient_id = a.patient_id
GROUP BY 1,2,3,4
HAVING TOTAL_VISIT > 1
ORDER BY 5 DESC;


--  TOP 3 DOCTORS WITH TOTAL REVENUE
WITH doctor_revenue AS (
	SELECT d.doctor_id,	
		d.first_name,
        SUM(b.amount) as TOTAL_REVENUE
	FROM doctors d
	JOIN appointments a ON a.doctor_id = d.doctor_id
    JOIN billing b ON b.patient_id = a.patient_id
    GROUP BY 1,2
) 
SELECT * FROM doctor_revenue
ORDER BY 3 DESC
LIMIT 3;

-- PATIENTS WHO SPENT ABOVE AVERAGE THAN THE COST 

WITH AVERAGE_BILLING AS (	
    SELECT AVG(amount) AS AVG_AMOUNT FROM billing 
),
PATIENT_BILLING AS (
	SELECT patient_id, SUM(amount) as TOTAL_AMOUNT FROM billing
    GROUP BY 1
)
SELECT * FROM AVERAGE_BILLING , PATIENT_BILLING
WHERE TOTAL_AMOUNT > AVG_AMOUNT;

-- THE MOST COMMON TREATMENT TYPE PER DOCTOR
WITH TREATMENT_COUNTS AS (
    SELECT d.doctor_id,
		t.treatment_type,
        COUNT(*) AS TOTAL,
        RANK() OVER(PARTITION BY d.doctor_id ORDER BY COUNT(*) DESC) AS `RANK`
	FROM treatments t
    JOIN appointments a ON a.appointment_id = t.appointment_id
    JOIN doctors d ON d.doctor_id = a.doctor_id
    GROUP BY 1,2
)
SELECT * FROM TREATMENT_COUNTS 
WHERE `RANK` = 1;
