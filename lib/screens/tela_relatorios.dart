import 'package:flutter/material.dart';

class TelaRelatorios extends StatefulWidget { // inicia a class com o tipo de widget dinâmico porque a página precisa guardar informações
  const TelaRelatorios({super.key});

  @override
  State<TelaRelatorios> createState() => _RelatoriosState(); // criando state
}

class _RelatoriosState extends State<TelaRelatorios> { // classe essencial especialmente para statefulwidget
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // estrutura básica da página
      backgroundColor: Color(0xFF212127), // cor de fundo
    );
  }
}
