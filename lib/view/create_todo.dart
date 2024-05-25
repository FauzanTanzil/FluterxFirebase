import 'package:flutter/material.dart';
import 'package:flutter_firebase_app/model/model_todo.dart';
import 'package:flutter_firebase_app/view/read_todo.dart';

class CreateTodoPage extends StatefulWidget {
  const CreateTodoPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _TodoCreateScreenState createState() => _TodoCreateScreenState();
}

class _TodoCreateScreenState extends State<CreateTodoPage> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();


  @override
  Widget build(BuildContext context) {
   
    void showSuccessMessage(String message, Color color) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: color, // Set the background color
        ),
      );
    }

    void createTodo() async {
      String title = titleController.text;
      String description = descriptionController.text;
      bool isCompleted = false;

      if(title == '' || description == '') {
        showSuccessMessage("All field must be filled!", Colors.red);
        return;
      }

      await Todo.addTodo(Todo(
        title: title,
        description: description,
        isCompleted: isCompleted,
      ));

      showSuccessMessage("Success create new to do!", Colors.green);
    }

    void handleBack(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const ReadTodoPage()));
    }
    
    return Scaffold(
      appBar: AppBar(
        title: const Text('Create New Todo'),
         leading: IconButton(
          icon: const Icon(Icons.arrow_back), // Replace with your preferred icon
          onPressed: handleBack,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description',
              ),
            ),
            ElevatedButton(
              onPressed: createTodo,
              child: const Text('Create Todo'),
            ),
          ],
        ),
      ),
    );
  }
}