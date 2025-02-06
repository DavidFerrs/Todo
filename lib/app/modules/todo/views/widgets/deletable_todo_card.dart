import 'package:flutter/material.dart';
import 'package:wl_challenge/app/core/ui/styles/app_colors.dart';
import 'package:wl_challenge/app/core/ui/styles/text_styles.dart';

class DeletableTodoCard extends StatelessWidget {
  final String title;
  final VoidCallback onDelete;

  const DeletableTodoCard({
    super.key,
    required this.title,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        color: AppColors.paleWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Container(
            height: 24,
            width: 24,
            decoration: BoxDecoration(
              color: AppColors.mutedAzure,
              borderRadius: BorderRadius.circular(8),
            ),
            child: const Icon(
              Icons.check_rounded,
              color: AppColors.white,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              title,
              style: AppTextStyles.semiBold.copyWith(
                fontSize: 16,
                color: AppColors.slateBlue,
              ),
            ),
          ),
          IconButton(
            onPressed: onDelete,
            icon: const Icon(
              Icons.delete,
              color: AppColors.fireRed,
            ),
          ),
        ],
      ),
    );
  }
}
