<?php
include 'cors.php';
include_once 'db.php'; 

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $id = $_POST['id'];
    $name = $_POST['name'];
    $location = $_POST['location'];
    $price = $_POST['price'];
    $rating = $_POST['rating'];
    $description = $_POST['description'];
    $imageUrl = $_POST['image_url'];

    // Menyusun query update data
    $query = "UPDATE hospitals SET name='$name', location='$location', price='$price', rating='$rating', description='$description', image_url='$imageUrl' WHERE id=$id";

    if (mysqli_query($conn, $query)) {
        echo json_encode(["status" => "success", "message" => "Data updated successfully"]);
    } else {
        echo json_encode(["status" => "error", "message" => "Failed to update data"]);
    }
} else {
    echo json_encode(["status" => "error", "message" => "Invalid request method"]);
}
?>
