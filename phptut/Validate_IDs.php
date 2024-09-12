<?php
// Database connection settings
$db_host = "localhost";
$db_username = "root";
$db_password = "root"; // Update with your actual password
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

// Prepare SQL query to check if both Patient ID and Staff ID exist in their respective tables
$patient_check = $conn->prepare("SELECT * FROM PatientSystem.Patient WHERE Patient_id = ?");
$patient_check->bind_param("s", $patient_id);
$patient_check->execute();
$patient_result = $patient_check->get_result();

$staff_check = $conn->prepare("SELECT * FROM PatientSystem.Staff WHERE Id_staff = ?");
$staff_check->bind_param("s", $staff_id);
$staff_check->execute();
$staff_result = $staff_check->get_result();

// Check if both Patient and Staff records exist
if ($patient_result->num_rows > 0 && $staff_result->num_rows > 0) {
    echo "valid";  // Both IDs are valid
} else {
    echo "invalid";  // Either or both IDs are invalid
}

// Close connections
$patient_check->close();
$staff_check->close();
$conn->close();
?>
