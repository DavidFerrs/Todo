import 'package:flutter/material.dart';
import 'package:wl_challenge/app/core/ui/styles/styles.dart';

class ExpandableTodoCard extends StatefulWidget {
  final String title;
  final String? description;
  final bool isCompleted;
  final void Function()? onCheckboxChanged;
  final VoidCallback onOptionsTap;

  const ExpandableTodoCard({
    super.key,
    required this.title,
    this.description,
    required this.isCompleted,
    required this.onCheckboxChanged,
    required this.onOptionsTap,
  });

  @override
  State<ExpandableTodoCard> createState() => _ExpandableTodoCardState();
}

class _ExpandableTodoCardState extends State<ExpandableTodoCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      padding: const EdgeInsets.all(8),
      constraints: const BoxConstraints(minHeight: 56),
      decoration: BoxDecoration(
        color: AppColors.paleWhite,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              /// Check box
              widget.isCompleted
                  ? Container(
                      height: 24,
                      width: 24,
                      decoration: BoxDecoration(
                        color: AppColors.blue,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Icon(
                        Icons.check_rounded,
                        color: AppColors.white,
                      ),
                    )
                  : InkWell(
                      onTap: widget.onCheckboxChanged,
                      child: Container(
                        height: 24,
                        width: 24,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          border:
                              Border.all(width: 2, color: AppColors.mutedAzure),
                        ),
                      ),
                    ),
              const SizedBox(
                width: 16,
              ),

              /// Title
              Expanded(
                child: Text(
                  widget.title,
                  style: AppTextStyles.semiBold.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.slatePurple,
                    decoration: widget.isCompleted
                        ? TextDecoration.lineThrough
                        : TextDecoration.none,
                  ),
                ),
              ),

              /// Button to show description
              if ((widget.description != null &&
                  widget.description!.isNotEmpty))
                GestureDetector(
                  onTap: () {
                    setState(() {
                      _isExpanded = !_isExpanded;
                    });
                  },
                  child: const Icon(
                    Icons.more_horiz_outlined,
                    size: 32,
                    color: AppColors.mutedAzure,
                  ),
                ),
            ],
          ),

          /// Expanded description
          if (_isExpanded &&
              (widget.description != null && widget.description!.isNotEmpty))
            Padding(
              padding: const EdgeInsets.only(left: 48, top: 8),
              child: Text(
                widget.description!,
                style: AppTextStyles.medium.copyWith(
                  fontSize: 14,
                  color: AppColors.slateBlue,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
