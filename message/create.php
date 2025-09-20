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
$sender_id       = $data['sender_id'] ?? null;
$created_at     = $data['created_at'] ?? null;
$content         = $data['content'] ?? null;

if (!$consultation_id || !$sender_id || !$created_at || !$content) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'Missing required fields: consultation_id, sender_id, receiver_id, content']);
    exit;
}

try {
    $sql = "INSERT INTO message (consultation_id, sender_id, created_at, content) VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$consultation_id, $sender_id, $created_at, $content]);

    http_response_code(201);
    echo json_encode([
        'success' => true,
        'message' => 'Message sent',
        'id' => $conn->lastInsertId()
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'error' => $e->getMessage()
    ]);
}
?>
