import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/model/model_todo.dart';
import 'package:flutter_firebase_app/utils/card_todo.dart';
import 'package:flutter_firebase_app/view/create_todo.dart';

class ReadTodoPage extends StatefulWidget {
  const ReadTodoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _ReadTodoPageState createState() => _ReadTodoPageState();
}

class _ReadTodoPageState extends State<ReadTodoPage> {

  void handleCreateTodo(){
    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const CreateTodoPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: handleCreateTodo,
          ),
        ],
      ),
      body: FutureBuilder<List<Todo>>(
        future: Todo.readAllTodo(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error loading todos: ${snapshot.error}'),
            );
          } else {
            List<Todo> todos = snapshot.data ?? [];
            return ListView.builder(
              itemCount: todos.length,
              itemBuilder: (context, index) {
                Todo todo = todos[index];
                return CardTodo(todo: todo);
              },
            );
          }
        },
      ),
    );
  }
}
