import 'package:app_note/Authentication/login.dart';
import 'package:app_note/JsonModels/users.dart';
import 'package:app_note/SQLite/sqlite.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final username = TextEditingController();
  final password = TextEditingController();
  final confirmPassword = TextEditingController();

  final formKey = GlobalKey<FormState>();

  bool isVisible = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //singlechildscrolview serve para ter barra de rolagem na tela
      body: Center(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const ListTile(
                    title: Text("Crie um novo usuário",
                        style: TextStyle(
                            fontSize: 45, fontWeight: FontWeight.bold)),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                      controller: username,
                      validator: (value) {
                        if (value!.isEmpty) {
                          return "Usuário não pode ser vazio";
                        }
                        return null;
                      },
                      decoration: const InputDecoration(
                        icon: Icon(Icons.person),
                        border: InputBorder.none,
                        hintText: ("Usuário"),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "A senha não pode ser vazia";
                          }
                          return null;
                        },
                        obscureText: isVisible,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: ("Senha"),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible =
                                      !isVisible; //esta linha faz o password ficar invisivel e invisivel
                                });
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons
                                      .visibility_off)), // este comando faz o icone alterar
                        )),
                  ),

                  //confirmação de senha
                  Container(
                    margin: const EdgeInsets.all(8),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple.withOpacity(.2)),
                    child: TextFormField(
                        controller: confirmPassword,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "A senha não pode ser vazia";
                          } else if (password.text != confirmPassword.text) {
                            //este if verifica se os dois campos do passwords estão iguais
                            return "As senhas não estão iguais";
                          }
                          return null;
                        },
                        obscureText: isVisible,
                        decoration: InputDecoration(
                          icon: const Icon(Icons.lock),
                          border: InputBorder.none,
                          hintText: ("Confirme a senha"),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  isVisible =
                                      !isVisible; //esta linha faz o password ficar visivel e invisivel
                                });
                              },
                              icon: Icon(isVisible
                                  ? Icons.visibility
                                  : Icons
                                      .visibility_off)), // este comando faz o icone alterar
                        )),
                  ),

                  const SizedBox(height: 10),

                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple),
                    child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            //função de registrar
                            final db = DatabaseHElper();
                            db
                                .signup(Users(
                                    usrName: username.text,
                                    usrPassword: password.text))
                                .whenComplete(() {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const LoginScreen()));
                            });
                          }
                        },
                        child: const Text(
                          "REGISTRAR",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),

                  //botão de se inscrever
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Já tem uma conta?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const LoginScreen()));
                          },
                          child: const Text("Faça o login"))
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
