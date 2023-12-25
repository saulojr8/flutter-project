import 'dart:io';
import 'package:app_note/Views/notes.dart';
import 'package:app_note/Views/users.dart';
import 'package:flutter/material.dart';
//import 'package:grid/Homepage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyDashboard(),
    );
  }
}

class MyDashboard extends StatefulWidget {
  const MyDashboard({super.key});

  @override
  _MyDashboardState createState() => _MyDashboardState();
}

class _MyDashboardState extends State<MyDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Seja bem vindo ao Dashboard",
          style: TextStyle(color: Colors.deepPurple, fontSize: 25),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: GridView(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, mainAxisSpacing: 10, crossAxisSpacing: 10),
          children: [
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Notes()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepPurple.withOpacity(.2),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.home,
                      size: 50,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "Tarefas",
                      style: TextStyle(color: Colors.deepPurple, fontSize: 30),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                //Navigator.push(context, MaterialPageRoute(builder: (context)=>HomePage()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepPurple.withOpacity(.2),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.search,
                      size: 50,
                      color: Colors.deepPurple.withOpacity(.2),
                    ),
                    const Text(
                      "Icone",
                      style: TextStyle(color: Colors.deepPurple, fontSize: 30),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const Users()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepPurple.withOpacity(.2),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.person,
                      size: 50,
                      color: Colors.deepPurple,
                    ),
                    Text(
                      "Usuários",
                      style: TextStyle(color: Colors.deepPurple, fontSize: 30),
                    )
                  ],
                ),
              ),
            ),
            InkWell(
              onTap: () {
                sairDoAplicativo();

                //  MaterialPageRoute(builder: (context) => const Users()));
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: Colors.deepPurple.withOpacity(.2),
                ),
                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.logout, size: 50, color: Colors.deepPurple),
                    Text(
                      "Sair",
                      style: TextStyle(color: Colors.deepPurple, fontSize: 30),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void sairDoAplicativo() {
  exit(0);
}
