<?php
$request_uri = $_SERVER['REQUEST_URI'];

function redirectToLogin() {
    header("Location: login.php");
    exit;
}

function redirectToHello() {
    header("Location: hello.php");
    exit;
}

if ($request_uri === '/login') {
    redirectToLogin();
} elseif ($request_uri === '/hello') {
    redirectToHello();
} else {
    http_response_code(404);
    echo "Halaman tidak ditemukan";
}
?>
