<?php
// Database connection
$db_host = "localhost";
$db_username = "root";
$db_password = "root";  // Update with your actual password
$db_name = "patientsystem";

$conn = new mysqli($db_host, $db_username, $db_password, $db_name);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}

// Capture POST data
$patient_id = $_POST['patient_id'];

// Query to check if Patient ID exists
$query = "SELECT Patient_id FROM PatientSystem.Patient WHERE Patient_id = ?";
$stmt = $conn->prepare($query);
$stmt->bind_param("s", $patient_id);
$stmt->execute();
$stmt->store_result();

if ($stmt->num_rows > 0) {
    echo 'valid';  // Send 'valid' if Patient ID exists
} else {
    echo 'invalid';  // Send 'invalid' if Patient ID does not exist
}

$stmt->close();
$conn->close();
?>
