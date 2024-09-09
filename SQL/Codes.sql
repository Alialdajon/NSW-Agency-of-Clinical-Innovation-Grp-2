

-- Create Laboratory Table
CREATE TABLE Laboratory (
   Lab_id VARCHAR2(5) PRIMARY KEY,
   Product_id VARCHAR2(5)
);

-- Create Patient Table
CREATE TABLE Patient (
   Patient_id VARCHAR2(5) PRIMARY KEY,
   Patient_name VARCHAR2(20) NOT NULL,
   Gender VARCHAR2(10) NOT NULL,
   Phone VARCHAR2(15) NOT NULL,  
   Address VARCHAR2(50) NOT NULL 
);

-- Create Ward Table
CREATE TABLE Ward (
   Ward_id VARCHAR2(5) PRIMARY KEY,
   Patient_id VARCHAR2(5),
   Lab_id VARCHAR2(5),
   CONSTRAINT fk_ward_patient_id FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
   CONSTRAINT fk_ward_lab_id FOREIGN KEY (Lab_id) REFERENCES Laboratory(Lab_id)
);

-- Create Tests Table
CREATE TABLE Tests(
   Test_id VARCHAR2(5) PRIMARY KEY,
   Patient_id VARCHAR2(5),
   Test_type VARCHAR2(20) NOT NULL,  
   The_field VARCHAR2(20) NOT NULL,
   CONSTRAINT fk_tests_patient_id FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id)
);

-- Create Labels Table
CREATE TABLE Labels (
   Label_id VARCHAR2(5) PRIMARY KEY,
   Test_id VARCHAR2(5),
   Patient_id VARCHAR2(5),
   Patient_name VARCHAR2(20),
   Ward_id VARCHAR2(5),
   Due_date VARCHAR2(10) NOT NULL, 
   Medication VARCHAR2(40) NOT NULL,
   CONSTRAINT fk_labels_patient_id FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
   CONSTRAINT fk_labels_patient_name FOREIGN KEY (Patient_name) REFERENCES Patient(Patient_name),
   CONSTRAINT fk_labels_ward_id FOREIGN KEY (Ward_id) REFERENCES Ward(Ward_id),
   CONSTRAINT fk_labels_test_id FOREIGN KEY (Test_id) REFERENCES Tests(Test_id)
);

-- Create Staff Table
CREATE TABLE Staff (
   Id_staff VARCHAR2(20) PRIMARY KEY,
   Name_staff VARCHAR2(20) NOT NULL,
   Phone_number VARCHAR2(15) NOT NULL,  
   Role VARCHAR2(100) NOT NULL
);

-- Create Logs Table
CREATE TABLE Logs (
   Label_id VARCHAR2(5), 
   Id_staff VARCHAR2(20),
   Time_edited VARCHAR2(20) NOT NULL,
   Changes_made VARCHAR2(100) NOT NULL,
   CONSTRAINT fk_logs_staff_id FOREIGN KEY (Id_staff) REFERENCES Staff(Id_staff),
   CONSTRAINT fk_logs_label_id FOREIGN KEY (Label_id) REFERENCES Labels(Label_id)
);


-- Insert data into the tables in the correct order
-- Insert data into Laboratory
INSERT INTO Laboratory (Lab_id, Product_id)
VALUES ('L001', 'P4567');

-- Insert data into Patient
INSERT INTO Patient (Patient_id, Patient_name, Gender, Phone, Address)
VALUES ('0123', 'Morten Naive', 'Male', '0479268987', '19 Elizabeth st');

-- Insert data into Ward
INSERT INTO Ward (Ward_id, Patient_id, Lab_id)
VALUES ('A', '0123', 'L001');

-- Insert data into Tests
INSERT INTO Tests (Test_id, Patient_id, Test_type, The_field)
VALUES ('T0789', '0123', 'Transplant', 'SomeFieldValue');

-- Insert data into Labels
INSERT INTO Labels (Label_id, Test_id, Patient_id, Patient_name, Ward_id, Due_date, Medication)
VALUES ('*159', 'T0789', '0123', 'Morten Naive', 'A', '2024-09-10', 'Patient needs A drug');

-- Insert data into Staff
INSERT INTO Staff (Id_staff, Name_staff, Phone_number, Role)
VALUES ('S7539', 'Morten Smart', '0479987654', 'Nurse');

-- Insert data into Logs
INSERT INTO Logs (Label_id, Id_staff, Time_edited, Changes_made)
VALUES ('*159', 'S7539', '2024-09-05', 'Print. Reprint');

-- Select all from Laboratory
SELECT * FROM Laboratory;

-- Select all from Patient
SELECT * FROM Patient;

-- Select all from Ward
SELECT * FROM Ward;

-- Select all from Tests
SELECT * FROM Tests;

-- Select all from Labels
SELECT * FROM Labels;

-- Select all from Staff
SELECT * FROM Staff;

-- Select all from Logs
SELECT * FROM Logs;



-- End
