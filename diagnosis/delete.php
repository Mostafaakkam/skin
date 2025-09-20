<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

require '../db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(["message" => "Method Not Allowed"]);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['id'])) {
    http_response_code(400);
    echo json_encode(["message" => "Missing field: id"]);
    exit;
}

$id = intval($data['id']);

$stmt = $conn->prepare("DELETE FROM diagnosis WHERE id = ?");
if ($stmt->execute([$id])) {
    echo json_encode(["message" => "Diagnosis deleted successfully"]);
} else {
    http_response_code(500);
    echo json_encode(["message" => "Failed to delete diagnosis"]);
}
?>
