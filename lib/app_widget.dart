import 'package:flutter/material.dart';
import 'package:notes/handle_note_page.dart';
import 'package:notes/home_page.dart';

class AppWidget extends StatelessWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      title: 'Notes',
      initialRoute: '/home',
      routes: {
        '/home': (context) => const HomePage(),
        '/handle-note': (context) => const HandleNotePage(),
      },
    );
  }
}
