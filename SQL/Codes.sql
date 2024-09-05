DROP TABLE Staff;
DROP TABLE Laboratory;
DROP TABLE Patient;
DROP TABLE Ward;
DROP TABLE Labels;
DROP TABLE Logs;




INSERT INTO Laboratory (Lab_id, Product_id)
VALUES ('L001', 'P4567');
INSERT INTO Ward (Ward_id, Patient_id, Lab_id)
VALUES ('A','0123', 'L001');
INSERT INTO Patient (Patient_id, Patient_name, Gender, Phone, Address)
VALUES ('0123', 'Morten Naive', 'Male', 479268987, '19 Elizabeth st');
INSERT INTO Tests (Test_id, Patient_id, Test_type, The_field)
VALUES ('T0789', '0123', 'Transplant', 'SomeFieldValue');
INSERT INTO Labels (Label_id, Test_id, Patient_id, Patient_name, Ward_id, Due_date, Medication)
VALUES ('*159', 'T0789', '0123', 'Morten Naive', 'A', '2024-09-10', 'Patient needs A drug');
INSERT INTO Staff (Id_staff, Name_staff, Phone_number, Role)
VALUES ('S7539', 'Morten Smart', '0479987654', 'Nurse');
INSERT INTO Logs (Label_id, Id_staff, Time_edited, Changes_made)
VALUES ('L001', 'S7539', '2024-09-05', 'Print. Reprint');




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
   Phone INT NOT NULL,
   Address VARCHAR2(20) NOT NULL
);

-- Create Ward Table
CREATE TABLE Ward (
   Ward_id VARCHAR2(5) PRIMARY KEY,
   Patient_id VARCHAR2(5),
   Lab_id VARCHAR2(5),
   CONSTRAINT fk_ward_patient_id FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
   CONSTRAINT fk_ward_lab_id FOREIGN KEY (Lab_id) REFERENCES Laboratory(Lab_id)
);

CREATE TABLE Tests(
   Test_id VARCHAR2(5) PRIMARY KEY,
   Patient_id VARCHAR(5),
   Test_type char(5) NOT NULL,
   The_field char(20)NOT NULL,
   CONSTRAINT tests_patient_id FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id)
);
-- Create Labels Table
CREATE TABLE Labels (
   Label_id varchar2(5) PRIMARY KEY,
   Test_id VARCHAR2(5),
   Patient_id VARCHAR2(5),
   Patient_name VARCHAR2(20),
   Ward_id VARCHAR2(5),
   Due_date VARCHAR2(5) NOT NULL,
   Medication VARCHAR2(40) NOT NULL,
   CONSTRAINT fk_labels_patient_id FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
   CONSTRAINT fk_labels_patient_name FOREIGN KEY (Patient_name) REFERENCES Patient(Patient_name),
   CONSTRAINT fk_labels_ward_id FOREIGN KEY (Ward_id) REFERENCES Ward(Ward_id),
   CONSTRAINT fk_labels_tests_id FOREIGN KEY (Test_id) REFERENCES Tests(Test_id)
);

-- Create Staff Table
CREATE TABLE Staff (
   Id_staff VARCHAR2(20) PRIMARY KEY,
   Name_staff VARCHAR2(20) NOT NULL,
   Phone_number INT NOT NULL,
   Role VARCHAR2(100) NOT NULL
);

-- Create Logs Table
CREATE TABLE Logs (
   Label_id VARCHAR2(5), 
   Id_staff VARCHAR2(20),
   Name_staff VARCHAR2(20),
   Time_edited VARCHAR2(20) NOT NULL,
   Changes_made VARCHAR2(100) NOT NULL,
   CONSTRAINT fk_logs_staff_id FOREIGN KEY (Id_staff) REFERENCES Staff(Id_staff),
   CONSTRAINT fk_logs_staff_name FOREIGN KEY (Name_staff) REFERENCES Staff(Name_staff),
   CONSTRAINT fk_logs_label_id FOREIGN KEY (Label_id) REFERENCES Labels(Label_id)
);


-- End
