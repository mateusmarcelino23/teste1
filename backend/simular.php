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

if (!isset($dados['faturamento'], $dados['regime'], $dados['custos_variaveis'], $dados['custos_fixos'], $dados ['projecao_meses'])) { // verifica se todos os campos obrigatórios foram enviados na requisição, se um estiver faltando...
    http_response_code(400); // código numérico para status da operação (400 para requisição falha)
    exit; // encerra o script
}

// if else para aliquota do item escolhido no dropdown
if ($dados['regime'] == 'simples') {
    $aliquota = 0.06; // se o usuário escolheu o regime "Simples Nacional", o valor comum da aliquota será de 6%
} elseif ($dados['regime'] == 'presumido') {
    $aliquota = 0.15; // se o usuário escolheu o regime "Lucro Presumido", o valor médio da aliquota será de 15%
} else {
    $aliquota = 0.22; // se o usuário escolheu o regime "Lucro Real", o valor médio da aliquota será de 22%
}

// matemática para criar resultado pro usuário
$faturamento = (float) $dados['faturamento']; // transforma o dado em uma variável antes das contas
$custos_variaveis = (float) $dados['custos_variaveis'];
$custos_fixos = (float) $dados['custos_fixos'];

$imposto = $faturamento * $aliquota; // o imposto é definido pelo faturamento multiplicado por aliquota
$receita_liquida = $faturamento - $imposto; // a receita líquida é definida pelo faturamento subraído pelo imposto
$margem_contribuicao = $receita_liquida - $custos_variaveis; // a margem de contribuição é definida pela receita líquida subtraída pelos custos variáveis
$lucro_operacional = $margem_contribuicao - $custos_fixos; // o lucro operacional é definido pela margem de contribuição subtraída pelos custos fixos
$margem_lucro = ($lucro_operacional / $faturamento) * 100; // a margem de lucro é definida pelo lucro operacional dividido pelo faturamento, que em seguida é multiplicado por 100
$indice_margem = $margem_contribuicao / $faturamento; // o índice de margem é definido pela margem de contribuição dividida pelo faturamento
if ($faturamento && $indice_margem > 0) { // nenhuma dessas variáveis pode ser 0
    $ponto_equilibrio = $custos_fixos / $indice_margem; // o ponto de equilíbrio é definido pelos custos fixos divididos pelo índice de margem
} else {
    $ponto_equilibrio = 0; // se uma das variáveis for 0 ou menos, o ponto de equilíbrio automaticamente é 0
}

$qtd_meses = (int) ($dados['projecao_meses'] ?? 12); // cria variável númerica para a quantidade de meses que o usuário escrever, com 12 sendo padrão em caso de dado vazio
// $qtd_meses = max(1, min(60, $qtd_meses)); // limita a quantidade de meses que o usuário deve digitar para 60

$resposta = [ // array para formar os dados dos cards no sistema
    'indicadores' => [ // dados para aparecer na saída
        'lucro líquido' => $lucro_operacional, // lucro operacional 
        'margem_lucro' => $margem_lucro, // margem de lucro
        'ponto_equilibrio' => $ponto_equilibrio // ponto de equilíbrio
    ],

    'grafico' => [] // informações do gráfico
];

// caixas de memória com valor inicial 0
$faturamento_acumulado = 0;
$lucro_acumulado = 0;

for ($mes = 1; $mes <= $qtd_meses; $mes++) { // constrói a simulação de cada mês do gráfico, desde o mês 1 até o limite que o usuário pediu
    $faturamento_acumulado += $faturamento; // pega o valor da caixa e adiciona um novo valor a cada mês
    $lucro_acumulado += $lucro_operacional; // 

    $resposta['grafico'] [] = [ // formando gráfico definido acima na array, a cada mês que passa um novo item é adicionado
        'mes' => 'Mês ' . $mes, // escreve "Mês 1", "Mês 2" em diante
        'faturamento_acumulado' => round($faturamento_acumulado, 2), // salva o valor acumulado com mais duas casas decimais, destinadas aos centavos
        'lucro_acumulado' => round($lucro_acumulado, 2) //
    ];
}

http_response_code(200);
echo json_encode($resposta); // imprimindo array para o flutter poder receber o json
