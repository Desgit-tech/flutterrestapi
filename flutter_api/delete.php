<?php
include 'cors.php';
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] === 'POST') {
    $id = $_POST['id'];

    if (isset($id)) {
        $sql = "DELETE FROM hospitals WHERE id = $id";

        if ($conn->query($sql) === TRUE) {
            echo json_encode(["message" => "Data rumah sakit berhasil dihapus"]);
        } else {
            echo json_encode(["message" => "Gagal menghapus data: " . $conn->error]);
        }
    } else {
        echo json_encode(["message" => "ID tidak diberikan"]);
    }
}

$conn->close();
?>
