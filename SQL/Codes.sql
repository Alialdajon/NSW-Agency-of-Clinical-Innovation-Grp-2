Create database PatientSystem; 

DROP TABLE PatientSystem.Login_info;

DROP TABLE PatientSystem.Labels;
DROP TABLE PatientSystem.Tests;
DROP TABLE PatientSystem.Ward;
DROP TABLE PatientSystem.Laboratory;
DROP TABLE PatientSystem.Patient;
DROP TABLE PatientSystem.Staff;
DROP TABLE PatientSystem.Logs_info;



-- Safe Mode
-- On
SET SQL_SAFE_UPDATES = 0;
DELETE FROM PatientSystem.Logs_info;
DELETE FROM PatientSystem.Staff;
-- Off
SET SQL_SAFE_UPDATES = 1;





-- Create tables
CREATE TABLE PatientSystem.Laboratory (
   Lab_id VARCHAR(5) PRIMARY KEY,
   Product_id VARCHAR(5)
);

CREATE TABLE PatientSystem.Patient (
   Patient_id VARCHAR(5) PRIMARY KEY,
   Patient_name VARCHAR(20) NOT NULL,
   Gender VARCHAR(10) NOT NULL,
   Age VARCHAR(2) NOT NULL,
   Phone VARCHAR(15) NOT NULL,
   Address VARCHAR(50) NOT NULL
);
CREATE INDEX idx_patient_age ON PatientSystem.Patient(Age);
CREATE INDEX idx_patient_name ON PatientSystem.Patient(Patient_name);
CREATE INDEX idx_patient_gender ON PatientSystem.Patient(Gender);


CREATE TABLE PatientSystem.Ward (
   Ward_id VARCHAR(5) PRIMARY KEY,
   Patient_id VARCHAR(5),
   Lab_id VARCHAR(5),
   CONSTRAINT fk_ward_patient_id FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
   CONSTRAINT fk_ward_lab_id FOREIGN KEY (Lab_id) REFERENCES Laboratory(Lab_id)
);

CREATE TABLE PatientSystem.Tests (
   Test_id VARCHAR(5) PRIMARY KEY,
   Patient_id VARCHAR(5),
   Test_type CHAR(5) NOT NULL,
   The_field CHAR(20) NOT NULL,
   CONSTRAINT fk_tests_patient_id FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id)
);

CREATE TABLE PatientSystem.Labels (
   Label_id VARCHAR(5) PRIMARY KEY,
   Test_id VARCHAR(5),
   Patient_id VARCHAR(5),
   Patient_name VARCHAR(20),
   Ward_id VARCHAR(5),
   Due_date DATE NOT NULL,
   Medication VARCHAR(40) NOT NULL,
   CONSTRAINT fk_labels_patient_id FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
   CONSTRAINT fk_labels_ward_id FOREIGN KEY (Ward_id) REFERENCES Ward(Ward_id),
   CONSTRAINT fk_labels_tests_id FOREIGN KEY (Test_id) REFERENCES Tests(Test_id)
);

CREATE TABLE PatientSystem.Staff (
   Id_staff VARCHAR(20) PRIMARY KEY,
   Name_staff VARCHAR(20) NOT NULL,
   Phone_number VARCHAR(15) NOT NULL,
   Email VARCHAR(200) NOT NULL,
   Role VARCHAR(100) NOT NULL
);


CREATE TABLE PatientSystem.Logs_info (
   Label_id VARCHAR(5) PRIMARY KEY,
   Id_staff VARCHAR(20),
   Patient_id VARCHAR(5),
   Patient_name VARCHAR(20),
   Patient_age VARCHAR(2),
   Patient_gender VARCHAR(10),
   Test_type VARCHAR(5),
   Ward_id VARCHAR(5),
   CONSTRAINT fk_logs_staff_id FOREIGN KEY (Id_staff) REFERENCES Staff(Id_staff),
   CONSTRAINT fk_logs_patient_id FOREIGN KEY (Patient_id) REFERENCES PatientSystem.Patient(Patient_id),
   CONSTRAINT fk_logs_patient_name FOREIGN KEY (Patient_name) REFERENCES Patient(Patient_name),
   CONSTRAINT fk_logs_patient_age FOREIGN KEY (Patient_age) REFERENCES PatientSystem.Patient(Age),
   CONSTRAINT fk_logs_patient_gender FOREIGN KEY (Patient_gender) REFERENCES Patient(Gender)
);




