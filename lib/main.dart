import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/firebase_options.dart';
import 'package:flutter_firebase_app/view/read_todo.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if Firebase has already been initialized
  if (Firebase.apps.isEmpty) {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  }

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: ReadTodoPage(),
  ));
}
