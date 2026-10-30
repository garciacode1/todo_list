import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/models/todo_list.dart';
import 'package:todo_list/views/todo_widget.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => TodoList(),
      child: const TodoApp(),
    ),
  );
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Todo List',
      home: TodoHomePage(),
    );
  }
}

class TodoHomePage extends StatefulWidget {
  const TodoHomePage({super.key});

  @override
  State<TodoHomePage> createState() => _TodoHomePageState();
}

class _TodoHomePageState extends State<TodoHomePage> {
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
                  Provider.of<TodoList>(context, listen: false).add(
                    Todo(
                      name: _controlName.text,
                      description: _controlDescription.text,
                    ),
                  );

                  _controlName.clear();
                  _controlDescription.clear();

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
      appBar: AppBar(
        title: const Text('Todo List'),
        actions: [
          Consumer<TodoList>(
            builder: (context, model, child) {
              return Padding(
                padding: const EdgeInsets.all(16),
                child: Center(
                  child: Text('Incomplete: ${model.incompleteCount}'),
                ),
              );
            },
          ),
        ],
      ),

      body: Consumer<TodoList>(
        builder: (context, model, child) {
          return ListView.builder(
            itemCount: model.todoCount,
            itemBuilder: (BuildContext context, int i) {
              return TodoWidget(todo: model.todos[i]);
            },
          );
        },
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: _openAddTodo,
        tooltip: 'Add Todo',
        child: const Icon(Icons.add),
      ),
    );
  }
}
