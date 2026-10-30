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

  final TextEditingController _controlName = TextEditingController();
  final TextEditingController _controlDescription = TextEditingController();
  void _openAddTodo() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add Todo'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
                child: Text('Name'),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 8),
                child: TextFormField(controller: _controlName),
              ),

              const Padding(
                padding: EdgeInsets.fromLTRB(5, 8, 5, 0),
                child: Text('Description'),
              ),

              Padding(
                padding: const EdgeInsets.fromLTRB(5, 0, 5, 8),
                child: TextFormField(controller: _controlDescription),
              ),

              ElevatedButton(
                child: const Text('Submit'),
                onPressed: () {
                  setState(() {
                    todos.add(
                      Todo(
                        name: _controlName.text,
                        description: _controlDescription.text,
                      ),
                    );
                  });

                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

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
      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTodo,
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
