import 'package:flutter/material.dart';
import 'package:notes/Screens/login_page.dart';
import 'package:notes/Screens/signup_page.dart';
import 'package:notes/Screens/notes_list_page.dart';

void main() {
  runApp(const NotesApp());
}

class NotesApp extends StatelessWidget {
  const NotesApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Notes App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const LoginPage(),
        'SignupPage': (context) => SignupPage(),
        'NotesListPage': (context) => const NotesListPage(),
      },
    );
  }
}
