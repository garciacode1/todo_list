import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';

void main() {
  runApp(const TodoApp());
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(title: 'Todo List', home: TodoHomePage());
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
  final List<Todo> todos = <Todo>[
    Todo(
      name: 'Doing laundry',
      description: 'put all the dirty clothes inside the washng machine',
    ),
    Todo(
      name: 'Gym time',
      description: 'complete the workout session of the day',
    ),
    Todo(
      name: 'Cutting the grass',
      description: 'I plan to cut my gardens grass completely. ',
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: const Center(child: Text('Todo App')),
    );
  }
}
