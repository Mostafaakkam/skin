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
$doctor_id = $data['id'] ?? null;

try {
    if ($doctor_id) {
        $sql = "SELECT * FROM consultation WHERE center_id = ? ORDER BY date_time DESC";
        $stmt = $conn->prepare($sql);
        $stmt->execute([$doctor_id]);
    } else {
        $sql = "SELECT * FROM consultation ORDER BY date_time DESC";
        $stmt = $conn->query($sql);
    }

    $consultations = $stmt->fetchAll();
    echo json_encode(['success' => true, 'data' => $consultations]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(['success' => false, 'error' => $e->getMessage()]);
}
?>
