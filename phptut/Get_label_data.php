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

// Query to get the latest record from logs_info
$query = "SELECT Patient_name, Patient_id, Patient_age AS age, Patient_gender AS gender, Ward_id, Test_type 
          FROM PatientSystem.Logs_info
          ORDER BY Label_id DESC LIMIT 1";  // Fetch the most recent log

$result = $conn->query($query);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();
    echo json_encode($row);  // Return data as JSON
} else {
    echo json_encode([]);  // Return an empty JSON object if no records are found
}

$conn->close();
?>


