import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_app/models/todo.class.dart';
import 'package:freezed_app/models/user.class.dart';
import 'package:freezed_app/services/http_service.dart';

void main() {
  runApp(ProviderScope(child: const MyApp()));
}

final todosProvider = FutureProvider<List<Todo>>((_) async {
  final result = await getData('https://jsonplaceholder.typicode.com/todos');
  return result.map((res) => Todo.fromJson(res)).toList();
});

final todoWithUserProvider = FutureProvider<List<Todo>>((ref) async {
  final todos = await ref.watch(todosProvider.future);
  final result = await getData('https://jsonplaceholder.typicode.com/users');
  final users = result.map((user) => User.fromJson(user)).toList();
  print(users);

  return todos.map((todo) => todo.copyWith(userName: users.firstWhere((el) => todo.userId == el.id).name)).toList();
});

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Root(),
    );
  }
}

class Root extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final _todos = ref.watch(todoWithUserProvider);
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: _todos.when(
          error: (err, stack) => Text(err.toString()),
          loading: () => CircularProgressIndicator.adaptive(),
          data: (data) {
            return ListView.builder(
              itemCount: data.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text('${data[index].userName}', style: TextStyle(color: Colors.blue)),
                    subtitle: Text('${data[index].title}'),
                    leading: data[index].completed ? Icon(Icons.done, color: Colors.green) : Icon(Icons.close, color: Colors.red),
                  ),
                );
              },
            );
          }
        )
      ),
    );
  }
}


