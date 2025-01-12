<?php
include 'cors.php';  

$servername = "localhost"; 
$username = "root";        
$password = "";            
$dbname = "hospitals"; 

$conn = new mysqli($servername, $username, $password, $dbname);

if ($conn->connect_error) {
    error_log("Connection failed: " . $conn->connect_error);
    die("Connection failed: " . $conn->connect_error);
}

$name = $_POST['name'] ?? '';
$location = $_POST['location'] ?? '';
$price = $_POST['price'] ?? '';
$rating = $_POST['rating'] ?? '';
$description = $_POST['description'] ?? '';
$image_url = $_POST['image_url'] ?? '';  

// Log received POST data
error_log("Received POST data: " . print_r($_POST, true));

if ($name && $location && $price && $rating && $description && $image_url) {
    $stmt = $conn->prepare("INSERT INTO hospitals (name, location, price, rating, description, image_url) VALUES (?, ?, ?, ?, ?, ?)");
    $stmt->bind_param("ssddss", $name, $location, $price, $rating, $description, $image_url);

    if ($stmt->execute()) {
        error_log("Data berhasil ditambahkan: " . print_r($_POST, true));
        echo json_encode(["message" => "Data rumah sakit berhasil ditambahkan"]);
    } else {
        error_log("Error saat menambahkan data: " . $stmt->error);
        echo json_encode(["message" => "Data tidak berhasil ditambahkan", "error" => $stmt->error]);
    }

    $stmt->close();  
} else {
    error_log("Data tidak lengkap: " . print_r($_POST, true));
    echo json_encode(["message" => "Data tidak lengkap"]);
}

$conn->close(); 
?>
