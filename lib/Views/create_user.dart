
import 'package:app_note/JsonModels/users.dart';
import 'package:app_note/SQLite/sqlite.dart';
import 'package:flutter/material.dart';

class CreateUser extends StatefulWidget {
  const CreateUser({super.key});

  @override
  State<CreateUser> createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final username = TextEditingController();
  final password = TextEditingController();
  final formKey = GlobalKey<FormState>(); //variavel de validar o form

  final db = DatabaseHElper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar um novo usuário"),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()){// essa linha faz com que não inclua registros em branco
                db
                  .signup(UsersModel(
                     usrName: username.text,
                     usrPassword: password.text))
                  .whenComplete(() {
                    Navigator.of(context).pop(true);
                  });
                }        
              },            
              icon: const Icon(
                Icons.check,
                size: 35,
                color: Color.fromARGB(
                  255,
                  20,
                  144,
                  245,
                ),
             ),
          ),
        ],
      ),
      body: Form(
        key: formKey,
          child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextFormField(
              controller: username,
              validator: (value) {
                if (value!.isEmpty) {
                  return "O nome de usuário não pode ser vazio";
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text("Nome"),
              ),
            ),
            TextFormField(
              controller: password,
              validator: (value) {
                if (value!.isEmpty) {
                  return "A senha não pode ser vazia";
                }
                return null;
              },
              decoration: const InputDecoration(
                label: Text("Senha"),
              ),
            ),
          ],
        ),
      ),),
    );
  }
}
