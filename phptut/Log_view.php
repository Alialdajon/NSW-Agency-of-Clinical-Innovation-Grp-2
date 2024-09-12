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

// Query to get all records from Logs_info excluding Label_id
$sql = "SELECT Id_staff, Patient_id, Patient_name, Patient_age, Patient_gender, Test_type, Ward_id FROM PatientSystem.Logs_info";
$result = $conn->query($sql);

$logs = [];

if ($result->num_rows > 0) {
    // Fetch all records and push them to the logs array
    while($row = $result->fetch_assoc()) {
        $logs[] = $row;
    }
}

// Return the logs as a JSON response
echo json_encode($logs);

// Close the connection
$conn->close();
?>
