import 'package:flutter/material.dart'; // importando o pacote para usar os widgets do Flutter

class TelaRelatorios extends StatefulWidget { // inicia a class com o tipo de widget dinâmico porque a página precisa guardar informações
  const TelaRelatorios({super.key}); // construtor da classe

  @override
  State<TelaRelatorios> createState() => _RelatoriosState(); // criando state para fazer a próxima classe (statefulwdget precisa de duas classes)
}

class _RelatoriosState extends State<TelaRelatorios> { // classe essencial especialmente para statefulwidget onde será construída a tela
  @override
  Widget build(BuildContext context) { // construindo widget
    return Scaffold(
      // estrutura básica da página
      backgroundColor: const Color(0xFF212127), // cor de fundo

      appBar: AppBar(title: const Text('Simulações Feitas')), // título na barra superior

      body: Center( // todos os elementos ficarão no centro da tela

      )
    );
  }
}
