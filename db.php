<?php
$servername = "localhost";
$username = "root";   // عدل حسب بياناتك
$password = "";       // عدل حسب بياناتك
$dbname = "skin";

try {
    $dsn = "mysql:host=$servername;dbname=$dbname;charset=utf8mb4";
    $options = [
        PDO::ATTR_ERRMODE => PDO::ERRMODE_EXCEPTION, // لجعل PDO يرمي Exceptions عند الخطأ
        PDO::ATTR_DEFAULT_FETCH_MODE => PDO::FETCH_ASSOC, // إرجاع الصفوف كمصفوفة مرتبطة
        PDO::ATTR_EMULATE_PREPARES => false, // لتعطيل المحاكاة وتحسين الأمان
    ];
    $conn = new PDO($dsn, $username, $password, $options);
} catch (PDOException $e) {
    die("Connection failed: " . $e->getMessage());
}
?>
