
import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/model/model_todo.dart';

class CardTodo extends StatefulWidget {
  const CardTodo({
    super.key,
    required this.todo,
  });

  final Todo todo;

  @override
  State<CardTodo> createState() => _CardTodoState();
}

class _CardTodoState extends State<CardTodo> {

  void showSuccessMessage(String message, Color color) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: color, // Set the background color
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.todo.title),
      subtitle: Text(widget.todo.description),
      trailing: Checkbox(
        value: widget.todo.isCompleted,
        onChanged: (bool? value) {
          setState(() {
            widget.todo.isCompleted = !widget.todo.isCompleted;
          });
          Todo.updateStatusTodo(widget.todo);
          showSuccessMessage("Todo updated successfully", Colors.green);
        },
      ),
    );
  }
}
