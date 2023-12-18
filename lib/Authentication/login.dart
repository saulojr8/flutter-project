import 'package:app_note/Authentication/signup.dart';
import 'package:app_note/JsonModels/users.dart';
import 'package:app_note/SQLite/sqlite.dart';
import 'package:app_note/Views/notes.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final username = TextEditingController();
  final password = TextEditingController();

  bool isVisible = true; // variavel servira para mostrar e ocultar o password
  bool isLoginTrue =
      false; // variavel serve para verificar se o usuario existe ao tentar logar

  final db = DatabaseHElper();

  login() async {
    var response = await db
        .login(Users(usrName: username.text, usrPassword: password.text));
    if (response == true) {
      //esta função faz o usuario ir para a tela Notes quando o login esta correto
      if (!mounted) return;
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const Notes()));
    } else {
      //se o login estiver errado ira mostrar a mensagem de erro
      setState(() {
        isLoginTrue = true;
      });
    }
  }

  final formKey =
      GlobalKey<FormState>(); // essa variavel serve para o form ser validado

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Form(
              // é necessario ser no form para que os textos sejam controlados
              key: formKey,
              child: Column(
                children: [
                  Image.asset("lib/assets/system.png",
                      width: 150), //coloca uma imagem e define o tamanho dela
                  const SizedBox(height: 15),
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
                  const SizedBox(height: 10),
                  //botão de login
                  Container(
                    height: 55,
                    width: MediaQuery.of(context).size.width * .9,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.deepPurple),
                    child: TextButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            //função de login
                            login();
                          }
                        },
                        child: const Text(
                          "LOGIN",
                          style: TextStyle(color: Colors.white),
                        )),
                  ),

                  //botão de se inscrever
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Ainda não tem uma conta?"),
                      TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const SignUp()));
                          },
                          child: const Text("Se inscreva!"))
                    ],
                  ),
                  //a linha abaixo serve para mostrar uma mensagem quando o usuario que tenta logar nao existe no banco de dados
                  isLoginTrue
                      ? const Text(
                          "Usuário ou senha estão incorretos,",
                          style: TextStyle(color: Colors.red),
                        )
                      : const SizedBox()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
