<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

require '../db.php'; // الاتصال بقاعدة البيانات

if ($_SERVER['REQUEST_METHOD'] != 'POST') {
    http_response_code(405);
    echo json_encode(["message" => "Method Not Allowed"]);
    exit;
}

$data = json_decode(file_get_contents("php://input"), true);

if (!isset($data['mobile'], $data['password'])) {
    http_response_code(400);
    echo json_encode(["message" => "Missing required fields: mobile, password"]);
    exit;
}

// البحث عن المستخدم
$stmt = $conn->prepare("SELECT id, name, mobile, password, location, role FROM user WHERE mobile = ?");
$stmt->execute([$data['mobile']]);
$user = $stmt->fetch(PDO::FETCH_ASSOC);

// التحقق من صحة المستخدم وكلمة المرور
if (!$user || !password_verify($data['password'], $user['password'])) {
    http_response_code(401);
    echo json_encode(["message" => "Invalid mobile or password"]);
    exit;
}

// إزالة كلمة المرور
unset($user['password']);

$response = [
    "message" => "Login successful",
    "user" => $user
];

// إذا كان المستخدم دكتور، أضف معلومات العيادة
if ($user['role'] === 'doctor') {
    $stmt = $conn->prepare("SELECT id, name, phone, address, user_id FROM medical_center WHERE user_id = ?");
    $stmt->execute([$user['id']]);
    $clinic = $stmt->fetch(PDO::FETCH_ASSOC);

    if ($clinic) {
        $response["medical_center"] = $clinic;
    }
}

http_response_code(200);
echo json_encode($response);
?>
