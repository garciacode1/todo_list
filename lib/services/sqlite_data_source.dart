import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/i_data_source.dart';

class SQLiteDataSource implements IDataSource {
  late Database _database;

  Future<void> initialise() async {
    _database = await openDatabase(
      join(await getDatabasesPath(), 'todo_database.db'),
      version: 1,
      onCreate: (db, version) async {
        await db.execute(
          'CREATE TABLE IF NOT EXISTS todos ('
          'id INTEGER PRIMARY KEY, '
          'name TEXT, '
          'description TEXT, '
          'complete INTEGER'
          ')',
        );
      },
    );
  }

  static Future<IDataSource> createAsync() async {
    SQLiteDataSource dataSource = SQLiteDataSource();

    await dataSource.initialise();

    return dataSource;
  }

  @override
  Future<List<Todo>> browse() async {
    List<Map<String, dynamic>> maps = await _database.query('todos');

    return List.generate(maps.length, (index) {
      return Todo.fromMap(maps[index]);
    });
  }

  @override
  Future<bool> add(Todo model) async {
    Map<String, dynamic> editedMap = model.toMap();

    editedMap.remove('id');

    int result = await _database.insert('todos', editedMap);

    return result > 0;
  }

  @override
  Future<bool> delete(Todo model) async {
    int result = await _database.delete(
      'todos',
      where: 'id = ?',
      whereArgs: [model.id],
    );

    return result > 0;
  }

  @override
  Future<Todo?> read(String id) {
    throw UnimplementedError();
  }

  @override
  Future<bool> edit(Todo model) async {
    Map<String, dynamic> editedMap = model.toMap();

    int result = await _database.update(
      'todos',
      editedMap,
      where: 'id = ?',
      whereArgs: [model.id],
    );

    return result > 0;
  }
}
