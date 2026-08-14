<?php
$host = 'mysql-db';
$db   = 'university';
$user = 'root';
$pass = 'Password123';

try {
    $pdo = new PDO("mysql:host=$host;dbname=$db;charset=utf8", $user, $pass);
    $pdo->setAttribute(PDO::ATTR_ERRMODE, PDO::ERRMODE_EXCEPTION);
    echo "<h1>Danh sach sinh vien (PHP Latest - Port 8889)</h1>";
    $stmt = $pdo->query("SELECT * FROM students");
    echo "<ul>";
    while ($row = $stmt->fetch()) {
        echo "<li>" . htmlspecialchars($row['name']) . "</li>";
    }
    echo "</ul>";
} catch (PDOException $e) {
    echo "Loi ket noi Database: " . $e->getMessage();
}
?>
