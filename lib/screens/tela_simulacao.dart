import 'package:flutter/material.dart'; // importando o pacote para usar os widgets do Flutter
import 'dart:convert'; //
import 'package:http/http.dart' as http;

class TelaSimulacao extends StatefulWidget {
  // inicia a class com o tipo de widget dinâmico porque a página precisa guardar informações
  const TelaSimulacao({super.key}); // construtor da classe

  @override
  State<TelaSimulacao> createState() => _SimulacaoState(); // criando state para fazer a próxima classe (statefulwdget precisa de duas classes)
}

class _SimulacaoState extends State<TelaSimulacao> {
  // classe essencial especialmente para statefulwidget onde será construída a tela

  String?
  regimeSelecionado; // variável criada para atualizar regime tributário escolhido pelo usuário

  final _faturamentoController =
      TextEditingController(); // variável para criar o valor do campo de faturamento
  final _custosvariaveisController =
      TextEditingController(); // variável para criar o valor do campo de custos variáveis
  final _custosfixosController =
      TextEditingController(); // variável para criar o valor do campo de custos fixos
  final _projecaoController =
      TextEditingController(); // variável para criar o valor do campo de projeção de meses

  String resultadoCard = ""; // variável para guardar resposta vindo do php
  bool _isLoading = false;

  Future<void> enviarDadosPHP() async {
    // função criada para enviar os dados preenchidos pelo usuário em cada campo do formulário para a api
    final url = Uri.parse(
      'http://localhost:8000/backend/simular.php',
    ); // pega a url da api (do infinityfree)

    setState(() {
      _isLoading = true;
    }); // atualiza a interface para mostrar o loading na tela

    try {
      // inicia bloco try-catch para capturar possíveis falhas na internet ou erros inesperados
      final resposta = await http.post(
        // envia a requisição http do tipo post para o servidor e aguarda a resposta
        url,
        headers: {
          "Content-Type": "application/json",
        }, // os dados enviados serão em formato json
        body: jsonEncode({
          // dados enviados em formato de controller convertidos para o formato da api
          "faturamento": _faturamentoController.text,
          "regime": regimeSelecionado,
          "custos_variaveis": _custosvariaveisController.text,
          "custos_fixos": _custosfixosController.text,
          "projecao_meses": _projecaoController.text,
        }),
      );

      if (resposta.statusCode == 200) {
        // se a resposta for bem sucedida
        print('Resposta do PHP: ${resposta.body}');
        final dadosResposta = jsonDecode(
          resposta.body,
        ); // o json retorna os resultados da api
        print('Resultado Extraído: ${dadosResposta['resultado']}');

        // setState(
        //   () {
        //     (dadosResposta['resultado'].toString());
        //   },
        // ); // atualiza a tela exibindo o resultado em um card com chave "resultado"
      } else {
        print("Erro no servidor: ${resposta.statusCode}"); // se a resposta tiver falhado, o card mostrará o erro no servidor
      }
    } catch (e) {
      // caso ocorra falha de rede, falta de internet ou erro na conversão de dados do JSON, exibe a mensagem de erro na tela
        print("Falha na conexão: $e");
    } finally {
      // Garante que o indicador de carregamento seja desativado ao final do processo, dando certo ou errado
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  void dispose() {
    _faturamentoController.dispose();
    _custosvariaveisController.dispose();
    _custosfixosController.dispose();
    _projecaoController.dispose();

    super.dispose();
  } // garante que as variáveis não pesem desnecessariamente na memória RAM

  Widget build(BuildContext context) {
    // construindo widget
    return Scaffold(
      // estrutura básica da página
      backgroundColor: const Color(0xFF212127), // cor de fundo

      appBar: AppBar(
        title: const Text('Fazer Simulação'),
      ), // título na barra superior

      body: Center(
        // todos os elementos ficarão no centro da tela
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),

            child: Column(
              // conteúdo do container é uma coluna
              children: [
                // todos os elementos da coluna
                TextField(
                  // campo de texto
                  controller:
                      _faturamentoController, // transforma a variável do início em um valor para criar o cálculo na saída
                  style: const TextStyle(
                    color: Colors.white,
                  ), //estilos do texto que é digitado pelo usuário
                  decoration: const InputDecoration(
                    // colocar decoração
                    labelText: 'Faturamento Bruto (Em R\$)',
                    labelStyle: TextStyle(color: Colors.white),
                  ), // texto apresentado e estilo do texto
                ),

                const SizedBox(
                  height: 50,
                ), // distância entre um campo e outro no formulário

                DropdownButtonFormField(
                  // campo de seleção
                  style: TextStyle(
                    color: Colors.white,
                  ), // estilo da opção selecionado pelo usuário no campo
                  decoration: InputDecoration(
                    // colocar decoração
                    labelText: 'Regime Tributário',
                    labelStyle: TextStyle(color: Colors.white),
                  ), //estilo das opções que aparecem para selecionar

                  selectedItemBuilder: (BuildContext context) {
                    // estilo do item no formulário quando ele for selecionado
                    return [
                      'Simples Nacional',
                      'Lucro Presumido',
                      'Lucro Real',
                    ].map((String texto) {
                      // percorre as opções disponíveis, a string recebe cada item e "texto" é o nome dado ao item atual
                      return Text(
                        // cria o texto de cada opção
                        texto, // transforma cada nome em um widget de texto
                        style: const TextStyle(
                          color: Colors.white,
                        ), // estilo do texto
                      );
                    }).toList(); // converte o resultado em uma lista
                  },

                  items: [
                    DropdownMenuItem(
                      value: 'simples',
                      child: const Text(
                        'Simples Nacional',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),

                    DropdownMenuItem(
                      value: 'presumido',
                      child: const Text(
                        'Lucro Presumido',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),

                    DropdownMenuItem(
                      value: 'real',
                      child: const Text(
                        'Lucro Real',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ], // opções com seus valores e a forma escrita que o usuário vê

                  onChanged: (novoValor) {
                    // a partir do momento que o usuário clicar em uma nova opção, ela vai ser escolhida como novo valor
                    setState(() {
                      // atualização do campo
                      regimeSelecionado =
                          novoValor; // variável do regime tributário se torna o novo valor selecionado
                    });
                  },
                ),

                const SizedBox(height: 50),

                TextField(
                  controller: _custosvariaveisController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Custos Variáveis (Em R\$)',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 50),

                TextField(
                  controller: _custosfixosController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Custos Fixos Mensais (Em R\$)',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 50),

                TextField(
                  controller: _projecaoController,
                  style: const TextStyle(color: Colors.white),
                  decoration: const InputDecoration(
                    labelText: 'Projeção de Meses (1-60)',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),

                const SizedBox(height: 70),

                ElevatedButton(
                  // botão de fazer a simulação
                  onPressed: _isLoading ? null : enviarDadosPHP,

                  child: _isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2.5,
                            color: Colors.white,
                          ),
                        )
                      : const Text('Fazer Simulação'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
