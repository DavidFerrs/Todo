import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wl_challenge/app/core/helpers/size.dart';
import 'package:wl_challenge/app/core/navigation/app_constants.dart';
import 'package:wl_challenge/app/core/ui/styles/app_colors.dart';
import 'package:wl_challenge/app/core/ui/styles/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:wl_challenge/app/core/ui/widgets/app_bar.dart';
import 'package:wl_challenge/app/core/ui/widgets/nav_bar.dart';
import 'package:wl_challenge/app/modules/todo/viewmodels/todo_view_model.dart';

class AppDefaultPage extends StatelessWidget {
  const AppDefaultPage(
      {required this.child, this.bottomNavigatorBar, super.key});

  final Widget child;
  final Widget? bottomNavigatorBar;

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TodoViewModel>();

    // Verifica se o modal deve ser exibido
    if (viewModel.showCreateModal) {
      Future.microtask(() {
        if (context.mounted) {
          _showCreateTaskModal(context, viewModel);
        }
      });
    }
    return Scaffold(
      appBar: const TodoAppBar(),
      // ignore: prefer_const_constructors
      bottomNavigationBar: AppNavigationBar(),
      body: child,
      backgroundColor: AppColors.white,
    );
  }
}

void _showCreateTaskModal(BuildContext context, TodoViewModel viewModel) {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();

  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    barrierColor: Colors.transparent, // Fundo transparente
    constraints: BoxConstraints(maxHeight: context.percentHeight(50)),
    builder: (BuildContext context) {
      return Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 10,
              spreadRadius: 1,
              offset: const Offset(0, 0), // Sombra para baixo
            ),
          ],
        ),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: 'What`s in your mind?',
                hintStyle: AppTextStyles.medium
                    .copyWith(color: AppColors.mutedAzure, fontSize: 16),
                border: InputBorder.none, // Sem borda
                prefixIcon: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(width: 2, color: AppColors.mutedAzure),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Add a note...',
                hintStyle: AppTextStyles.medium
                    .copyWith(color: AppColors.mutedAzure, fontSize: 16),
                border: InputBorder.none, // Sem borda
                prefixIcon: const Icon(
                  Icons.edit,
                  color: AppColors.mutedAzure,
                  size: 24,
                ),
              ),
            ),
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: () {
                  final title = titleController.text.trim();
                  final description = descriptionController.text.trim();
                  if (title.isNotEmpty) {
                    viewModel.addTodo(title, description);
                    Navigator.of(context).pop();
                    context.go(RoutesConstants.home);
                    viewModel.toggleCreateModal(false);
                  }
                },
                child: Text(
                  'Create',
                  style: AppTextStyles.bold
                      .copyWith(color: AppColors.blue, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      );
    },
  ).whenComplete(() {
    viewModel.toggleCreateModal(false);
    if (context.mounted) {
      context.go(RoutesConstants.home);
    }
  });
}
