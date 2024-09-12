<?php
// Database connection settings
$db_host = "localhost";
$db_username = "root";
$db_password = "root";  // Update with your actual password
$db_name = "patientsystem";

// Create a new MySQL connection
$conn = new mysqli($db_host, $db_username, $db_password, $db_name);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Capture POST data from the AJAX request
$patient_id = $_POST['patient_id'];
$staff_id = $_POST['staff_id'];
$ward_id = $_POST['ward'];
$test_type = $_POST['test_type'];

// Step 1: Pull patient information from the Patient table
$patient_query = $conn->prepare("SELECT Patient_name, Age, Gender FROM PatientSystem.Patient WHERE Patient_id = ?");
$patient_query->bind_param("s", $patient_id);
$patient_query->execute();
$patient_result = $patient_query->get_result();
$patient_data = $patient_result->fetch_assoc();

if ($patient_data) {
    $patient_name = $patient_data['Patient_name'];
    $patient_age = $patient_data['Age'];
    $patient_gender = $patient_data['Gender'];

    // Step 2: Generate a new Label_id by incrementing the last one
    $label_query = $conn->query("SELECT MAX(CAST(SUBSTRING(Label_id, 2) AS UNSIGNED)) AS max_id FROM PatientSystem.Logs_info");
    $label_row = $label_query->fetch_assoc();
    $new_label_id = '*' . str_pad($label_row['max_id'] + 1, 3, '0', STR_PAD_LEFT);

    // Step 3: Insert data into Logs_info
    $insert_log = $conn->prepare("
        INSERT INTO PatientSystem.Logs_info (Label_id, Id_staff, Patient_id, Patient_name, Patient_age, Patient_gender, Test_type, Ward_id)
        VALUES (?, ?, ?, ?, ?, ?, ?, ?)
    ");
    $insert_log->bind_param("ssssssss", $new_label_id, $staff_id, $patient_id, $patient_name, $patient_age, $patient_gender, $test_type, $ward_id);
    $insert_log->execute();

    echo "Label information successfully logged.";
} else {
    echo "Patient not found.";
}

// Close connections
$patient_query->close();
$insert_log->close();
$conn->close();
?>