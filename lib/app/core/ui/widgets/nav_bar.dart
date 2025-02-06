import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:wl_challenge/app/core/navigation/app_constants.dart';
import 'package:wl_challenge/app/core/ui/styles/app_colors.dart';
import 'package:wl_challenge/app/modules/todo/viewmodels/todo_view_model.dart';

class NavigationData {
  const NavigationData(
      {required this.index, required this.label, required this.icon});

  final String label;
  final IconData icon;
  final int index;
}

const destinations = [
  NavigationData(index: 0, label: 'Todo', icon: Icons.checklist),
  NavigationData(index: 1, label: 'Create', icon: Icons.add),
  NavigationData(index: 2, label: 'Search', icon: Icons.search),
  NavigationData(index: 3, label: 'Done', icon: Icons.done),
];

class AppNavigationBar extends StatelessWidget {
  const AppNavigationBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Divider(color: AppColors.mutedAzure),
        NavigationBar(
          elevation: 200,
          indicatorColor: Colors.transparent,
          shadowColor: AppColors.black,
          backgroundColor: AppColors.white,
          labelBehavior: NavigationDestinationLabelBehavior.alwaysHide,
          selectedIndex: _calculateSelectedIndex(context),
          onDestinationSelected: (index) {
            switch (index) {
              case 0:
                context.go(RoutesConstants.home);
                break;
              case 1:
                context.read<TodoViewModel>().toggleCreateModal(true);
                context.go(RoutesConstants.create);
                break;
              case 2:
                context.go(RoutesConstants.search);
                break;
              case 3:
                context.go(RoutesConstants.done);
                break;
            }
          },
          destinations: destinations
              .map((destination) => NavigationDestination(
                    label: '',
                    icon: SelectableNavigationItem(
                      icon: destination.icon,
                      label: destination.label,
                      isSelected:
                          _calculateSelectedIndex(context) == destination.index,
                    ),
                  ))
              .toList(),
        ),
      ],
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final location = (GoRouter.of(context).state.path) ?? '/home';
    if (location.startsWith('/create')) return 1;
    if (location.startsWith('/search')) return 2;
    if (location.startsWith('/done')) return 3;
    return 0;
  }
}

class SelectableNavigationItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final bool isSelected;

  const SelectableNavigationItem({
    super.key,
    required this.icon,
    required this.label,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          icon,
          color: isSelected ? AppColors.blue : AppColors.mutedAzure,
          size: 28,
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: isSelected ? AppColors.blue : AppColors.slateBlue),
        ),
      ],
    );
  }
}

