import 'package:flutter/material.dart'; // importando o pacote para usar os widgets do Flutter

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

  @override
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
            padding: const EdgeInsets.symmetric(
              horizontal: 24.0,
            ),

            child: Column(
              // conteúdo do container é uma coluna
              children: [
                // todos os elementos da coluna
                TextField(
                  // campo de texto
                  style: const TextStyle(
                    color: Colors.white,
                  ), //estilos do texto que é digitado pelo usuário
                  decoration: InputDecoration(
                    // colocar decoração
                    labelText: 'Faturamento Bruto',
                    labelStyle: TextStyle(color: Colors.white),
                  ), // texto apresentado e estilo do texto
                ),

                SizedBox(
                  height: 20,
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
                        style: TextStyle(
                          color: Colors.white,
                        ), // estilo do texto
                      );
                    }).toList(); // converte o resultado em uma lista
                  },

                  items: [
                    DropdownMenuItem(
                      value: 'simples',
                      child: Text(
                        'Simples Nacional',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),

                    DropdownMenuItem(
                      value: 'presumido',
                      child: Text(
                        'Lucro Presumido',
                        style: TextStyle(color: Colors.black),
                      ),
                    ),

                    DropdownMenuItem(
                      value: 'real',
                      child: Text(
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

                SizedBox(height: 20),

                TextField(
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Custos Variáveis (% do Faturamento)',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),

                SizedBox(height: 20),

                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Custos Fixos Mensais',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),

                SizedBox(height: 20),

                TextField(
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: 'Projeção de Meses',
                    labelStyle: TextStyle(color: Colors.white),
                  ),
                ),

                SizedBox(height: 40),

                ElevatedButton(
                  onPressed: () {},

                  child: const Text('Fazer Simulação'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
