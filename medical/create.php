<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");  // ضبط السماح للطلبات من أي مصدر (يمكن تخصيصه)
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

require '../db.php';  // الاتصال بقاعدة البيانات (PDO)

if ($_SERVER['REQUEST_METHOD'] != 'POST') {
    http_response_code(405);
    echo json_encode(["message" => "Method Not Allowed"]);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['name'], $data['phone'], $data['address'], $data['user_id'])) {
    http_response_code(400);
    echo json_encode(["message" => "Missing required fields: name, phone, address, user_id"]);
    exit;
}

try {
    $stmt = $conn->prepare("INSERT INTO medical_center (name, phone, address, user_id) VALUES (?, ?, ?, ?)");
    $stmt->execute([
        $data['name'],
        $data['phone'],
        $data['address'],
        $data['user_id']
    ]);

    http_response_code(201);
    echo json_encode([
        "message" => "Medical center created successfully",
        "id" => $conn->lastInsertId()
    ]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["message" => "Error creating medical center", "error" => $e->getMessage()]);
}
?>
