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
        child: Container(
          // cria um container
          padding: const EdgeInsets.all(
            16.0,
          ), // espaçamento dos elementos internos
          margin: const EdgeInsets.all(
            16.0,
          ), // espaçamento entre container e elementos
          decoration: BoxDecoration(
            // estilo do container
            color: Colors.grey[850], // cor do container
            borderRadius: BorderRadius.circular(8.0), // borda do container
          ),

          child: Column(
            // conteúdo do container é uma coluna
            children: [ // todos os elementos da coluna
              TextField( // campo de texto
                style: TextStyle(color: Colors.white), //estilos do texto que é digitado pelo usuário
                decoration: InputDecoration( // colocar decoração
                  labelText: 'Faturamento Bruto', labelStyle: TextStyle(color: Colors.white)), // texto apresentado e estilo do texto
              ),

              SizedBox(height: 20), // distância entre um campo e outro no formulário

              DropdownButtonFormField( // campo de seleção
                style: TextStyle(color: Colors.white), // estilo da opção selecionado pelo usuário no campo
                decoration: InputDecoration( // colocar decoração
                  labelText: 'Regime Tributário', labelStyle: TextStyle(color: Colors.white)), //estilo das opções que aparecem para selecionar
                
                items: [
                  DropdownMenuItem(
                    value: 'simples', child: Text('Simples Nacional')),

                  DropdownMenuItem(
                    value: 'presumido', child: Text('Lucro Presumido')),

                  DropdownMenuItem(value: 'real', child: Text('Lucro Real')),
                ], // opções com seus valores e a forma escrita que o usuário vê

                onChanged: (novoValor) { // a partir do momento que o usuário clicar em uma nova opção, ela vai ser escolhida como novo valor
                  setState(() { // atualização do campo
                    regimeSelecionado = novoValor; // variável do regime tributário se torna o novo valor selecionado
                  });
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
