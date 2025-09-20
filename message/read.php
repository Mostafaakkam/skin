<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

require '../db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['success' => false, 'error' => 'Method Not Allowed']);
    exit;
}

// قراءة البيانات بصيغة JSON
$data = json_decode(file_get_contents("php://input"), true);
$consultation_id = $data['consultation_id'] ?? null;

if (!$consultation_id) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'consultation_id is required']);
    exit;
}

try {
    $sql = "SELECT * FROM message WHERE consultation_id = ? ORDER BY created_at ASC";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$consultation_id]);
    $messages = $stmt->fetchAll();

    echo json_encode(['success' => true, 'data' => $messages]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>
