import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wl_challenge/app/core/ui/styles/app_colors.dart';
import 'package:wl_challenge/app/core/ui/styles/text_styles.dart';
import 'package:wl_challenge/app/modules/todo/models/todo_model.dart';
import 'package:wl_challenge/app/modules/todo/views/widgets/deletable_todo_card.dart';
import 'package:wl_challenge/app/modules/todo/views/widgets/empty_info.dart';

import '../viewmodels/todo_view_model.dart';

class DoneView extends StatelessWidget {
  const DoneView({super.key});

  @override
  Widget build(BuildContext context) {
    final todos = context.select<TodoViewModel, List<Todo>>(
      (viewModel) => viewModel.todos.where((todo) => todo.isCompleted).toList(),
    );

    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26.0),
        child: Column(
          children: [
            const SizedBox(
              height: 32,
            ),
            Header(
              todos: todos,
            ),
            const SizedBox(
              height: 32,
            ),
            Expanded(
              child: todos.isEmpty
                  ? const EmptyInfo(
                      text: 'No tasks completed yet.',
                    )
                  : ListView.separated(
                      separatorBuilder: (context, index) {
                        return const SizedBox(
                          height: 16,
                        );
                      },
                      itemCount: todos.length,
                      itemBuilder: (context, index) {
                        final todo = todos[index];

                        return DeletableTodoCard(
                          title: todo.title,
                          onDelete: () {
                            context.read<TodoViewModel>().deleteTodo(todo.id);
                          },
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key, required this.todos});

  final List<Todo> todos;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'Completed Tasks',
          style: AppTextStyles.bold.copyWith(
            fontSize: 20,
            color: AppColors.slatePurple,
          ),
        ),
        const Spacer(),
        TextButton(
            onPressed: todos.isEmpty
                ? null
                : () async {
                    for (var todo in todos) {
                      await context.read<TodoViewModel>().deleteTodo(todo.id);
                    }
                  },
            child: Text(
              'Delete all',
              style: AppTextStyles.bold.copyWith(
                fontSize: 20,
                color: AppColors.fireRed,
              ),
            )),
      ],
    );
  }
}
