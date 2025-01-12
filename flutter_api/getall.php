<?php
include 'cors.php';
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'GET') {
    $id = $_GET['id'];

    if (isset($id)) {
        $sql = "SELECT * FROM hospitals WHERE id = $id";
        $result = $conn->query($sql);

        if ($result->num_rows > 0) {
            echo json_encode($result->fetch_assoc());
        } else {
            echo json_encode(["message" => "Rumah sakit tidak ditemukan"]);
        }
    } else {
        echo json_encode(["message" => "ID tidak diberikan"]);
    }
}

$conn->close();
?>
