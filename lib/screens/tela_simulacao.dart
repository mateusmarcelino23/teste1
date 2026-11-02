import 'package:flutter/material.dart'; // importando o pacote para usar os widgets do Flutter

class TelaSimulacao extends StatefulWidget { // inicia a class com o tipo de widget dinâmico porque a página precisa guardar informações
  const TelaSimulacao({super.key}); // construtor da classe

  @override
  State<TelaSimulacao> createState() => _SimulacaoState(); // criando state para fazer a próxima classe (statefulwdget precisa de duas classes)
}

class _SimulacaoState extends State<TelaSimulacao> { // classe essencial especialmente para statefulwidget onde será construída a tela
  @override
  Widget build(BuildContext context) { // construindo widget
    return Scaffold(
      // estrutura básica da página
      backgroundColor: const Color(0xFF212127), // cor de fundo

      appBar: AppBar(title: const Text('Fazer Simulação')), // título na barra superior
      
      body: Center( // todos os elementos ficarão no centro da tela
        child: Container( // cria um container
          padding: const EdgeInsets.all(16.0), // espaçamento dos elementos internos
          margin: const EdgeInsets.all(16.0), // espaçamento entre container e elementos
          decoration: BoxDecoration( // estilo do container
            color: Colors.grey[850], // cor do container
            borderRadius: BorderRadius.circular(8.0), // borda do container
          ),

          child: const Column( // conteúdo do container é uma coluna
             children: [
              
             ],
          ), 
        ),
      ),
    );
  }
}
