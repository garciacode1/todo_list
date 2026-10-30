import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/models/todo_list.dart';

class TodoWidget extends StatefulWidget {
  final Todo todo;

  const TodoWidget({super.key, required this.todo});

  @override
  State<TodoWidget> createState() => _TodoWidgetState();
}

class _TodoWidgetState extends State<TodoWidget> {
  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: GlobalKey(),
      onDismissed: (direction) {
        Provider.of<TodoList>(context, listen: false).delete(widget.todo);
      },

      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.lightBlue,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [BoxShadow(blurRadius: 4)],
        ),

        child: Row(
          children: [
            Expanded(child: Text(widget.todo.toString())),

            Checkbox(
              value: widget.todo.complete,
              onChanged: (bool? value) {
                setState(() {
                  Provider.of<TodoList>(
                    context,
                    listen: false,
                  ).updateTodo(widget.todo, value ?? false);
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
