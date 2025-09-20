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
$id = $data['id'] ?? null;

if (!$id) {
    http_response_code(400);
    echo json_encode(['success' => false, 'error' => 'ID is required']);
    exit;
}

try {
    $sql = "SELECT * FROM consultation WHERE id = ?";
    $stmt = $conn->prepare($sql);
    $stmt->execute([$id]);
    $consultation = $stmt->fetch();

    if ($consultation) {
        echo json_encode(['success' => true, 'data' => $consultation]);
    } else {
        http_response_code(404);
        echo json_encode(['success' => false, 'error' => 'Consultation not found']);
    }
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>
