<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

// تأكد وجود مجلد uploads وصلاحيات الكتابة عليه
$uploadDir = "../uploads/";

require '../db.php';

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(["message" => "Method Not Allowed"]);
    exit;
}

// تحقق من وجود ملف الصورة
if (!isset($_FILES['photo']) || $_FILES['photo']['error'] !== UPLOAD_ERR_OK) {
    http_response_code(400);
    echo json_encode(["message" => "Image file (photo) is required and must be uploaded without errors"]);
    exit;
}

// تحقق من باقي الحقول
if (!isset($_POST['result'], $_POST['user_id'])) {
    http_response_code(400);
    echo json_encode(["message" => "Missing required fields: result, user_id"]);
    exit;
}

// رفع الملف
$photoFile = $_FILES['photo'];
// يمكنك إضافة تحقق نوع الملف وحجمه هنا إن أردت

// توليد اسم ملف جديد لتجنب التعارض
$fileExtension = pathinfo($photoFile['name'], PATHINFO_EXTENSION);
$newFileName = uniqid('diag_', true) . '.' . $fileExtension;
$destination = $uploadDir . $newFileName;

if (!move_uploaded_file($photoFile['tmp_name'], $destination)) {
    http_response_code(500);
    echo json_encode(["message" => "Failed to upload image"]);
    exit;
}

// تخزين المسار النسبي في قاعدة البيانات (يمكنك تعديل حسب احتياجك)
$photoPath = $newFileName;

$result = $_POST['result'];
$user_id = intval($_POST['user_id']);

$stmt = $conn->prepare("INSERT INTO diagnosis (photo, result, user_id) VALUES (?, ?, ?)");
if ($stmt->execute([$photoPath, $result, $user_id])) {
    echo json_encode(["message" => "Diagnosis created successfully", "id" => $conn->lastInsertId()]);
} else {
    http_response_code(500);
    echo json_encode(["message" => "Failed to create diagnosis"]);
}
?>
