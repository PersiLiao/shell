<?php

$secret_key = getenv('SECRET_KEY');

if ($_SERVER['REQUEST_METHOD'] !== 'POST') {
    error_log('FAILED - not POST - '. $_SERVER['REQUEST_METHOD']);
    exit();
}

$content_type = isset($_SERVER['CONTENT_TYPE']) ? strtolower(trim($_SERVER['CONTENT_TYPE'])) : '';

if ($content_type !== 'application/json') {
    error_log('FAILED - not application/json - '. $content_type);
    exit();
}

$payload = trim(file_get_contents("php://input"));

if (empty($payload)) {
    error_log('FAILED - no payload');
    exit();
}

$header_signature = isset($_SERVER['HTTP_X_GITEA_SIGNATURE']) ? $_SERVER['HTTP_X_GITEA_SIGNATURE'] : '';

if (empty($header_signature)) {
    error_log('FAILED - header signature missing');
    exit();
}

$payload_signature = hash_hmac('sha256', $payload, $secret_key, false);

if ($header_signature !== $payload_signature) {
    error_log('FAILED - payload signature');
    exit();
}

$payload_arr = json_decode($payload, true);

if (json_last_error() !== JSON_ERROR_NONE) {
    error_log('FAILED - json decode - '. json_last_error());
    exit();
}

if($payload_arr['ref'] === 'refs/heads/master'){
    $root_path = dirname(__DIR__);
    exec(sprintf("cd %s && git pull origin master 2<&1", $root_path), $output, $return);
    exec(sprintf("rm -rf %s 2<&1", $root_path . '/data/template/*'), $output, $return);
    exit('git push event');
}


