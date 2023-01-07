import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'model/todo_model.dart';

//自动释放数据
final todosProvider = StateNotifierProvider.autoDispose<TodosNotifier, List<Todo>>((ref) => TodosNotifier(ref));

//数据保存至app结束
// final todosProvider = StateNotifierProvider<TodosNotifier, List<Todo>>((ref) => TodosNotifier());

class TodosNotifier extends StateNotifier<List<Todo>> {
  final Ref<List<Todo>> ref;

  TodosNotifier(this.ref) : super([]);

  void add(Todo todo) {
    state.add(todo);
    ref.notifyListeners();
  }

  void remove(int todoId) {
    state.removeWhere((element) => element.id == todoId);
    ref.notifyListeners();
  }

  void toggle(int todoId) {
    var todo = state.firstWhere((element) => element.id == todoId);
    todo = todo.copyWith(completed: !todo.completed);
    int index = state.indexOf(todo);
    state[index].completed = !state[index].completed;
    ref.notifyListeners();
  }
}
