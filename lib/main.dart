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
      description: 'Put all the dirty clothes inside the washing machine',
    ),
    Todo(
      name: 'Gym time',
      description: 'Complete the workout session of the day',
    ),
    Todo(
      name: 'Cutting the grass',
      description: 'I plan to cut my garden grass completely',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Todo List')),
      body: Center(
        child: ListView.builder(
          itemCount: todos.length,
          itemBuilder: (BuildContext context, int i) {
            return Container(
              margin: const EdgeInsets.all(8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.lightBlue,
                borderRadius: BorderRadius.circular(8),
                boxShadow: const [BoxShadow(blurRadius: 4)],
              ),

              child: Text(todos[i].toString()),
            );
          },
        ),
      ),
    );
  }
}
