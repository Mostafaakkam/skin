<?php
header("Content-Type: application/json; charset=UTF-8");
header("Access-Control-Allow-Origin: *");
header("Access-Control-Allow-Methods: POST");
header("Access-Control-Allow-Headers: Content-Type");

require '../db.php';  // اتصال قاعدة البيانات موجود في $conn

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    http_response_code(405);
    echo json_encode(["message" => "Method Not Allowed"]);
    exit;
}

// الغينا شرط id، فقط استعلام كل المراكز الطبية مع بيانات الطبيب المسؤول
$sql = "
    SELECT 
        mc.*, 
        u.id as user_id,
        u.name as user_name,
        u.mobile as user_mobile,
        u.location as user_location,
        u.role as user_role
    FROM medical_center mc
    LEFT JOIN user u ON mc.user_id = u.id
";

$stmt = $conn->query($sql);
$results = $stmt->fetchAll(PDO::FETCH_ASSOC);

// الآن نعيد تشكيل البيانات لإخراج معلومات الطبيب في حقل منفصل، مع حذف password

$data = [];

foreach ($results as $row) {
    $center = [
        'id' => $row['id'],
        'name' => $row['name'],
        'phone' => $row['phone'],
        'address' => $row['address'],
        'user_id' => $row['user_id'],
        'doctor' => [
            'id' => $row['user_id'],
            'name' => $row['user_name'],
            'mobile' => $row['user_mobile'],
            'location' => $row['user_location'],
            'role' => $row['user_role'],
        ]
    ];

    $data[] = $center;
}

echo json_encode(['data' => $data]);
?>
