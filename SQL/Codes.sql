CREATE TABLE Staff (
   Id_staff VARCHAR2(20) PRIMARY KEY,
   Name_staff VARCHAR2(20) NOT NULL,
   Phone_number INT NOT NULL,
   Role VARCHAR2(100) NOT NULL
);

CREATE TABLE Logs (
   Time_edited VARCHAR2(20) NOT NULL,
   Id_staff VARCHAR2(20),
   Name_staff VARCHAR2(20),
   Changes_made VARCHAR2(100) NOT NULL,
   CONSTRAINT fk_logs_staff_id FOREIGN KEY (Id_staff) REFERENCES Staff(Id_staff),
   CONSTRAINT fk_logs_staff_name FOREIGN KEY (Name_staff) REFERENCES Staff(Name_staff)
);

CREATE TABLE Patient (
   Patient_id VARCHAR2(5) PRIMARY KEY,
   Patient_name VARCHAR2(20) NOT NULL,
   Gender VARCHAR2(10) NOT NULL,
   Phone INT NOT NULL,
   Address VARCHAR2(20) NOT NULL
);

CREATE TABLE Ward (
   Ward_id VARCHAR2(5) PRIMARY KEY,
   Room_number INT NOT NULL,
   Patient_id VARCHAR2(5),
   Lab_id VARCHAR2(5),
   CONSTRAINT fk_ward_patient_id FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
   CONSTRAINT fk_ward_lab_id FOREIGN KEY (Lab_id) REFERENCES Laboratory(Lab_id)
);

CREATE TABLE Labels (
   Test_id VARCHAR2(5) PRIMARY KEY,
   Patient_id VARCHAR2(5),
   Patient_name VARCHAR2(20),
   Ward_id VARCHAR2(5),
   Due_date VARCHAR2(5) NOT NULL,
   Medication VARCHAR2(40) NOT NULL,
   CONSTRAINT fk_labels_patient_id FOREIGN KEY (Patient_id) REFERENCES Patient(Patient_id),
   CONSTRAINT fk_labels_patient_name FOREIGN KEY (Patient_name) REFERENCES Patient(Patient_name),
   CONSTRAINT fk_labels_ward_id FOREIGN KEY (Ward_id) REFERENCES Ward(Ward_id)
);

CREATE TABLE Laboratory (
   Lab_id VARCHAR2(5) PRIMARY KEY,
   Product_id VARCHAR2(5)
);
