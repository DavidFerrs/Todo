import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wl_challenge/app/core/ui/styles/styles.dart';
import 'package:wl_challenge/app/modules/todo/models/todo_model.dart';
import 'package:wl_challenge/app/modules/todo/viewmodels/todo_view_model.dart';
import 'package:wl_challenge/app/modules/todo/views/widgets/empty_info.dart';
import 'package:wl_challenge/app/modules/todo/views/widgets/expandable_todo_card.dart';


class HomeView extends StatefulWidget {
  const HomeView({super.key, this.create = false});

  final bool create;

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final todos = context.select<TodoViewModel, List<Todo>>(
      (viewModel) =>
          viewModel.todos.where((todo) => !todo.isCompleted).toList(),
    );

    final descrition = todos.isEmpty
        ? 'Create tasks to achieve more'
        : 'You`ve got ${todos.length} tasks to do.';

    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(left: 26.0, right: 26, top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Header(
                name: 'Jhon',
                descrition: descrition,
              ),
              Expanded(
                child: todos.isEmpty
                    ? const EmptyInfoWithButton()
                    : Padding(
                        padding: const EdgeInsets.only(top: 32.0),
                        child: ListView.separated(
                          separatorBuilder: (context, index) => const SizedBox(
                            height: 16,
                          ),
                          itemCount: todos.length,
                          itemBuilder: (context, index) {
                            final todo = todos[index];
                            return ExpandableTodoCard(
                              title: todo.title,
                              description: todo.description,
                              onCheckboxChanged: () {
                                context
                                    .read<TodoViewModel>()
                                    .toggleTodoCompletion(todo.id);
                              },
                              onOptionsTap: () {},
                              isCompleted: todo.isCompleted,
                            );
                          },
                        ),
                      ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Header extends StatelessWidget {
  const Header({super.key, required this.descrition, required this.name});

  final String descrition;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text.rich(TextSpan(children: [
          TextSpan(
            text: 'Welcome,',
            style: AppTextStyles.bold.copyWith(fontSize: 20),
          ),
          TextSpan(
            text: 'Jhon.',
            style: AppTextStyles.bold
                .copyWith(fontSize: 20, color: AppColors.blue),
          ),
        ])),
        Text(
          descrition,
          style: AppTextStyles.medium
              .copyWith(fontSize: 16, color: AppColors.slateBlue),
        ),
      ],
    );
  }
}

class EmptyInfoWithButton extends StatelessWidget {
  const EmptyInfoWithButton({super.key});

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TodoViewModel>();
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const EmptyInfo(text: 'You have no task listed.'),
        const SizedBox(
          height: 28,
        ),
        TextButton(
          style: TextButton.styleFrom(
            backgroundColor: AppColors.blue10,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
          ),
          onPressed: () {
            viewModel.toggleCreateModal(true);
          },
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.add,
                color: AppColors.blue,
              ),
              const SizedBox(width: 8),
              Text('Create task',
                  style: AppTextStyles.semiBold
                      .copyWith(color: AppColors.blue, fontSize: 18)),
            ],
          ),
        ),
      ],
    );
  }
}
