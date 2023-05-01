import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todo_firebase/todo_list.dart';

void main() async {
  // Inicializar o Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
  // Seu código aqui...
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text(snapshot.error.toString())),
          );
        }
        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return Loading();
        // }
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: TodoList(),
          theme: ThemeData(
              scaffoldBackgroundColor: Colors.blueGrey[900],
              primarySwatch: Colors.pink,
              appBarTheme: AppBarTheme(
             color: Colors.white
              )),
        );
      },
    );
  }
}
