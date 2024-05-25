import 'package:cloud_firestore/cloud_firestore.dart';

class Todo {
  String ?id;
  String title;
  String description;
  bool isCompleted;

  Todo({
    this.id,
    required this.title,
    required this.description,
    required this.isCompleted,
  });

  // Factory method to create a Todo object from a map (e.g., from JSON data)
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      isCompleted: json['isCompleted'],
    );
  }

  // Method to convert a Todo object to a map (e.g., for JSON serialization)
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'isCompleted': isCompleted,
    };
  }

  static Future<void> updateStatusTodo(Todo newTodo) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference todoCollection = firestore.collection('todo');

    try {
      await todoCollection.doc(newTodo.id).update(newTodo.toJson());
      print('Todo updated successfully');
    } catch (e) {
      print('Error updating todo: $e');
    }
  }

  static Future<void> addTodo(Todo newTodo) async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference todoCollection = firestore.collection('todo');

    try {
      await todoCollection.add(newTodo.toJson());
      // ignore: avoid_print
      print('Todo added successfully');
    } catch (e) {
      // ignore: avoid_print
      print('Error adding todo: $e');
    }
  }

  static Future<List<Todo>> readAllTodo() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    CollectionReference todoCollection = firestore.collection('todo');

    try {
      QuerySnapshot querySnapshot = await todoCollection.get();
      
      List<Todo> todos = querySnapshot.docs.map((doc) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;

        return Todo(
          id: doc.id,
          title: data['title'],
          description: data['description'],
          isCompleted: data['isCompleted'],
        );
      }).toList();
      return todos;

    } catch (e) {
      // ignore: avoid_print
      print("Error reading todos: $e");
      return [];
    }
  }

}
