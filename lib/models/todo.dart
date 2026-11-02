class Todo {
  final String id;
  final String name;
  final String description;
  final bool complete;

  Todo({
    this.id = '0',
    required this.name,
    required this.description,
    this.complete = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'complete': complete ? 1 : 0,
    };
  }

  factory Todo.fromMap(Map<String, dynamic> map) {
    bool complete;

    if (map['complete'] is bool) {
      complete = map['complete'];
    } else if (map['complete'] is int) {
      complete = map['complete'] == 1;
    } else {
      complete = false;
    }

    return Todo(
      id: map['id'].toString(),
      name: map['name'],
      description: map['description'],
      complete: complete,
    );
  }

  @override
  String toString() {
    return '$name - $description';
  }
}
