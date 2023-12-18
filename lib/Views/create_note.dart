import 'package:app_note/JsonModels/note_model.dart';
import 'package:app_note/SQLite/sqlite.dart';
import 'package:flutter/material.dart';

class CreateNote extends StatefulWidget {
  const CreateNote({super.key});

  @override
  State<CreateNote> createState() => _CreateNoteState();
}

class _CreateNoteState extends State<CreateNote> {
  final title = TextEditingController();
  final content = TextEditingController();
  final formKey = GlobalKey<FormState>(); //variavel de validar o form

  final db = DatabaseHElper();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Criar uma anotação"),
        actions: [
          IconButton(
            onPressed: () {
              if (formKey.currentState!.validate()){// essa linha faz com que não inclua registros em branco
                db
                  .createNote(NoteModel(
                     noteTitle: title.text,
                     noteContent: content.text))
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
      ),),
    );
  }
}
