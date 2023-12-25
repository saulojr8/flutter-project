import 'package:app_note/Views/notes.dart';
import 'package:app_note/Views/users.dart';
import 'package:flutter/material.dart';

class MyDashboard extends StatelessWidget {
  const MyDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bem vindo ao Dashboard"),
      ),
      body: Center(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Notes(),
                    ),
                  );
                },
                child: const Text('Criar Tarefas'),
              ),
              const SizedBox(height: 16), // Adiciona um espaço entre os botões
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Users(),
                    ),
                  );
                },
                child: const Text('Criar Usuários'),
              ),
            ]),
      ),
    );
  }
}
