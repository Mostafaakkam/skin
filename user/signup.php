<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");  // ضبط السماح للطلبات من أي مصدر (يمكن تخصيصه)
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

require '../db.php';  // الاتصال بقاعدة البيانات

// تأكد أن الطلب من نوع POST
if ($_SERVER['REQUEST_METHOD'] != 'POST') {
    http_response_code(405);
    echo json_encode(["message" => "Method Not Allowed"]);
    exit;
}

// جلب بيانات JSON المرسلة
$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['name'], $data['mobile'], $data['password'], $data['role'])) {
    http_response_code(400);
    echo json_encode(["message" => "Missing required fields: name, mobile, password, role"]);
    exit;
}

// التحقق إذا كان رقم الموبايل موجود مسبقًا
$stmt = $conn->prepare("SELECT id FROM user WHERE mobile = ?");
$stmt->execute([$data['mobile']]);
if ($stmt->fetch()) {
    http_response_code(409);
    echo json_encode(["message" => "Mobile number already registered"]);
    exit;
}

// تشفير كلمة المرور
$hashed_password = password_hash($data['password'], PASSWORD_DEFAULT);

// إدخال المستخدم الجديد في قاعدة البيانات
$stmt = $conn->prepare("INSERT INTO user (name, mobile, password, location, role) VALUES (?, ?, ?, ?, ?)");

try {
    $stmt->execute([
        $data['name'],
        $data['mobile'],
        $hashed_password,
        $data['location'] ?? null,
        $data['role']
    ]);
    http_response_code(201);
    echo json_encode(["message" => "User registered successfully", "user_id" => $conn->lastInsertId()]);
} catch (PDOException $e) {
    http_response_code(500);
    echo json_encode(["message" => "Database error: " . $e->getMessage()]);
}
