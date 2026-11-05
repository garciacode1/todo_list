import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:todo_list/firebase_options.dart';
import 'package:todo_list/models/todo.dart';
import 'package:todo_list/services/i_data_source.dart';

class RemoteAPIDataSource implements IDataSource {
  late FirebaseDatabase database;

  Future<void> initialise() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );

    database = FirebaseDatabase.instance;
  }

  static Future<IDataSource> createAsync() async {
    RemoteAPIDataSource dataSource = RemoteAPIDataSource();

    await dataSource.initialise();

    return dataSource;
  }

  @override
  Future<List<Todo>> browse() async {
    final DataSnapshot snapshot = await database.ref('todos').get();

    if (!snapshot.exists) {
      throw Exception(
        'Invalid Request - Cannot find snapshot: ${snapshot.ref.path}',
      );
    }

    final Map<dynamic, dynamic> values =
        snapshot.value as Map<dynamic, dynamic>;

    List<Todo> todos = [];

    values.forEach((key, value) {
      Map<String, dynamic> todoMap = Map<String, dynamic>.from(value);

      todoMap['id'] = key.toString();

      todos.add(Todo.fromMap(todoMap));
    });

    return todos;
  }

  @override
  Future<bool> add(Todo model) async {
    DatabaseReference newTodoRef = database.ref('todos').push();

    String? key = newTodoRef.key;

    if (key == null) {
      return false;
    }

    Todo newTodo = Todo(
      id: key,
      name: model.name,
      description: model.description,
      complete: model.complete,
    );

    await newTodoRef.set(newTodo.toMap());

    return true;
  }

  @override
  Future<bool> delete(Todo model) async {
    if (model.id.isEmpty || model.id == '0') {
      return false;
    }

    DatabaseReference todoRef = database.ref('todos/${model.id}');

    await todoRef.remove();

    return true;
  }

  @override
  Future<Todo?> read(String id) async {
    final DataSnapshot snapshot = await database.ref('todos/$id').get();

    if (!snapshot.exists || snapshot.value == null) {
      return null;
    }

    Map<String, dynamic> todoMap = Map<String, dynamic>.from(
      snapshot.value as Map,
    );

    todoMap['id'] = id;

    return Todo.fromMap(todoMap);
  }

  @override
  Future<bool> edit(Todo model) async {
    if (model.id.isEmpty || model.id == '0') {
      return false;
    }

    DatabaseReference todoRef = database.ref('todos/${model.id}');

    await todoRef.set(model.toMap());

    return true;
  }
}
