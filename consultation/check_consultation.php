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
$centerId = $data['center_id'] ?? null;
$userId = $data['user_id'] ?? null;

if (!$centerId || !$userId) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'center_id and user_id are required']);
    exit;
}

try {
    $sql = "SELECT * FROM consultation WHERE center_id = ? AND user_id = ? LIMIT 1";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$centerId, $userId]);
    $consultation = $stmt->fetch();

    if ($consultation) {
        echo json_encode(['success' => true, 'data' => $consultation]);
    } else {
        echo json_encode(['success' => false, 'message' => 'No consultation found for this user and center']);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>
