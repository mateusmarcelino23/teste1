import 'package:flutter/material.dart'; // importando o pacote para usar os widgets do Flutter
import 'tela_simulacao.dart'; // importando arquivo da página de simulação
import 'tela_relatorios.dart'; // importando arquivo da página de simulações já feitas

class TelaPrincipal extends StatelessWidget {
  // classe que representa a tela inicial
  const TelaPrincipal({super.key}); // construtor da classe

  @override
  Widget build(BuildContext context) {
    // criando o primeiro widget para a tela
    return Scaffold(
      // estrutura básica da página
      backgroundColor: Color(0xFF212127), // cor de fundo

      appBar: AppBar(
        title: Text('Simulador Financeiro B2B'),
      ), // appbar com o texto que aparece na parte de cima da tela

      body: Center(
        // todos os elementos ficam centralizados
        child: Column(
          // indica que a estrutura dos elementos será empilhada
          mainAxisAlignment: MainAxisAlignment
              .center, // deixa todos os elementos centralizados verticalmente
          crossAxisAlignment: CrossAxisAlignment
              .center, // deixa todos os elementos centralizados horizontalmente

          children: [
            // elementos da tela
            ElevatedButton(
              // botão
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaSimulacao(),
                  ),
                ); // redirecionamento para a página que possui a classe
              },
              child: const Text('Iniciar simulação'), // texto do botão
            ),

            SizedBox(height: 16),

            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TelaRelatorios()
                  ),
                ); // redirecionamento para a página que possui a classe
              },
              child: const Text('Ver minhas simulações'),
            ),
          ],
        ),
      ),
    );
  }
}
