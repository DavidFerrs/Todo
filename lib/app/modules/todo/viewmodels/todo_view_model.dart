import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:wl_challenge/app/modules/todo/models/todo_model.dart';

class TodoViewModel extends ChangeNotifier {
  final Box<Todo> _todoBox;

  TodoViewModel(this._todoBox);

  List<Todo> get todos => _todoBox.values.toList();

  List<Todo> get todosSearch => _filter.isEmpty
      ? todos.where((todo) => !todo.isCompleted).toList()
      :
       todos.where((todo) {
          return !todo.isCompleted &&
              (todo.title.toLowerCase().contains(_filter.toLowerCase()));
        }).toList();

  String _filter = '';

  bool _showCreateModal = false;

  bool get showCreateModal => _showCreateModal;

  /// Activate Create modal bottom sheet
  void toggleCreateModal(bool value) {
    _showCreateModal = value;
    notifyListeners();
  }

  void filterList(String filter) {
    _filter = filter;
  }

  Future<void> addTodo(String title, String? description) async {
    final todo = Todo(
      id: DateTime.now().toIso8601String(),
      title: title,
      description: description,
    );
    await _todoBox.put(todo.id, todo);
    notifyListeners();
  }

  Future<void> updateTodo(String id, String newTitle) async {
    final todo = _todoBox.get(id);
    if (todo != null) {
      todo.title = newTitle;
      await _todoBox.put(id, todo);
      notifyListeners();
    }
  }

  Future<void> toggleTodoCompletion(String id) async {
    final todo = _todoBox.get(id);
    if (todo != null) {
      todo.isCompleted = !todo.isCompleted;
      await _todoBox.put(id, todo);
      notifyListeners();
    }
  }

  Future<void> deleteTodo(String id) async {
    await _todoBox.delete(id);
    notifyListeners();
  }
}
