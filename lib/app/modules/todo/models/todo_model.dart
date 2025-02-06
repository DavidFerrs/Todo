


import 'package:hive/hive.dart';

part 'todo_model.g.dart';

@HiveType(typeId: 0) // Define o tipo do modelo
class Todo extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  String title;

  @HiveField(2)
  bool isCompleted;

  @HiveField(3)
  String? description; // Campo opcional para a descrição

  Todo({
    required this.id,
    required this.title,
    this.isCompleted = false,
    this.description,
  });
}