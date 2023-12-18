import 'package:app_note/JsonModels/note_model.dart';
import 'package:app_note/SQLite/sqlite.dart';
import 'package:app_note/Views/create_note.dart';
import 'package:flutter/material.dart';

class Notes extends StatefulWidget {
  const Notes({super.key});

  @override
  State<Notes> createState() => _NotesState();
}

class _NotesState extends State<Notes> {
  late DatabaseHElper handler;
  late Future<List<NoteModel>> notes;
  final db = DatabaseHElper();

  final title = TextEditingController();
  final content = TextEditingController();
  final keyword = TextEditingController();

  @override
  void initState() {
    handler = DatabaseHElper();
    notes = handler.getNotes();

    handler.initDB().whenComplete(() {
      notes = getAllNotes();
    });

    super.initState();
  }

  Future<List<NoteModel>> getAllNotes() {
    return handler.getNotes();
  }

  //METODO DE PESQUISAR
  Future<List<NoteModel>> searchNote() {
    return handler.searchNotes(keyword.text);
  }

  Future<void> _refresh() async {
    setState(() {
      notes = getAllNotes();
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
                  MaterialPageRoute(builder: (context) => const CreateNote()))
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
                    notes = searchNote();
                  });
                } else {
                  setState(() {
                    notes = getAllNotes();
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
            child: FutureBuilder<List<NoteModel>>(
              future: notes,
              builder: (BuildContext context,
                  AsyncSnapshot<List<NoteModel>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const CircularProgressIndicator();
                } else if (snapshot.hasData && snapshot.data!.isEmpty) {
                  return const Center(child: Text("Sem dados... "));
                } else if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                } else {
                  final items = snapshot.data ?? <NoteModel>[];
                  return ListView.builder(
                    itemCount: items.length,
                    itemBuilder: (context, index) {
                      return ListTile(
                        //subtitle: Text(DateFormat("yMd").format(DateTime.parse(items[index].createdAt))),
                        title: Text(items[index].noteTitle),
                        subtitle: Text(items[index].noteContent),
                        trailing: IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: Color.fromARGB(255, 255, 22, 5),
                          ),
                          onPressed: () {
                            db.deleteNote(items[index].noteId!).whenComplete(
                              () {
                                _refresh();
                              },
                            );
                          },
                        ),
                        onTap: () {
                          // esse setstate faz com que a coluna de editar ja mostre os dados que continham na linha
                          setState(() {
                            title.text = items[index].noteTitle;
                            content.text = items[index].noteContent;
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
                                                  title.text,
                                                  content.text,
                                                  items[index].noteId)
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
                                title: const Text("Editar anotação"),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    TextFormField(
                                      controller: title,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Título não pode ser vazio";
                                        }
                                        return null;
                                      },
                                      decoration: const InputDecoration(
                                        label: Text("Título"),
                                      ),
                                    ),
                                    TextFormField(
                                      controller: content,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Conteudo não pode ser vazio";
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
