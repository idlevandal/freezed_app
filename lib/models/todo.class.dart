import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

// flutter pub run build_runner build --delete-conflicting-outputs
part 'todo.class.freezed.dart';
part 'todo.class.g.dart';

@Freezed()
class Todo with _$Todo {
  const factory Todo({
    required int id,
    required int userId,
    required String title,
    String? userName,
    @Default(true) bool completed,
  }) = _Todo;

  factory Todo.fromJson(Map<String, dynamic> json)
    => _$TodoFromJson(json);
}

class TodoList extends StateNotifier<List<Todo>> {
  TodoList([List<Todo>? existingTodos]) : super(existingTodos ?? []);

  void addTodo(String title, int listLength) {
    state = [
      ...state,
      Todo(id: DateTime.now().millisecondsSinceEpoch, userId: (listLength + 1), title: title)
    ];
  }

  void toggleCompleted(int todoId) {
    state = [
      for (final todo in state)
        if (todo.id == todoId) todo.copyWith(completed: !todo.completed),
    ];
  }
}