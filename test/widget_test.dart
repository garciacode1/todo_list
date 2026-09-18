import 'package:flutter_test/flutter_test.dart';
import 'package:todo_list/main.dart';

void main() {
  testWidgets('Todo list loads correctly', (WidgetTester tester) async {
    await tester.pumpWidget(const TodoApp());

    expect(find.text('Todo List'), findsOneWidget);
    expect(find.textContaining('Doing laundry'), findsOneWidget);
  });
}
