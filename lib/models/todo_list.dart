import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/i_data_source.dart';

class TodoList extends ChangeNotifier {
  final List<Todo> _todos = [];

  UnmodifiableListView<Todo> get todos => UnmodifiableListView(_todos);

  int get todoCount => _todos.length;

  int get incompleteCount =>
      _todos.where((todo) => todo.complete == false).length;

  Future<List<Todo>> refresh() async {
    IDataSource dataSource = Get.find<IDataSource>();

    _todos.clear();
    _todos.addAll(await dataSource.browse());

    notifyListeners();

    return _todos;
  }

  Future<void> add(Todo todo) async {
    IDataSource dataSource = Get.find<IDataSource>();

    await dataSource.add(todo);

    await refresh();
  }

  void removeAll() {
    _todos.clear();
    notifyListeners();
  }

  Future<void> delete(Todo todo) async {
    IDataSource dataSource = Get.find<IDataSource>();

    await dataSource.delete(todo);

    await refresh();
  }

  Future<void> updateTodo(Todo todo, bool complete) async {
    IDataSource dataSource = Get.find<IDataSource>();

    Todo updatedTodo = Todo(
      id: todo.id,
      name: todo.name,
      description: todo.description,
      complete: complete,
    );

    await dataSource.edit(updatedTodo);

    await refresh();
  }
}
