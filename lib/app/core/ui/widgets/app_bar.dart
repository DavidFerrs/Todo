import 'package:flutter/material.dart';
import 'package:wl_challenge/app/core/ui/styles/app_colors.dart';
import 'package:wl_challenge/app/core/ui/styles/text_styles.dart';

class TodoAppBar extends StatelessWidget implements PreferredSizeWidget {
  const TodoAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.white,
      leadingWidth: 150,
      leading: Row(
        children: [
          const SizedBox(width: 26),
          Container(
            height: 28,
            width: 28,
            decoration: BoxDecoration(
              color: AppColors.blue,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'Taski',
            style: AppTextStyles.bold.copyWith(
              color: AppColors.slatePurple,
              fontSize: 16,
            ),
          ),
        ],
      ),
      actions: [
        Row(
          children: [
            Text(
              'John',
              style: AppTextStyles.bold.copyWith(
                color: AppColors.slatePurple,
                fontSize: 16,
              ),
            ),
            const SizedBox(width: 8),
            const CircleAvatar(
              radius: 21,
              backgroundColor: AppColors.blue10,
              foregroundImage: AssetImage('assets/jhon.png'),
            ),
            const SizedBox(width: 26),
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
