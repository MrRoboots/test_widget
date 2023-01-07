import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:test_stream/flutter_riverpod/page/state_norifier_provider_page/model/todo_model.dart';
import 'todos_notifier.dart';
import 'dart:math' as math;

class StateNotifierProviderTestPage extends ConsumerWidget {
  const StateNotifierProviderTestPage({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Todo> todoList = ref.watch(todosProvider);
    TodosNotifier notifier = ref.read(todosProvider.notifier);

    //监听值更改
    ref.listen(todosProvider, (previous, next) {
      //previous 上一次的值
      //next 当前更改值
    });
    return SafeArea(
      child: Scaffold(
        body: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                TextButton(onPressed: () => _add(notifier), child: const Text('添加数据')),
                TextButton(onPressed: () => _remove(todoList, notifier), child: const Text('删除数据')),
                TextButton(onPressed: () => _refresh(ref), child: const Text('重置数据')),
              ],
            ),
            Expanded(
              child: ListView.separated(
                  itemBuilder: (context, index) {
                    Todo todo = todoList[index];
                    return CheckboxListTile(
                      value: todo.completed,
                      onChanged: (value) => notifier.toggle(todo.id),
                      title: Text(todo.description),
                    );
                  },
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemCount: todoList.length),
            )
          ],
        ),
      ),
    );
  }

  //添加
  void _add(TodosNotifier notifier) {
    return notifier
        .add(Todo(id: math.Random().nextInt(100), completed: false, description: '添加数据${math.Random().nextInt(100)}'));
  }

  //删除
  void _remove(List<Todo> todoList, TodosNotifier notifier) {
    if (todoList.isNotEmpty) {
      notifier.remove(todoList.first.id);
    }
  }

  //重置数据
  void _refresh(ref) {
    ref.refresh(todosProvider);
  }
}
