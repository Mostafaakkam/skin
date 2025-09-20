<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

require '../db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(['message' => 'Method Not Allowed']);
    exit;
}

// قراءة البيانات بصيغة JSON
$data = json_decode(file_get_contents("php://input"), true);

// التحقق من الحقول المطلوبة
if (!isset($data['user_id'], $data['center_id'], $data['date_time'], $data['diagnosis_id'])) {
    http_response_code(400);
    echo json_encode(['message' => 'Missing required fields: user_id, doctor_id, date_time']);
    exit;
}

try {
    $sql = "INSERT INTO consultation (user_id, center_id, date_time,diagnosis_id) VALUES (?, ?, ?, ?)";
    $stmt = $conn->prepare($sql);
    $stmt->execute([
        $data['user_id'],
        $data['center_id'],
        $data['date_time'],
        $data['diagnosis_id']
    ]);

    http_response_code(201);
    echo json_encode([
        'success' => true,
        'message' => 'Consultation created',
        'id' => $conn->lastInsertId()
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode([
        'success' => false,
        'message' => 'Error creating consultation',
        'error' => $e->getMessage()
    ]);
}
?>
