<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: GET");
header("Access-Control-Allow-Headers: Content-Type");

require '../db.php';

try {
    $sql = "SELECT * FROM user WHERE role = 'user'";
    $stmt = $conn->query($sql);
    $users = $stmt->fetchAll();
    echo json_encode(['success' => true, 'data' => $users]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>
