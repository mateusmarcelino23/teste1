<?php

header('Content-Type: application/json'); // avisa ao sistema que a resposta será em JSON
header('Access-Control-Allow-Origin: *'); // libera acesso externo sem bloqueio do navegador
header('Access-Control-Allow-Methods: GET, POST, OPTIONS'); // define quais métodos de requisição são permitidos na API
header('Access-Control-Allow-Headers: Content-Type, Authorization'); // permite que a requisição envie dados extras (como tipo de dado ou token de login)

if ($_SERVER['REQUEST_METHOD'] === 'OPTIONS') { // verifica se o navegador está apenas checando as permissões de acesso (CORS)
    http_response_code(200); // código numérico para status da operação (200 para requisição bem sucedida)
    exit; // encerra o script aqui para evitar desperdício de processamento
}

$jsonRecebido = file_get_contents('php://input'); // pega o texto JSON puro que o flutter disparou no POST
$dados = json_decode($jsonRecebido, true); // garante que "dados" se torne um array associativo (mais fácil de manipular as contas)

!isset($dados['faturamento'], $dados['regime'], $dados['custos_variaveis'], $dados['custos_fixos'], $dados['projecao_meses']);