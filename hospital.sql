
-- 1. RESET TABLES (FOR TESTING ONLY)

DROP TABLE IF EXISTS patients;
DROP TABLE IF EXISTS doctors;
DROP TABLE IF EXISTS departments;

-- Enable foreign key enforcement
PRAGMA foreign_keys = ON;

-- 2. CREATE DEPARTMENTS TABLE

CREATE TABLE departments (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    location TEXT NOT NULL
);

-- 3. CREATE DOCTORS TABLE

CREATE TABLE doctors (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    department_id INTEGER NOT NULL,
    specialization TEXT NOT NULL,
    FOREIGN KEY (department_id)
        REFERENCES departments(id)
        ON DELETE CASCADE
);

-- 4. CREATE PATIENTS TABLE

CREATE TABLE patients (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    age INTEGER NOT NULL,
    medical_condition TEXT NOT NULL,
    assigned_doctor_id INTEGER,
    FOREIGN KEY (assigned_doctor_id)
        REFERENCES doctors(id)
        ON DELETE SET NULL
);

-- 5. INSERT DEPARTMENTS

INSERT INTO departments (name, location)
VALUES ('Cardiology', 'Block A, 2nd Floor');

INSERT INTO departments (name, location)
VALUES ('Pediatrics', 'Block B, 1st Floor');

INSERT INTO departments (name, location)
VALUES ('Orthopedics', 'Block C, Ground Floor');

-- 6. INSERT DOCTORS

INSERT INTO doctors (name, department_id, specialization)
VALUES ('Dr. Alice Johnson', 1, 'Cardiologist');

INSERT INTO doctors (name, department_id, specialization)
VALUES ('Dr. Bob Williams', 2, 'Pediatrician');

INSERT INTO doctors (name, department_id, specialization)
VALUES ('Dr. Charlie Brown', 3, 'Orthopedic Surgeon');


-- 7. INSERT PATIENTS

INSERT INTO patients
    (name, age, medical_condition, assigned_doctor_id)
VALUES
    ('John Smith', 45, 'Chest Pain', 1);

INSERT INTO patients
    (name, age, medical_condition, assigned_doctor_id)
VALUES
    ('Emma Watson', 8, 'Fever & Cough', 2);

INSERT INTO patients
    (name, age, medical_condition, assigned_doctor_id)
VALUES
    ('David Miller', 30, 'Broken Arm', 3);

INSERT INTO patients
    (name, age, medical_condition, assigned_doctor_id)
VALUES
    ('Sophia Taylor', 62, 'High Blood Pressure', 1);

-- 8. SELECT PATIENTS AND THEIR DOCTORS

SELECT
    patients.name AS patient_name,
    patients.age,
    patients.medical_condition,
    doctors.name AS doctor_name,
    doctors.specialization
FROM patients
JOIN doctors
    ON patients.assigned_doctor_id = doctors.id;

-- 9. SELECT DOCTORS AND THEIR DEPARTMENTS

SELECT
    doctors.name AS doctor_name,
    doctors.department_id,
    departments.name AS department_name
FROM doctors
JOIN departments
    ON doctors.department_id = departments.id;


-- 10. SELECT PATIENTS WITHOUT A DOCTOR

SELECT
    name,
    age,
    medical_condition
FROM patients
WHERE assigned_doctor_id IS NULL;
