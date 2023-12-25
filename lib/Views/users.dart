import 'package:app_note/JsonModels/users.dart';
import 'package:app_note/SQLite/sqlite.dart';
import 'package:app_note/Views/create_user.dart';
import 'package:flutter/material.dart';

class Users extends StatefulWidget {
  const Users({super.key});

  @override
  State<Users> createState() => _UsersState();
}

class _UsersState extends State<Users> {
  late DatabaseHElper handler;
  late Future<List<UsersModel>> users;
  final db = DatabaseHElper();

  final username = TextEditingController();
  final password = TextEditingController();
  final keyword = TextEditingController();

  @override
  void initState() {
    handler = DatabaseHElper();
    users = handler.getUsers();

    handler.initDB().whenComplete(() {
      users = getAllUsers();
    });

    super.initState();
  }

  Future<List<UsersModel>> getAllUsers() {
    return handler.getUsers();
  }

  //METODO DE PESQUISAR
  
  Future<List<UsersModel>> searchUser() {
    return handler.searchUsers(keyword.text);
  }

  Future<void> _refresh() async {
    setState(() {
      users = getAllUsers();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Anotações"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,
                  MaterialPageRoute(builder: (context) => const CreateUser()))
              .then((value) {
            if (value) {
              _refresh();
            }
          });
        },
        child: const Icon(Icons.add),
      ),
      body: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 10),
            padding: const EdgeInsets.symmetric(horizontal: 10),
            decoration: BoxDecoration(
                color: Colors.grey.withOpacity(.2),
                borderRadius: BorderRadius.circular(8)),
            child: TextFormField(
              controller: keyword,
              onChanged: (value) {
                //quando digitamos no campo pesquisar
                if (value.isNotEmpty) {
                  setState(() {
                    users = searchUser();
                  });
                } else {
                  setState(() {
                    users = getAllUsers();
                  });
                }
              },
              decoration: const InputDecoration(
                  border: InputBorder.none,
                  icon: Icon(Icons.search),
                  hintText: "Pesquisar..."),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<UsersModel>>(
              future: users,
              builder: (BuildContext context,
                  AsyncSnapshot<List<UsersModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(child: Text("Sem dados... "));
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  final items = snapshot.data ?? <UsersModel>[];
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        title: Text(items[index].usrName),
                        subtitle: Text(items[index].usrPassword),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 255, 22, 5),
                          ),
                          onPressed: () {
                            db.deleteNote(items[index].usrId!).whenComplete(
                              () {
                                _refresh();
                              },
                            );
                          },
                        ),
                        onTap: () {
                          // esse setstate faz com que a coluna de editar ja mostre os dados que continham na linha
                          setState(() {
                            username.text = items[index].usrName;
                            password.text = items[index].usrPassword;
                          });
                          // esse showdialog faz que abra uma tela para editar os dados da linha
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                actions: [
                                  Row(
                                    children: [
                                      TextButton(
                                        onPressed: () {
                                          //este comando faz atualizar no bd os dados editados
                                          db
                                              .updateNote(
                                                  username.text,
                                                  password.text,
                                                  items[index].usrId)
                                              .whenComplete(
                                            () {
                                              _refresh(); // esse comando faz a tela atualizar e mostrar os dados novos
                                              Navigator.pop(context);
                                            },
                                          );
                                        },
                                        child: const Text("Atualizar"),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: const Text("Cancelar"),
                                      ),
                                    ],
                                  )
                                ],
                                backgroundColor: Colors.blue.shade200,
                                title: const Text("Editar usuário"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: username,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Nome de usuário não pode ser vazio";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        label: Text("Título"),
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
                                        label: Text("Conteúdo"),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          );
                        },
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
