import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/i_data_source.dart';

class HiveDataSource implements IDataSource {
  late Box<Todo> _box;

  Future<void> initialise() async {
    await Hive.initFlutter();

    Hive.registerAdapter(TodoAdapter());

    _box = await Hive.openBox<Todo>('todos');
  }

  static Future<IDataSource> createAsync() async {
    HiveDataSource dataSource = HiveDataSource();

    await dataSource.initialise();

    return dataSource;
  }

  @override
  Future<List<Todo>> browse() async {
    return _box.values.toList();
  }

  @override
  Future<bool> add(Todo model) async {
    int key = await _box.add(model);

    Todo updatedTodo = Todo(
      id: key.toString(),
      name: model.name,
      description: model.description,
      complete: model.complete,
    );

    await _box.put(key, updatedTodo);

    return true;
  }

  @override
  Future<bool> delete(Todo model) async {
    int? key = int.tryParse(model.id);

    if (key == null || !_box.containsKey(key)) {
      return false;
    }

    await _box.delete(key);

    return true;
  }

  @override
  Future<Todo?> read(String id) async {
    int? key = int.tryParse(id);

    if (key == null) {
      return null;
    }

    return _box.get(key);
  }

  @override
  Future<bool> edit(Todo model) async {
    int? key = int.tryParse(model.id);

    if (key == null || !_box.containsKey(key)) {
      return false;
    }

    await _box.put(key, model);

    return true;
  }
}
