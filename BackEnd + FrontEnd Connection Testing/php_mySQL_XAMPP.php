
<?php
// Connected successfully to the database!

// MySQL database connection settings
$db_host = "localhost"; // If using XAMPP/WAMP, it will likely be 'localhost'
$db_username = "root"; // Replace with your MySQL username
$db_password = "root"; // Replace with your MySQL password
$db_name = "patientsystem"; // The name of your database

// Create MySQL connection
$conn = new mysqli($db_host, $db_username, $db_password, $db_name);

// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
} else {
    echo "Connected successfully to the database!";
}

// Close connection
$conn->close();
?>
