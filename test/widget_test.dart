import 'package:flutter_test/flutter_test.dart';
import 'package:hive/hive.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:wl_challenge/app/modules/todo/models/todo_model.dart';
import 'package:wl_challenge/app/modules/todo/viewmodels/todo_view_model.dart';

import 'widget_test.mocks.dart';

// Generates annotations for mocking the Hive Box
@GenerateMocks([Box])
void main() {
  late MockBox<Todo> mockTodoBox;
  late TodoViewModel viewModel;

  setUp(() {
    mockTodoBox = MockBox<Todo>();
    viewModel = TodoViewModel(mockTodoBox);
  });

  group('TodoViewModel Tests', () {
    test('Should retrieve todos from the box', () {
      // Arrange
      final mockTodos = [
        Todo(id: '1', title: 'Todo 1', description: 'Description 1'),
        Todo(id: '2', title: 'Todo 2', description: 'Description 2'),
      ];
      when(mockTodoBox.values).thenReturn(mockTodos);

      // Act
      final todos = viewModel.todos;

      // Assert
      expect(todos.length, 2); // Ensures the list contains exactly 2 items.
      expect(todos[0].title, 'Todo 1'); // Checks that the title of the first todo is correct.
      expect(todos[1].title, 'Todo 2'); // Checks that the title of the second todo is correct.
    });

    test('Should add a new todo and notify listeners', () async {
      // Arrange
      const todoTitle = 'New Todo';
      const todoDescription = 'New Description';

      // Act
      await viewModel.addTodo(todoTitle, todoDescription);

      // Assert
      verify(mockTodoBox.put(
        // Verifies that the `put` method was called on the box with any dynamic ID
        // and with a Todo object that has the correct title and description values.
        any,
        argThat(
          isA<Todo>()
              .having((t) => t.title, 'title', todoTitle) // Checks that the todo title is 'New Todo'.
              .having((t) => t.description, 'description', todoDescription), // Checks that the todo description is 'New Description'.
        ),
      )).called(1); // Ensures that the `put` method was called exactly once.
    });

    test('Should update an existing todo and notify listeners', () async {
      // Arrange
      final todo = Todo(
        id: '1',
        title: 'Old Todo',
        description: 'Old Description',
      );
      when(mockTodoBox.get('1')).thenReturn(todo);

      // Act
      await viewModel.updateTodo('1', 'Updated Todo');

      // Assert
      expect(todo.title, 'Updated Todo'); // Checks that the todo title was updated correctly.
      verify(mockTodoBox.put('1', todo)).called(1); // Ensures the `put` method was called to update the todo in the box.
    });

    test('Should toggle completion status of a todo and notify listeners', () async {
      // Arrange
      final todo = Todo(
        id: '1',
        title: 'Todo',
        description: 'Description',
        isCompleted: false,
      );
      when(mockTodoBox.get('1')).thenReturn(todo);

      // Act
      await viewModel.toggleTodoCompletion('1');

      // Assert
      expect(todo.isCompleted, true); // Checks that the completion status was toggled to `true`.
      verify(mockTodoBox.put('1', todo)).called(1); // Ensures the `put` method was called to save the change in the box.
    });

    test('Should delete a todo and notify listeners', () async {
      // Act
      await viewModel.deleteTodo('1');

      // Assert
      verify(mockTodoBox.delete('1')).called(1); // Verifies that the `delete` method was called on the box with the correct ID.
    });
  });
}