CREATE TABLE PatientSystem.Login_info (
   Staff_id VARCHAR(20),
   pass VARCHAR(300),
   token VARCHAR(300),
   CONSTRAINT fk_login_info_staff_id FOREIGN KEY (Staff_id) REFERENCES Staff(Id_staff)
);



   
   


-- Insert data
INSERT INTO PatientSystem.Laboratory (Lab_id, Product_id)
VALUES ('L001', 'P4567');

INSERT INTO PatientSystem.Patient (Patient_id, Patient_name, Gender, Age, Phone, Address)
VALUES ('0123', 'Morten Patient', 'Male', '25', 479268987, '19 Elizabeth st');

INSERT INTO PatientSystem.Ward (Ward_id, Patient_id, Lab_id)
VALUES ('A', '0123', 'L001');

INSERT INTO PatientSystem.Tests (Test_id, Patient_id, Test_type, The_field)
VALUES ('T0789', '0123', 'CMB', 'SomeFieldValue');

INSERT INTO PatientSystem.Labels (Label_id, Test_id, Patient_id, Patient_name, Ward_id, Due_date, Medication)
VALUES ('*159', 'T0789', '0123', 'Morten Patient', 'A', '2024-09-10', 'Patient needs A drug');

INSERT INTO PatientSystem.Staff (Id_staff, Name_staff, Phone_number, Email, Role)
VALUES ('S7539', 'Morten Staff', 479987654, 'tokenmessage9@gmail.com', 'Nurse');

INSERT INTO PatientSystem.Logs_info (Label_id, Id_staff, Patient_id, Patient_age, Patient_name, Patient_gender, Test_type, Ward_id)
VALUES ('*159', 'S7539', '0123', '25', 'Morten Patient', 'Male', 'CMB', 'A');

INSERT INTO PatientSystem.Login_info (Staff_id, pass)
VALUES ('S7539', 'securepassword123');




-- Insert into Laboratory
INSERT INTO PatientSystem.Laboratory (Lab_id, Product_id)
VALUES ('L002', 'P9876');

-- Insert into Patient
INSERT INTO PatientSystem.Patient (Patient_id, Patient_name, Gender, Age, Phone, Address)
VALUES ('0456', 'John Doe', 'Male', '32', 498765432, '123 Main St');

-- Insert into Ward
INSERT INTO PatientSystem.Ward (Ward_id, Patient_id, Lab_id)
VALUES ('B', '0456', 'L002');

-- Insert into Tests
INSERT INTO PatientSystem.Tests (Test_id, Patient_id, Test_type, The_field)
VALUES ('T1234', '0456', 'WBC', 'BloodTest');

-- Insert into Labels
INSERT INTO PatientSystem.Labels (Label_id, Test_id, Patient_id, Patient_name, Ward_id, Due_date, Medication)
VALUES ('*160', 'T1234', '0456', 'John Doe', 'B', '2024-09-15', 'Needs medication B');

-- Insert into Staff
INSERT INTO PatientSystem.Staff (Id_staff, Name_staff, Phone_number, Role)
VALUES ('S8541', 'Jane Smith', 459876123, 'Doctor');

-- Insert into Logs_info
INSERT INTO PatientSystem.Logs_info (Label_id, Id_staff, Patient_id, Patient_age, Patient_name, Patient_gender, Test_type, Ward_id)
VALUES ('*160', 'S8541', '0456', '32', 'John Doe', 'Male', 'WBC', 'B');

-- Insert into Login_info
INSERT INTO PatientSystem.Login_info (Staff_id, pass)
VALUES ('S8541', 'password456');



-- Select all from tables to verify
SELECT * FROM PatientSystem.Laboratory;
SELECT * FROM PatientSystem.Patient;
SELECT * FROM PatientSystem.Ward;
SELECT * FROM PatientSystem.Tests;
SELECT * FROM PatientSystem.Labels;
SELECT * FROM PatientSystem.Staff;
SELECT * FROM PatientSystem.Logs_info;
SELECT * FROM PatientSystem.Login_info;
