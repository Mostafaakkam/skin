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

// تأكد من الحقول المطلوبة (بدون user_id)
$required_fields = ['id', 'name', 'phone', 'address'];
foreach ($required_fields as $field) {
    if (!isset($data[$field])) {
        http_response_code(400);
        echo json_encode(["message" => "Missing field: $field"]);
        exit;
    }
}

$id = intval($data['id']);
$name = $data['name'];
$phone = $data['phone'];
$address = $data['address'];

// استعلام التحديث بدون user_id
$stmt = $conn->prepare("UPDATE medical_center SET name = ?, phone = ?, address = ? WHERE id = ?");
if ($stmt->execute([$name, $phone, $address, $id])) {
    echo json_encode(["message" => "Medical center updated successfully"]);
} else {
    http_response_code(500);
    echo json_encode(["message" => "Failed to update medical center"]);
}
?>
