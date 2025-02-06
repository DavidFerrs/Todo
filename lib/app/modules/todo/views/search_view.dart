import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wl_challenge/app/core/ui/styles/styles.dart';
import 'package:wl_challenge/app/modules/todo/viewmodels/todo_view_model.dart';
import 'package:wl_challenge/app/modules/todo/views/widgets/empty_info.dart';
import 'package:wl_challenge/app/modules/todo/views/widgets/expandable_todo_card.dart';

class SearchView extends StatefulWidget {
  const SearchView({super.key});

  @override
  State<SearchView> createState() => _SearchViewState();
}

class _SearchViewState extends State<SearchView> {
  String query = "";
  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<TodoViewModel>();

    return GestureDetector(
      onTap: () => _focusNode.unfocus(),
      child: Scaffold(
        backgroundColor: AppColors.white,
        body: Padding(
          padding: const EdgeInsets.only(left: 26.0, right: 26, top: 32),
          child: Column(
            children: [
              /// Search field
              SearchField(
                searchController: _searchController,
                focusNode: _focusNode,
                onChanged: (value) {
                  setState(() {
                    viewModel.filterList(value);
                  });
                },
                onTap: () {
                  setState(() {
                    _searchController.clear();
                    viewModel.filterList('');
                  });
                },
              ),
              const SizedBox(height: 32),
              Expanded(
                child: viewModel.todosSearch.isEmpty
                    ? const EmptyInfo(text: 'No result found.')
                    : ListView.separated(
                        separatorBuilder: (context, index) => const SizedBox(
                          height: 16,
                        ),
                        itemCount: viewModel.todosSearch.length,
                        itemBuilder: (context, index) {
                          final todo = viewModel.todosSearch[index];
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
            ],
          ),
        ),
      ),
    );
  }
}

class SearchField extends StatelessWidget {
  const SearchField(
      {super.key,
      required this.searchController,
      required this.focusNode,
      this.onChanged,
      this.onTap});

  final TextEditingController searchController;
  final FocusNode focusNode;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      focusNode: focusNode,
      onChanged: onChanged,
      expands: false,
      decoration: InputDecoration(
        prefixIcon: Icon(
          Icons.search,
          color: focusNode.hasFocus ? AppColors.blue : AppColors.slateBlue,
        ),
        suffixIcon: searchController.text.isNotEmpty
            ? GestureDetector(
                onTap: onTap,
                child: Container(
                  margin: const EdgeInsets.all(12),
                  decoration: const BoxDecoration(
                    color: AppColors.mutedAzure, // Fundo cinza
                    shape: BoxShape.circle, // Forma circular
                  ),
                  child: const Icon(
                    weight: 12,
                    Icons.close, // Ícone de "X"
                    color: AppColors.paleWhite, // Cor do ícone
                    size: 12, // Tamanho do ícone
                  ),
                ),
              )
            : null,
        hintText: 'Search',
        hintStyle: AppTextStyles.semiBold,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: focusNode.hasFocus
                ? AppColors.blue50
                : Colors.grey, // Borda azul quando focado
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: AppColors.blue50,
            width: 2,
          ), // Azul quando focado
        ),
        filled: true,
        fillColor: AppColors.paleWhite,
      ),
    );
  }
}
