<?php
session_start(); // Start session to store user data

// MySQL database connection settings
$db_host = "localhost";
$db_username = "root";
$db_password = "root";
$db_name = "patientsystem";

// Check if the form is submitted
if ($_SERVER["REQUEST_METHOD"] == "POST") {
    // Capture username (Staff ID) and password from the form
    $staff_id = $_POST['username'];
    $password = $_POST['password'];

    // Create a new MySQL connection
    $conn = new mysqli($db_host, $db_username, $db_password, $db_name);

    // Check connection
    if ($conn->connect_error) {
        die("Connection failed: " . $conn->connect_error);
    }

    // Prepare the SQL query to fetch the password for the given Staff ID
    $stmt = $conn->prepare("SELECT pass FROM Login_info WHERE Staff_id = ?");
    $stmt->bind_param("s", $staff_id); // Bind the staff_id to the query
    $stmt->execute();
    $stmt->bind_result($db_password);
    $stmt->fetch();

    if ($db_password) {
        // Directly compare plain text passwords (assuming passwords are stored as plain text)
        if ($password === $db_password) {
            // If login successful, redirect to Label.html
            header("Location: Label_page.html");
            exit();
        } else {
            // Redirect to error page if the password is incorrect
            header("Location: Error_page.html");
            exit();
        }
    } else {
        // Redirect to error page if no staff ID is found
        header("Location: Error_page.html");
        exit();
    }

    // Close the statement and connection
    $stmt->close();
    $conn->close();
}
