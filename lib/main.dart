import 'package:flutter/material.dart'; // importando o pacote para usar os widgets do Flutter
import 'screens/tela_inicial.dart'; // importando arquivo da tela inicial com o home "TelaPrincipal"

void main() {
  runApp(const MeuApp());
} // função principal que inicia o aplicativo Flutter

class MeuApp extends StatelessWidget {
  // classe que representa o aplicativo Flutter
  const MeuApp({
    super.key,
  }); // construtor da classe MeuApp (super.key é usado para passar a chave para a classe pai StatelessWidget)

  @override // reescreve o método build da classe StatelessWidget
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner:
          false, // Tira o banner de "Debug" no lado da tela
      title:
          'Simulador Financeiro B2B', // Nome que aparece no gerenciador de tarefas do celular/navegador
      home: TelaPrincipal(),
    );
  } // retorna um widget MaterialApp que define a tela principal do aplicativo como TelaPrincipal
}
