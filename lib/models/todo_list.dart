import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:todo_list/models/todo.dart';

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = [];

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int get todoCount => _todos.length;
  int get incompleteCount =>
      _todos.where((todo) => todo.complete == false).length;

  void add(Todo todo) {
    _todos.add(todo);
    notifyListeners();
  }

  void removeAll() {
    _todos.clear();
    notifyListeners();
  }

  void delete(Todo todo) {
    _todos.remove(todo);
    notifyListeners();
  }

  void updateTodo(Todo todo, bool complete) {
    final int index = _todos.indexOf(todo);

    _todos[index] = Todo(
      name: todo.name,
      description: todo.description,
      complete: complete,
    );

    notifyListeners();
  }
}
