<?php
header('Content-Type: application/json');
include 'cors.php'; 
include 'db.php';

$sql = "SELECT * FROM hospitals";
$result = mysqli_query($conn, $sql);

$hospitals = array();
while ($row = mysqli_fetch_assoc($result)) {
    $hospitals[] = $row;
}

if (empty($hospitals)) {
    echo json_encode(["message" => "Tidak ada data rumah sakit"]);
} else {
    echo json_encode($hospitals);
}

$conn->close();
?>
