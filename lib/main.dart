import 'package:flutter/material.dart';

void main() {
  runApp(const MeuApp());
}

class MeuApp extends StatelessWidget {
  const MeuApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TelaAgendamento());
  }
}

class TelaAgendamento extends StatefulWidget {
  const TelaAgendamento({super.key});

  @override
  _TelaAgendamentoState createState() => _TelaAgendamentoState();
}

class _TelaAgendamentoState extends State<TelaAgendamento> {
  final TextEditingController _controller = TextEditingController();
  DateTime? _dataSelecionada;
  TimeOfDay? _horaSelecionada;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agendamentos do Salão de Beleza')),

      body: Center(
        child: Column(
          children: [
            const SizedBox(height: 30),

            SizedBox(
              width: 300,
              child: TextField(
                controller: _controller,
                decoration: const InputDecoration(
                  labelText: 'Seu Nome',
                  border: OutlineInputBorder(),
                ),
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: 300,
              child: TextField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Selecione a Data',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.calendar_today),
                ),

                onTap: () async {
                  DateTime? dataSelecionada = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime.now(),
                    lastDate: DateTime(2027),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            SizedBox(
              width: 300,
              child: TextField(
                readOnly: true,
                decoration: const InputDecoration(
                  labelText: 'Selecione o Horário',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.access_time),
                ),

                onTap: () async {
                  TimeOfDay? horaSelecionada = await showTimePicker(
                    context: context,
                    initialTime: TimeOfDay.now(),
                  );
                },
              ),
            ),

            const SizedBox(height: 30),

            SizedBox(
              width: 300,
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Observações',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
